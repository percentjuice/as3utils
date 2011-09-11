package com.percentjuice.utils.timelineWrappers.builder
{
	public interface ITimelineWrapperDestroyHandlerParams
	{
		function concatParamsToTimelineWrapper(concatParams:Array):ITimelineWrapperSetter;
		
		function noAdditionalOnDestroyHandlerParams():ITimelineWrapperSetter;
	}
}
