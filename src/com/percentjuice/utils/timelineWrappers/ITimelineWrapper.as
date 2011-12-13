package com.percentjuice.utils.timelineWrappers
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
		function gotoAndPlay(frame:Object, scene:String = null):void;
		function gotoAndStop(frame:Object, scene:String = null):void;
		function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void;
		function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void;
		function play():void;
		function stop():void;
		function isDestroyed():Boolean;
		function destroy():void;
		/* setters */
		function set destroyAfterComplete(value:Boolean):void;
		function set wrappedMC(wrappedMC:MovieClip):void;
		/* required props */
		function get wrappedMC():MovieClip;
		function get onComplete():UntypedSignal;
		function get onDestroy():UntypedSignal;
		function get currentLabel():String;
		function get currentLabels():Array;
		function get currentFrame():int;
		function get totalFrames():int;
		function get isPlaying():Boolean;
	}
}

