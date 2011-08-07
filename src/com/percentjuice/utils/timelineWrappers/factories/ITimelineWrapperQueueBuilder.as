package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.factories.ITimelineWrapperBuilder;

	public interface ITimelineWrapperQueueBuilder extends ITimelineWrapperBuilder
	{
		function playWhenQueueEmpty(frame:Object):ITimelineWrapperQueueBuilder;

		function setQueueCompleteHandler(handler:Function):ITimelineWrapperQueueBuilder;

		function setOnceQueueCompleteHandler(handler:Function):ITimelineWrapperQueueBuilder;

		function setQueueCompleteHandlerParams(params:Array):ITimelineWrapperQueueBuilder;
	}
}
