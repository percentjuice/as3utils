package com.percentjuice.utils.timelineWrappers
{
	/**
	 * @author C Stuempges
	 */
	public interface ITimelineWrapperQueue extends ITimelineWrapper
	{
		/* required methods */
		function clearQueue():void;
		function appendToGotoAndPlayUntilNextLabelQueue(frames:Array):void;
		function isQueueEmpty():Boolean;
		function undecorate():ITimelineWrapper;
		/* required props */
		function get queueComplete():UntypedSignal;
	}
}

