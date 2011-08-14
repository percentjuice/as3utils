package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperQueueSetterAndTriggerer
	{
		function setQueueCompleteHandler(handler:Function):ITimelineWrapperQueueSetterHandlerParams;

		function setOnceQueueCompleteHandler(handler:Function):ITimelineWrapperQueueSetterHandlerParams;

		function playWhenQueueEmpty(frame:Object):ITimelineWrapperQueueSetterAndTriggerer;
		
		function noAdditionalQueueOptions():ITimelineWrapperSetter;
	}
}
