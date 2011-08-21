package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.timelineWrappers.support.MCLoaded;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class TimelineWrapperTest extends MCLoaded
	{
		private var timelineWrapper:ITimelineWrapper;
		private var start:Object;
		private var stop:Object;

		[Before]
		public function setup():void
		{
			timelineWrapper = new TimelineWrapper();
			start = {};
			stop = {};
		}

		[Test(async)]
		public function should_play_from_label_through_to_next():void
		{
			start = 'label0';
			timelineWrapper.wrappedMC = mcWithLabels;
			handleSignal(this, timelineWrapper.onComplete, handleLabelReached, 1000);
			
			timelineWrapper.gotoAndPlayUntilNextLabel(start);
		}

		private function handleLabelReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			var labelAtFrame1:String = propsForLabelsTest.assetLabels[0];
			var frameRightBeforeNextLabel:int = 9;

			assertThat(labelAtFrame1, equalTo(timelineWrapper.currentLabel));
			assertThat(frameRightBeforeNextLabel, equalTo(timelineWrapper.currentFrame));
		}

		[Test(async)]
		public function should_play_from_specific_frame_through_to_stop():void
		{
			start = 1;
			stop = 1;
			timelineWrapper.wrappedMC = mcWith1Frame;
			handleSignal(this, timelineWrapper.onComplete, handleStopReached, 3000);
			
			timelineWrapper.gotoAndPlayUntilStop(start, stop);
		}

		private function handleStopReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			assertThat(stop, equalTo(timelineWrapper.currentFrame));
		}

		[Test(async)]
		public function should_play_from_frame_through_to_end():void//params
		{
			timelineWrapper.wrappedMC = mcWithoutLabels;
			test_playing_from_frame_through_to_end(timelineWrapper);
			timelineWrapper.wrappedMC = mcWith1Frame;
			test_playing_from_frame_through_to_end(timelineWrapper);
		}

		private function test_playing_from_frame_through_to_end(timelineWrapper:ITimelineWrapper):void
		{
			handleSignal(this, timelineWrapper.onComplete, handleEndReached, 3000, timelineWrapper);
			timelineWrapper.gotoAndPlayUntilNextLabel(1);
		}

		[Test(async)]
		public function should_play_from_label_through_to_end():void
		{
			getTimelineWrapperWithLabelsAndListener().gotoAndPlayUntilNextLabel('label3');
		}

		[Test(async)]
		public function should_play_from_current_frame_through_to_end():void
		{
			timelineWrapper.wrappedMC = mcWithLabels;
			timelineWrapper.gotoAndStop(10);
			handleSignal(this, timelineWrapper.onComplete, handleEndReached, 3000, timelineWrapper);
			timelineWrapper.play();

			timelineWrapper.wrappedMC = mcWith1Frame;
			handleSignal(this, timelineWrapper.onComplete, handleEndReached, 500, timelineWrapper);
			timelineWrapper.play();
		}

		[Test(async)]
		public function should_play_from_specific_frame_through_to_end():void
		{
			getTimelineWrapperWithLabelsAndListener().gotoAndPlay(10);

			timelineWrapper.wrappedMC = mcWith1Frame;
			timelineWrapper.gotoAndPlay(1);
		}

		private function getTimelineWrapperWithLabelsAndListener():ITimelineWrapper
		{
			timelineWrapper.wrappedMC = mcWithLabels;
			handleSignal(this, timelineWrapper.onComplete, handleEndReached, 3000, timelineWrapper);
			return timelineWrapper;
		}

		private function handleEndReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			var requestDispatcher:ITimelineWrapper = ITimelineWrapper(passThroughData);

			assertThat(requestDispatcher.totalFrames, equalTo(requestDispatcher.currentFrame));
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function run_should_throw_error_if_used_after_destroy():void
		{
			timelineWrapper.wrappedMC = new MovieClip();
			timelineWrapper.destroy();

			should_throw_error_if_used_after_destroy(timelineWrapper);
		}

		public static function should_throw_error_if_used_after_destroy(timelineWrapper:ITimelineWrapper):void
		{
			assertThat(timelineWrapper.gotoAndPlayUntilStop(1, 2), throws(allOf(instanceOf(IllegalOperationError), hasPropertyWithValue("message", Assertions.ATTEMPTED_ACCESS_OF_DESTROYED_INSTANCE))));
		}
		
		[Test]
		public function destroy_should_not_harm_decorated():void
		{
			var movieClip:MovieClip = new MovieClip();
			timelineWrapper.wrappedMC = movieClip;
			
			timelineWrapper.destroy();
			
			assertThat(timelineWrapper.isDestroyed(), equalTo(true));
			assertThat(movieClip, notNullValue());
		}
	}
}