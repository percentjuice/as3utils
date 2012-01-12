package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.timelineWrappers.support.MovieClipsLoaded;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TimelineWrapperTest extends MovieClipsLoaded
	{
		private static const NO_FRAME:int = 0;
		private static const NO_NAME:String = "";
		
		private var timelineWrapper:ITimelineWrapper;
		private var timelineWrapperLabels:ITimelineWrapper;
		private var timelineWrapperNoLabels:ITimelineWrapper;

		private var movieClip:MovieClip;

		[Before]
		public function setup():void
		{
			movieClip = new MovieClip();

			timelineWrapper = new TimelineWrapper();
			timelineWrapper.wrappedMC = movieClip;

			timelineWrapperLabels = new TimelineWrapper();
			timelineWrapperLabels.wrappedMC = mcWithLabels;

			timelineWrapperNoLabels = new TimelineWrapper();
			timelineWrapperNoLabels.wrappedMC = mcWithoutLabels;
		}

		[Test(async)]
		public function should_play_to_end_of_timeline():void
		{
			playFunctionWithParam(timelineWrapperLabels, timelineWrapperLabels.play, null);

			playFunctionWithParam(timelineWrapperNoLabels, timelineWrapperNoLabels.play, null);
		}

		private function playFunctionWithParam(testObject:ITimelineWrapper, testExecution:Function, params:*):void
		{
			handleSignal(this, timelineWrapperNoLabels.onComplete, handleShouldBeAtTotalFrames, 5000, testObject);

			if (params == null)
				testExecution();
			else
				testExecution(params);
		}

		private function handleShouldBeAtTotalFrames(event:SignalAsyncEvent, timelineWrapper:ITimelineWrapper):void
		{
			assertThat(timelineWrapper.currentFrame, equalTo(timelineWrapper.totalFrames));
		}

		public static function playPointsTestData():Array
		{
			return [[1], [10], [20], [30], [40]];
		}

		[Test(dataProvider="playPointsTestData",async)]
		public function should_gotoAndPlay_to_end_of_timeline(input:Object):void
		{
			playFunctionWithParam(timelineWrapperLabels, timelineWrapperLabels.gotoAndPlay, input);

			playFunctionWithParam(timelineWrapperNoLabels, timelineWrapperNoLabels.gotoAndPlay, input);
			playFunctionWithParam(timelineWrapperNoLabels, timelineWrapperNoLabels.gotoAndPlayUntilNextLabel, input);
		}

		public static function playExpectedResultTestData():Array
		{
			return 	[
					[new FrameLabel(NO_NAME, 1), new FrameLabel(null, 1)],
					[new FrameLabel(NO_NAME, 2), new FrameLabel("label0", 9)],
					[new FrameLabel("label0", NO_FRAME), new FrameLabel("label0", 9)],
					[new FrameLabel(NO_NAME, 30), new FrameLabel("label3", 40)],
					[new FrameLabel("label3", NO_FRAME), new FrameLabel("label3", 40)]
					];
		}

		[Test(dataProvider="playExpectedResultTestData",async)]
		public function should_gotoAndPlay_to_expectedResult(play:FrameLabel, expectedResult:FrameLabel):void
		{
			var playObject:Object = (play.frame == NO_FRAME) ? play.name : play.frame;
			
			handleSignal(this, timelineWrapperLabels.onComplete, handleShouldBeAtExpectedResult, 5000, expectedResult);
			
			timelineWrapperLabels.gotoAndPlayUntilNextLabel(playObject);
		}

		private function handleShouldBeAtExpectedResult(event:SignalAsyncEvent, expectedResult:FrameLabel):void
		{
			assertThat(timelineWrapperLabels.currentLabel, equalTo(expectedResult.name));
			assertThat(timelineWrapperLabels.currentFrame, equalTo(expectedResult.frame));
		}

		public static function playStopTestData():Array
		{
			return 	[
					[new FrameLabel(NO_NAME, 1), new FrameLabel(NO_NAME, 1)],
					[new FrameLabel(NO_NAME, 2), new FrameLabel(NO_NAME, 10)],
					[new FrameLabel("label0", NO_FRAME), new FrameLabel("label1", NO_FRAME)],
					[new FrameLabel(NO_NAME, 10), new FrameLabel(NO_NAME, 30)],
					[new FrameLabel("label1", NO_FRAME), new FrameLabel("label3", NO_FRAME)],
					[new FrameLabel("label3", NO_FRAME), new FrameLabel("label3", NO_FRAME)],
					[new FrameLabel("label3", NO_FRAME), new FrameLabel(NO_NAME, 40)],
					];
		}

		[Test(dataProvider="playStopTestData",async)]
		public function should_gotoAndPlay_to_stop(play:FrameLabel, stop:FrameLabel):void
		{
			var playParam:Object = (play.frame == NO_FRAME) ? play.name : play.frame;
			var stopParam:Object = (stop.frame == NO_FRAME) ? stop.name : stop.frame;
			
			handleSignal(this, timelineWrapperLabels.onComplete, handleShouldBeAtStop, 5000, stopParam);
			
			timelineWrapperLabels.gotoAndPlayUntilStop(playParam, stopParam);
		}

		private function handleShouldBeAtStop(event:SignalAsyncEvent, stopParam:Object):void
		{
			var timelineWrapperResult:Object;
			
			if (stopParam is String)
			{
				timelineWrapperResult = timelineWrapperLabels.currentLabel;
			}
			else
			{
				timelineWrapperResult = timelineWrapperLabels.currentFrame;
			}
			
			assertThat(timelineWrapperResult, equalTo(stopParam));
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function run_should_throw_error_if_used_after_destroy():void
		{
			timelineWrapper.destroy();
			should_throw_error_if_used_after_destroy(timelineWrapper);
		}

		public static function should_throw_error_if_used_after_destroy(timelineWrapper:ITimelineWrapper):void
		{
			assertThat(timelineWrapper.gotoAndPlayUntilStop(1, 2), throws(allOf(instanceOf(IllegalOperationError), hasPropertyWithValue("message", Assertions.ATTEMPTED_OPERATION_ON_NULL_INSTANCE))));
		}

		[Test]
		public function destroy_should_not_harm_decorated():void
		{
			timelineWrapper.destroy();

			assertThat(timelineWrapper.isDestroyed(), isTrue());
			assertThat(movieClip, notNullValue());
		}
	}
}