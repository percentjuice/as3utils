package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperFactory;
	import com.percentjuice.utils.timelineWrappers.support.MovieClipsLoaded;

	import org.flexunit.async.Async;
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.times;
	import org.mockito.integrations.verify;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimelineWrapperBuilderTest extends MovieClipsLoaded
	{
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var rewrapHandler:IMockHandler;

		private static const TEST_PARAMS:Array = ["param0", 1, 2];

		private var test_results:Array = [];
		private var instanceTestWrapper:ITimelineWrapperQueueSetDefault;
		private var playing:Object;

		[Before]
		public function setup():void
		{
			test_results.length = 0;
			instanceTestWrapper = null;
			playing = null;
		}

		[After]
		public function tearDown():void
		{
			TimelineWrapperFactory.getInstance().destroy();
		}

		[Test(async)]
		public function should_set_onCompleteHandler_and_pass_params_on_dispatch():void
		{
			var builtWrapper:ITimelineWrapper = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithoutLabels)
				.setOnCompleteHandler(handleOnCompleteWithParams, false, TEST_PARAMS)
				.build();

			handleSignal(this, builtWrapper.onComplete, handleDispatchWithDelayedFunctionCall, 3000, testThatSetParamsEqualDispatchedParams);
			builtWrapper.gotoAndPlayUntilStop(1, 2);
		}

		private function handleDispatchWithDelayedFunctionCall(event:SignalAsyncEvent, passThroughData:*):void
		{
			var testFunction:Function = passThroughData as Function;

			Async.delayCall(this, testFunction, 500);
		}

		private function testThatSetParamsEqualDispatchedParams():void
		{
			assertThat(TEST_PARAMS, equalTo(test_results));
		}

		private function handleOnCompleteWithParams(param1:String, param2:int, param3:int):void
		{
			test_results = [param1, param2, param3];
		}

		[Test(async)]
		public function should_play_should_runQueue_should_RunDefault():void
		{
			playing = mcWithLabelsCollection[0].name;

			instanceTestWrapper = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithLabels)
				.addAutoPlayFunctionAndBuild()
				.gotoAndPlayUntilNextLabel(mcWithLabelsCollection[2].name)
				.addGotoAndPlayUntilNextLabelQueue([mcWithLabelsCollection[1].name])
				.addPlayLoopedWhenQueueEmpty(playing)
				.build();

			handleSignal(this, instanceTestWrapper.queueComplete, handleDispatchWithDelayedFunctionCall, 3000, testThatDefaultIsPlaying);
		}

		private function testThatDefaultIsPlaying():void
		{
			assertThat(instanceTestWrapper.isPlaying, isTrue());
			assertThat(instanceTestWrapper.currentLabel, equalTo(playing));
		}

		[Test(async)]
		public function should_destroy_after_complete():void
		{
			instanceTestWrapper = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithoutLabels)
				.setDestroyAfterComplete()
				.build();

			handleSignal(this, instanceTestWrapper.onComplete, handleDispatchWithDelayedFunctionCall, 1000, testThatDispatcherIsDestroyed);
			instanceTestWrapper.gotoAndPlayUntilStop(1, 2);
		}

		private function testThatDispatcherIsDestroyed():void
		{
			assertThat(instanceTestWrapper.isDestroyed(), isTrue());
		}

		/* stress test. includes case for Builder misuse. */
		[Test(async)]
		public function rewrappingPrevention_should_prevent_rewrapping_from_throwing_an_error():void
		{
			var timer:Timer = new Timer(100, 1);
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);

			Async.handleEvent(this, timer, TimerEvent.TIMER_COMPLETE, handleTimerComplete, 5000);
			timer.start();
		}

		private function handleTimerEvent(event:TimerEvent):void
		{
			var iteration:int = ((event.target) as Timer).currentCount;
			var modulo:Boolean = iteration % 2 == 0;

			if (modulo)
			{
				runParallelTestsWith(mcWithoutLabels, mcWithLabels);
			}
			else
			{
				runParallelTestsWith(mcWithLabels, mcWithoutLabels);
			}
		}

		private function runParallelTestsWith(testParam0:MovieClip, testParam1:MovieClip):void
		{
			testParam0.gotoAndStop(1);
			testParam1.gotoAndStop(1);

			runNewTimelineWrapper(testParam0);
			runNewTimelineWrapperQueue(testParam1);
		}

		private function runNewTimelineWrapper(wrapped:MovieClip):void
		{
			TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(wrapped)
				.setRewrappingPrevention()
				.setOnCompleteHandler(rewrapHandler.handleOnComplete)
				.addAutoPlayFunctionAndBuild()
				.gotoAndPlay(wrapped.totalFrames * .5)
				.build();
		}

		private function runNewTimelineWrapperQueue(wrapped:MovieClip):void
		{
			TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(wrapped)
				.setRewrappingPrevention()
				.setOnCompleteHandler(rewrapHandler.handleOnComplete)
				.addAutoPlayFunctionAndBuild()
				.addGotoAndPlayUntilNextLabelQueue([wrapped.totalFrames])
				.gotoAndPlay(1)
				.build();
		}

		private function handleTimerComplete(...args):void
		{
			Async.delayCall(this, handleOnComplete, 3000);
		}

		private function handleOnComplete():void
		{
			// only the last running ITimelineWrappers have enough time to complete the play method.
			verify(times(3)).that(rewrapHandler.handleOnComplete());
		}
	}
}
