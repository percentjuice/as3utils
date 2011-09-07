package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.timelineWrappers.support.MovieClipsLoaded;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.FrameLabel;

	public class TimelineWrapperQueueTest extends MovieClipsLoaded
	{		
		private var timelineWrapper:TimelineWrapper;
		private var timelineWrapperQueue:TimelineWrapperQueue;

		[Before]
		public function setup():void
		{
			timelineWrapper = new TimelineWrapper();
			timelineWrapper.wrappedMC = mcWithLabels;
			timelineWrapperQueue = new TimelineWrapperQueue(timelineWrapper);
		}

		[Test(async)]
		public function should_show_final_frame_is_queued_request():void
		{
			handleSignal(this, timelineWrapperQueue.onComplete, handleLabelReached, 3000, [timelineWrapperQueue.onComplete, FrameLabel(mcWithLabels.currentLabels[1]).name]);
			handleSignal(this, timelineWrapperQueue.queueComplete, handleLabelReached, 3000, [timelineWrapperQueue.queueComplete, FrameLabel(mcWithLabels.currentLabels[3]).name]);

			timelineWrapperQueue.gotoAndPlayUntilNextLabel(FrameLabel(mcWithLabels.currentLabels[1]).name);
			timelineWrapperQueue.playWhenQueueEmpty(FrameLabel(mcWithLabels.currentLabels[3]).name);
		}

		private function handleLabelReached(event:SignalAsyncEvent, passThroughData:*):void
		{
			var signal:DeluxeSignal = passThroughData[0];
			var labelRequest:String = passThroughData[1];

			if (signal.target is TimelineWrapperQueue)
			{
				assertThat(labelRequest, equalTo(timelineWrapperQueue.currentLabel));
			}
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function run_should_throw_error_if_used_after_destroy():void
		{
			timelineWrapperQueue.destroy();
			
			TimelineWrapperTest.should_throw_error_if_used_after_destroy(timelineWrapperQueue);
		}
	}
}

