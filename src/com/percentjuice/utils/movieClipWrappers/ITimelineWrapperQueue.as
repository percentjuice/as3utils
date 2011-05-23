package com.percentjuice.utils.movieClipWrappers
{
	/**
	 * @author C Stuempges
	 */
	public interface ITimelineWrapperQueue extends ITimelineWrapper
	{
		/* required methods */
		function clearQueue():void;
		function playWhenQueueEmpty(frame:Object):void;
		function isQueueEmpty():Boolean;
		/* required props */
		function get queueComplete():TimelineWrapperSignal;
	}
}

