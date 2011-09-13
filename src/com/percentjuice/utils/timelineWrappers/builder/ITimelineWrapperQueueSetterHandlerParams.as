package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperQueueSetterHandlerParams
	{
		function addQueueCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperQueueSetterAndTriggerer;
		
		function noQueueCompleteHandlerParams():ITimelineWrapperQueueSetterAndTriggerer;
	}
}
