package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperSetter extends ITimelineWrapperCompleteBuilder
	{
		function setOnCompleteHandler(handler:Function):ITimelineWrapperSetterHandlerParams;

		function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperSetterHandlerParams;

		function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperSetter;

		function setDestroyAfterComplete():ITimelineWrapperSetter;
		
		function setRewrappingPrevention():ITimelineWrapperSetter;
		
		function addQueuingAbility():ITimelineWrapperQueueSetterAndTriggerer;
		
		function addAutoPlayFunction():ITimelineWrapperTriggerer;
	}
}
