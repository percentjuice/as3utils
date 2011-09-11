package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperCompleteHandlerParams
	{
		function addOnCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array):ITimelineWrapperSetter;

		function noOnCompleteHandlerParams():ITimelineWrapperSetter;
	}
}
