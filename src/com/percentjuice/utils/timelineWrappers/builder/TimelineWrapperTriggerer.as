package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperTriggerer extends TimelineWrapperCompleteBuilder implements ITimelineWrapperTriggerer
	{
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder
		{
			timelineWrapper.gotoAndPlay(frame, scene);
			return this;
		}

		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder
		{
			timelineWrapper.gotoAndStop(frame, scene);
			return this;
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder
		{
			timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
			return this;
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperCompleteBuilder
		{
			timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
			return this;
		}

		public function play():ITimelineWrapperCompleteBuilder
		{
			timelineWrapper.play();
			return this;
		}
	}
}
