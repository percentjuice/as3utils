package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperSetterHandlerParams
	{
		function addOnCompleteHandlerParams(params:Array):ITimelineWrapperSetter;

		function noOnCompleteHandlerParams():ITimelineWrapperSetter;
	}
}
