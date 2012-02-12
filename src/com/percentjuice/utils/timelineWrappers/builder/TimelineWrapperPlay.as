package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	/* Instantiates and calls function directly -- ensures function is running before Params are set.
	 */
	public class TimelineWrapperPlay implements ITimelineWrapperPlay
	{
		private var timelineWrapperFinish:TimelineWrapperFinish;

		public function TimelineWrapperPlay(timelineWrapperFinish:TimelineWrapperFinish)
		{
			this.timelineWrapperFinish = timelineWrapperFinish;
		}
		
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapperFinish.timelineWrapper.gotoAndPlay(frame, scene);
			return timelineWrapperFinish.build();
		}

		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapperFinish.timelineWrapper.gotoAndStop(frame, scene);
			return timelineWrapperFinish.build();
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapperFinish.timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
			return timelineWrapperFinish.build();
		}

		public function gotoAndPlayUntilNextLabelQueue(frames:Array):ITimelineWrapperQueueSetDefault
		{
			TimelineWrapperFinish.builderDTO.playQueue = frames;
			return timelineWrapperFinish.build();
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapperFinish.timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
			return timelineWrapperFinish.build();
		}

		public function play():ITimelineWrapperQueueSetDefault
		{
			timelineWrapperFinish.timelineWrapper.play();
			return timelineWrapperFinish.build();
		}
	}
}
