package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperSetter extends ITimelineWrapperFinish
	{
		function addDestroyAfterComplete():ITimelineWrapperSetter;
		
		function addRewrappingPrevention():ITimelineWrapperSetter;
		
		function setAFallbackLoopedAnimation(frame:Object):ITimelineWrapperSetter;

		function setOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter;

		function setOnceOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter;

		function setQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter;

		function setOnceQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter;

		function buildWithAutoPlayFunction():ITimelineWrapperPlayFinish;
	}
}
