package com.percentjuice.utils.timelineWrappers.builder
{
	/* Instantiates and calls function directly to ensure function is running before Params are set.
	 */
	public class TimelineWrapperTriggerer extends TimelineWrapperCompleteBuilder implements ITimelineWrapperTriggerer
	{
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperTriggerer
		{
			timelineWrapper.gotoAndPlay(frame, scene);
			return this;
		}

		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperTriggerer
		{
			timelineWrapper.gotoAndStop(frame, scene);
			return this;
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperTriggerer
		{
			timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
			return this;
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperTriggerer
		{
			timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
			return this;
		}

		public function play():ITimelineWrapperTriggerer
		{
			timelineWrapper.play();
			return this;
		}

		public function addGotoAndPlayUntilNextLabelQueue(frames:Array):ITimelineWrapperTriggerer
		{
			builderDTO.playQueue = frames;
			return this;
		}

		public function addPlayLoopedWhenQueueEmpty(frame:Object):ITimelineWrapperTriggerer
		{
			builderDTO.playLoopedWhenQueueEmpty = frame;
			return this;
		}
	}
}
