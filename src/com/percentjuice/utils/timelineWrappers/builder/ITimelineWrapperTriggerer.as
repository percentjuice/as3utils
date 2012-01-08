package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperTriggerer extends ITimelineWrapperCompleteBuilder
	{
		function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperTriggerer;

		function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperTriggerer;

		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperTriggerer;

		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperTriggerer;

		function play():ITimelineWrapperTriggerer;
		
		function addGotoAndPlayUntilNextLabelQueue(frames:Array):ITimelineWrapperTriggerer;

		function addPlayLoopedWhenQueueEmpty(frame:Object):ITimelineWrapperTriggerer;
	}
}
