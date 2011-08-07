package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;

	public interface ITimelineWrapperBuilder
	{
		function setOnCompleteHandler(handler:Function):ITimelineWrapperBuilder;

		function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperBuilder;

		function setOnCompleteHandlerParams(params:Array):ITimelineWrapperBuilder;

		function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperBuilder;

		function setDestroyAfterComplete():ITimelineWrapperBuilder;

		function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperBuilder;

		function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperBuilder;

		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperBuilder;

		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperBuilder;

		function play():ITimelineWrapperBuilder;

		function stop():ITimelineWrapperBuilder;

		function build():ITimelineWrapper;
	}
}
