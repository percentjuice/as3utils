package com.percentjuice.utils.movieClipWrappers
{
	import com.percentjuice.utils.movieClipWrappers.support.MCLoader;
	import com.percentjuice.utils.movieClipWrappers.support.MCProperties;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.MovieClip;


	public class TimelineWrapperQueueTest
	{		
		public static var mcWithLabelsLoader:MCLoader;
		private static var mcWithLabels:MovieClip;

		private static var propsForLabelsTest:MCProperties;
		private static var propsForNoLabelsTest:MCProperties;

		[BeforeClass(async)]
		public static function setUpBeforeClass():void
		{
			propsForLabelsTest = MCProperties.mcWithLabels;
			propsForNoLabelsTest = MCProperties.mcWithoutLabels;

			mcWithLabelsLoader = new MCLoader();
			mcWithLabelsLoader.load(propsForLabelsTest);
			handleSignal(TimelineWrapperQueueTest, mcWithLabelsLoader.signal_loadComplete, TimelineWrapperQueueTest.handleLoadComplete, 3000, null);
		}

		private static function handleLoadComplete(event:SignalAsyncEvent, none:*):void
		{
			mcWithLabels = event.args[1];
			mcWithLabelsLoader = null;
		}

		[Test(async)]
		public function should_show_final_frame_is_queued_request():void
		{
			var timelineWrapperQueue:TimelineWrapperQueue = new TimelineWrapperQueue(new TimelineWrapper(mcWithLabels));

			handleSignal(this, timelineWrapperQueue.reachedStop, handleLabelReached, 3000, propsForLabelsTest.assetLabels[1]);
			handleSignal(this, timelineWrapperQueue.queueComplete, handleLabelReached, 3000, propsForLabelsTest.assetLabels[3]);

			timelineWrapperQueue.gotoAndPlayUntilNextLabel(propsForLabelsTest.assetLabels[1]);
			timelineWrapperQueue.playWhenQueueEmpty(propsForLabelsTest.assetLabels[3]);
		}

		private function handleLabelReached(event:SignalAsyncEvent, labelRequest:String):void
		{
			var signal:TimelineWrapperSignal = event.args[0];
			var completedReq:String = signal.completedRequest as String;
			var requestDispatcher:ITimelineWrapper = signal.dispatcher;

			assertThat(labelRequest, equalTo(completedReq));
			if (requestDispatcher is TimelineWrapperQueue)
			{
				assertThat(labelRequest, equalTo(requestDispatcher.currentLabel));
			}
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function run_should_throw_error_if_used_after_destroy():void
		{
			var timelineWrapperQueue:TimelineWrapperQueue = new TimelineWrapperQueue(new TimelineWrapper(new MovieClip));
			TimelineWrapperTest.should_throw_error_if_used_after_destroy(timelineWrapperQueue);
		}
	}
}

