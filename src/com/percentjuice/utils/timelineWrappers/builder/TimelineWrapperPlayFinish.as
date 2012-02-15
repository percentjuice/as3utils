package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	
	/* Instantiates and calls function directly -- ensures function is running before Params are set. */
	public class TimelineWrapperPlayFinish extends TimelineWrapperFinish implements ITimelineWrapperPlayFinish
	{
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapper.gotoAndPlay(frame, scene);
			return build();
		}

		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapper.gotoAndStop(frame, scene);
			return build();
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
			return build();
		}

		public function gotoAndPlayUntilNextLabelQueue(frames:Array):ITimelineWrapperQueueSetDefault
		{
			builderDTO.playQueue = frames;
			return build();
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperQueueSetDefault
		{
			timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
			return build();
		}

		public function play():ITimelineWrapperQueueSetDefault
		{
			timelineWrapper.play();
			return build();
		}
	}
}
