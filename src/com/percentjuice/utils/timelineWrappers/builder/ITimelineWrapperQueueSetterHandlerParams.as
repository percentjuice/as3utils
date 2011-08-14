package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperQueueSetterHandlerParams
	{
		function addQueueCompleteHandlerParams(params:Array):ITimelineWrapperQueueSetterAndTriggerer;
		
		function noQueueCompleteHandlerParams():ITimelineWrapperQueueSetterAndTriggerer;
	}
}
