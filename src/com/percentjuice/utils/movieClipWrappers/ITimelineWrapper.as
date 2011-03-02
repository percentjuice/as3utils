//------------------------------------------------------------------------------
//copyright 2010 
//------------------------------------------------------------------------------

package com.percentjuice.utils.movieClipWrappers
{
	import flash.display.MovieClip;

	/**
	 * Implementers of ITimelineAnim decorate a MovieClip with labels on its timeline.
	 * All TimelineAnims or Decorators of TimelineAnims must implement this.
	 * @author C Stuempges
	 */
	public interface ITimelineWrapper
	{
		/* required methods */
		function gotoAndStop(frame:Object, scene:String = null):void;
		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void;
		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void;
		function stop():void;
		function destroy():void;
		/* required props */
		function get wrappedMC():MovieClip;
		function get currentLabel():String;
		function get currentFrame():int;
		function get totalFrames():int;
		function get isPlaying():Boolean;
		function get signal_reachedStop():TimelineWrapperSignal;
	}
}

