package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperSetter extends ITimelineWrapperCompleteBuilder
	{
		function setOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter;

		function setOnceOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter;

		function setQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter;

		function setOnceQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter;
		
		function playWhenQueueEmpty(frame:Object):ITimelineWrapperSetter;

		function setDefaultAnimation(frame:Object):ITimelineWrapperSetter;

		function setDestroyAfterComplete():ITimelineWrapperSetter;
		
		function setRewrappingPrevention():ITimelineWrapperSetter;
		
		function addAutoPlayFunctionAndBuild():ITimelineWrapperTriggerer;
	}
}
