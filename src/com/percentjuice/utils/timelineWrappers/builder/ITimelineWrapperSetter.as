package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperSetter extends ITimelineWrapperCompleteBuilder
	{
		function setOnCompleteHandler(handler:Function):ITimelineWrapperCompleteHandlerParams;

		function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperCompleteHandlerParams;

		function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperDestroyHandlerParams;

		function setDestroyAfterComplete():ITimelineWrapperSetter;
		
		function setRewrappingPrevention():ITimelineWrapperSetter;
		
		function addQueuingAbility():ITimelineWrapperQueueSetterAndTriggerer;
		
		function addAutoPlayFunction():ITimelineWrapperTriggerer;
	}
}
