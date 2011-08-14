package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperTriggerer
	{
		function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder;

		function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder;

		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperCompleteBuilder;

		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperCompleteBuilder;

		function play():ITimelineWrapperCompleteBuilder;
	}
}
