package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	
	public interface ITimelineWrapperPlay
	{
		function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault;

		function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault;

		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperQueueSetDefault;

		function gotoAndPlayUntilNextLabelQueue(frames:Array):ITimelineWrapperQueueSetDefault;
		
		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperQueueSetDefault;

		function play():ITimelineWrapperQueueSetDefault;
	}
}
