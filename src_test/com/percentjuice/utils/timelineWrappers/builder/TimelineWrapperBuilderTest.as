package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperFactory;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.support.MovieClipsLoaded;

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
	import flash.utils.setTimeout;

	public class TimelineWrapperBuilderTest extends MovieClipsLoaded
	{
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var rewrapHandler:IMockHandler;

		private static const TEST_PARAMS:Array = ["param0", 1, 2];

		private var test_results:Array = [];
		private var builtWrapperDestroy:ITimelineWrapper;

		[Before]
		public function setup():void
		{
			test_results.length = 0;
			builtWrapperDestroy = null;
		}
		
		[After]
		public function tearDown():void
		{
			TimelineWrapperFactory.getInstance().destroy();
		}

		[Test(async)]
		public function should_set_onDestroyHandler_and_pass_params_on_dispatch():void
		{
			builtWrapperDestroy = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithoutLabels)
				.setOnceOnDestroyHandler(handleOnDestroyWithParams)
				.concatParamsToTimelineWrapper(TEST_PARAMS)
				.build();

			handleSignal(this, builtWrapperDestroy.onDestroy, handleDispatchWithDelayedFunctionCall, 1000, testThatSetParamsEqualDispatchedParams);
			builtWrapperDestroy.destroy();
		}

		[Test(async)]
		public function should_set_onCompleteHandler_and_pass_params_on_dispatch():void
		{
			var builtWrapper:ITimelineWrapper = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithoutLabels)
				.setOnCompleteHandler(handleOnCompleteWithParams)
				.addOnCompleteHandlerParams(false, TEST_PARAMS)
				.build();

			handleSignal(this, builtWrapper.onComplete, handleDispatchWithDelayedFunctionCall, 1000, testThatSetParamsEqualDispatchedParams);
			builtWrapper.gotoAndPlayUntilStop(1, 2);
		}

		private function handleDispatchWithDelayedFunctionCall(event:SignalAsyncEvent, passThroughData:*):void
		{
			var testFunction:Function = passThroughData as Function;

			setTimeout(testFunction, 100);
		}

		private function testThatSetParamsEqualDispatchedParams():void
		{
			assertThat(TEST_PARAMS, equalTo(test_results));
		}

		private function handleOnCompleteWithParams(param1:String, param2:int, param3:int):void
		{
			test_results = [param1, param2, param3];
		}

		private function handleOnDestroyWithParams(param0:ITimelineWrapper, param1:String, param2:int, param3:int):void
		{
			assertThat(param0, equalTo(builtWrapperDestroy));
			test_results = [param1, param2, param3];
		}

		[Test(async)]
		public function should_destroy_after_complete():void
		{
			builtWrapperDestroy = TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(mcWithoutLabels)
				.setDestroyAfterComplete()
				.build();

			handleSignal(this, builtWrapperDestroy.onComplete, handleDispatchWithDelayedFunctionCall, 1000, testThatDispatcherIsDestroyed);
			builtWrapperDestroy.gotoAndPlayUntilStop(1, 2);
		}

		private function testThatDispatcherIsDestroyed():void
		{
			assertThat(builtWrapperDestroy.isDestroyed(), isTrue());
		}

		[Test(async)]
		public function rewrappingPrevention_should_prevent_rewrapping_from_throwing_an_error():void
		{
			var timer:Timer = new Timer(100, 10);
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true);
			timer.start();
		}

		private function handleTimerEvent(event:TimerEvent):void
		{
			var iteration:int = ((event.target) as Timer).currentCount;
			var modulo:Boolean = iteration % 2 == 0;
			if (modulo)
			{
				runNewTimelineWrapper(mcWithoutLabels);
				runNewTimelineWrapperQueue(mcWithLabels);
			}
			else
			{
				runNewTimelineWrapper(mcWithLabels);
				runNewTimelineWrapperQueue(mcWithoutLabels);
			}
		}

		private function runNewTimelineWrapperQueue(wrapped:MovieClip):void
		{
			TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(wrapped)
				.setRewrappingPrevention()
				.addQueuingAbility()
				.playWhenQueueEmpty(wrapped.totalFrames)
				.noAdditionalQueueOptions()
				.setOnCompleteHandler(rewrapHandler.handleOnComplete)
				.addOnCompleteHandlerParams(false, [new Object])
				.addAutoPlayFunction()
				.gotoAndStop(wrapped.totalFrames)
				.build();
		}

		private function runNewTimelineWrapper(wrapped:MovieClip):void
		{
			TimelineWrapperBuilder
				.initialize()
				.setWrappedMC(wrapped)
				.setRewrappingPrevention()
				.setOnCompleteHandler(rewrapHandler.handleOnComplete)
				.addOnCompleteHandlerParams(false, [new Object])
				.addAutoPlayFunction()
				.gotoAndStop(wrapped.totalFrames)
				.build();
		}

		private function handleTimerComplete(event:TimerEvent):void
		{
			setTimeout(handleOnComplete, 3000);
		}

		private function handleOnComplete():void
		{
			// only the last ITimelineWrapper has enough time to complete the play method.
			verify(times(2)).that(rewrapHandler.handleOnComplete());
		}
	}
}
