package com.percentjuice.utils.movieClipWrappers
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.instanceOf;
	import org.osflash.signals.utils.*;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class TimelineWrapperTest
	{
		private static var propsForLabelsTest:MCProperties;
		private static var propsForNoLabelsTest:MCProperties;

		private static var mcLoader:MCLoader;
		private static var mcWithLabels:MovieClip;
		private static var mcWithoutLabels:MovieClip;

		[BeforeClass(async)]
		public static function setUpBeforeClass():void
		{
			propsForLabelsTest = MCProperties.mcWithLabels;
			propsForNoLabelsTest = MCProperties.mcWithoutLabels;

			mcLoader = new MCLoader();
			handleSignal(TimelineWrapperTest, mcLoader.signal_loadComplete, TimelineWrapperTest.handleMovieWithLabelsLoaded, 1000);
			mcLoader.load(propsForLabelsTest);
		}

		private static function handleMovieWithLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithLabels = MovieClip(event.args[1]);

			handleSignal(TimelineWrapperTest, mcLoader.signal_loadComplete, TimelineWrapperTest.handleMovieWithoutLabelsLoaded, 1000);
			mcLoader.load(propsForNoLabelsTest);
		}

		private static function handleMovieWithoutLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithoutLabels = MovieClip(event.args[1]);
			mcLoader = null;
		}

		[Test(async)]
		public function should_play_from_label_through_to_next():void
		{
			var timelineWrapperForLabelsTest:TimelineWrapper = new TimelineWrapper(mcWithLabels);
			handleSignal(this, timelineWrapperForLabelsTest.signal_reachedStop, handleLabelReached, 1000);
			timelineWrapperForLabelsTest.gotoAndPlayUntilNextLabel(2);
		}

		private function handleLabelReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			var signal:TimelineWrapperSignal = event.args[0];
			var requestDispatcher:ITimelineWrapper = signal.dispatcher;

			var labelAtFrame1:String = propsForLabelsTest.assetLabels[0];
			var frameRightBeforeNextLabel:int = 9;

			assertThat(labelAtFrame1, equalTo(requestDispatcher.currentLabel));
			assertThat(frameRightBeforeNextLabel, equalTo(requestDispatcher.currentFrame));
		}

		[Test(async)]
		public function should_play_from_frame_through_to_end():void
		{
			var timelineWrapperForNoLabelsTest:TimelineWrapper = new TimelineWrapper(mcWithoutLabels);
			handleSignal(this, timelineWrapperForNoLabelsTest.signal_reachedStop, handleEndReached, 3000);
			timelineWrapperForNoLabelsTest.gotoAndPlayUntilNextLabel(1);
		}

		[Test(async)]
		public function should_play_from_label_through_to_end():void
		{
			var timelineWrapperForLabelsTest:TimelineWrapper = new TimelineWrapper(mcWithLabels);
			handleSignal(this, timelineWrapperForLabelsTest.signal_reachedStop, handleEndReached, 3000);
			timelineWrapperForLabelsTest.gotoAndPlayUntilNextLabel('label3');
		}

		private function handleEndReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			var signal:TimelineWrapperSignal = event.args[0];
			var requestDispatcher:ITimelineWrapper = signal.dispatcher;

			assertThat(requestDispatcher.totalFrames, equalTo(requestDispatcher.currentFrame));
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function should_throw_error_if_used_after_destroy():void
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper(new MovieClip());
			timelineWrapper.destroy();
			assertThat(timelineWrapper.gotoAndPlayUntilStop(1, 2), throws(allOf(instanceOf(IllegalOperationError), hasPropertyWithValue("message", TimelineWrapperAssertions.ATTEMPTED_ACCESS_OF_DESTROYED_INSTANCE))));
		}
	}
}

