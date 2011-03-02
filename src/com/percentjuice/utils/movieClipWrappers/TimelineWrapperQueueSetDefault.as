//------------------------------------------------------------------------------
//copyright 2010 
//------------------------------------------------------------------------------

package com.percentjuice.utils.movieClipWrappers
{
	import flash.display.MovieClip;
	/**
	 * Decorates TimelineWrapperQueue
	 * Provides ability to have 1 label play on a loop if nothing else is requested.
	 *
	 * adds props:
	 * * defaultRunning:Boolean
	 * adds methods:
	 * * setDefaultAnim(label:String):void
	 * * removeDefaultAnim():void
	 * * playDefaultLabel():void
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperQueueSetDefault implements ITimelineWrapper
	{
		public function TimelineWrapperQueueSetDefault(timelineWrapperQueue:TimelineWrapperQueue)
		{
			this.timelineWrapperQueue=timelineWrapperQueue;
			init();
		}

		private var timelineWrapperQueue:TimelineWrapperQueue;
		private var defaultAnim:Object;

		public function get wrappedMC():MovieClip
		{
			return timelineWrapperQueue.wrappedMC;
		}

		public function clearQueue():void
		{
			timelineWrapperQueue.clearQueue();
		}

		public function get currentLabel():String
		{
			return timelineWrapperQueue.currentLabel;
		}

		public function get currentFrame():int
		{
			return timelineWrapperQueue.currentFrame;
		}

		public function get totalFrames():int
		{
			return timelineWrapperQueue.totalFrames;
		}

		public function get defaultRunning():Boolean
		{
			return (timelineWrapperQueue.currentLabel == defaultAnim || timelineWrapperQueue.currentFrame == defaultAnim);
		}

		public function destroy():void
		{
			defaultAnim = null;
			timelineWrapperQueue.destroy();
//			timelineWrapperQueue = null;
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapperQueue.gotoAndStop(frame, scene);
		}

		public function playDefaultAnim():void
		{
			if (defaultAnim && !timelineWrapperQueue.playsQueuedUp && !isPlaying)
			{
				timelineWrapperQueue.gotoAndPlayUntilNextLabel(defaultAnim);
			}
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			timelineWrapperQueue.gotoAndPlayUntilNextLabel(frame, scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			stopDefaultAnim();
			timelineWrapperQueue.gotoAndPlayUntilStop(frame, stopOn, scene);
		}

		/**
		 * Stops defaultAnim if it's running.
		 * Plays label.
		 * @param label
		 */
		public function playWhenQueueEmpty(frame:Object):void
		{
			stopDefaultAnim();
			timelineWrapperQueue.playWhenQueueEmpty(frame);
		}

		public function removeDefaultAnim():void
		{
			defaultAnim=null;
			timelineWrapperQueue.signal_queueComplete.remove(playDefaultAnim);
		}

		public function setDefaultAnim(frame:Object):void
		{
			defaultAnim = frame;
			stopDefaultAnim();
			playDefaultAnim();
		}

		public function get signal_reachedStop():TimelineWrapperSignal
		{
			return timelineWrapperQueue.signal_reachedStop;
		}

		public function get signal_queueComplete():TimelineWrapperSignal
		{
			return timelineWrapperQueue.signal_queueComplete;
		}

		public function stop():void
		{
			timelineWrapperQueue.stop();
		}

		public function get isPlaying():Boolean
		{
			return timelineWrapperQueue.isPlaying;
		}

		private function init():void
		{
			defaultAnim = new String();
			timelineWrapperQueue.signal_queueComplete.add(handleQueueComplete);
		}

		private function handleQueueComplete(completedRequest:Object):void
		{
			playDefaultAnim();			
		}

		private function stopDefaultAnim():void
		{
			if (defaultRunning)
			{
				stop();
			}
		}
	}
}

