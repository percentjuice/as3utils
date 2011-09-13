package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperCompleteHandlerParams
	{
		function addOnCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter;

		function noOnCompleteHandlerParams():ITimelineWrapperSetter;
	}
}
