package com.percentjuice.utils.movieClipWrappers
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapperQueue;

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
