package com.percentjuice.utils.timelineWrappers
{
	import org.osflash.signals.DeluxeSignal;
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
		function get queueComplete():DeluxeSignal;
	}
}

