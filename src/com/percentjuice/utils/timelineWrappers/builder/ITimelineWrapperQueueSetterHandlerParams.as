package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperQueueSetterHandlerParams
	{
		function addQueueCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array):ITimelineWrapperQueueSetterAndTriggerer;
		
		function noQueueCompleteHandlerParams():ITimelineWrapperQueueSetterAndTriggerer;
	}
}
