package com.percentjuice.utils.timelineWrappers
{

	public interface ITimelineWrapperQueueSetDefault extends ITimelineWrapper, ITimelineWrapperQueue
	{
		/* required methods */
		function setDefaultAnim(frame:Object):void;
		function playDefaultAnim():void;
		function removeDefaultAnim():void;
		/* required props */
		function get defaultRunning():Boolean;
	}
}
