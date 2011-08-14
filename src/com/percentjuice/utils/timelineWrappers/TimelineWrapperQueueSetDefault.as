package com.percentjuice.utils.timelineWrappers
{
	import org.osflash.signals.DeluxeSignal;

	import flash.display.MovieClip;

	/**
	 * Decorates TimelineWrapperQueue
	 * Provides ability to have 1 label play on a loop if nothing else is requested.
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperQueueSetDefault implements ITimelineWrapper, ITimelineWrapperQueue, ITimelineWrapperQueueSetDefault
	{
		private var timelineWrapperQueue:TimelineWrapperQueue;
		private var defaultAnim:Object = new String();

		public function TimelineWrapperQueueSetDefault(timelineWrapperQueue:TimelineWrapperQueue)
		{
			this.timelineWrapperQueue = timelineWrapperQueue;
			init();
		}

		private function init():void
		{
			timelineWrapperQueue.queueComplete.add(handleQueueComplete);
			timelineWrapperQueue.onDestroy.target = this;
		}

		private function handleQueueComplete(...args):void
		{
			playDefaultAnim();
		}

		public function playDefaultAnim():void
		{
			if (defaultAnim && timelineWrapperQueue.isQueueEmpty && !isPlaying)
			{
				timelineWrapperQueue.gotoAndPlayUntilNextLabel(defaultAnim);
			}
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			timelineWrapperQueue.gotoAndPlayUntilNextLabel(frame, scene);
		}

		public function get defaultRunning():Boolean
		{
			return (timelineWrapperQueue.currentLabel == defaultAnim || timelineWrapperQueue.currentFrame == defaultAnim);
		}

		public function setDefaultAnim(frame:Object):void
		{
			defaultAnim = frame;
			stopDefaultAnim();
			playDefaultAnim();
		}

		private function stopDefaultAnim():void
		{
			if (defaultRunning)
			{
				stop();
			}
		}

		public function removeDefaultAnim():void
		{
			defaultAnim = null;
			timelineWrapperQueue.queueComplete.remove(playDefaultAnim);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			stopDefaultAnim();
			timelineWrapperQueue.gotoAndPlayUntilStop(frame, stopOn, scene);
		}

		/**
		 * Stops defaultAnim if it's running.
		 * Plays label or frame number passed in.
		 */
		public function playWhenQueueEmpty(frame:Object):void
		{
			stopDefaultAnim();
			timelineWrapperQueue.playWhenQueueEmpty(frame);
		}

		public function clearQueue():void
		{
			timelineWrapperQueue.clearQueue();
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapperQueue.gotoAndStop(frame, scene);
		}

		public function isQueueEmpty():Boolean
		{
			return timelineWrapperQueue.isQueueEmpty();
		}

		public function stop():void
		{
			timelineWrapperQueue.stop();
		}

		public function play():void
		{
			timelineWrapperQueue.play();
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			timelineWrapperQueue.gotoAndPlay(frame, scene);
		}

		public function destroy():void
		{
			defaultAnim = null;
			timelineWrapperQueue.destroy();
		}

		public function set wrappedMC(wrappedMC:MovieClip):void
		{
			timelineWrapperQueue.wrappedMC = wrappedMC;
		}

		public function set destroyAfterComplete(value:Boolean):void
		{
			timelineWrapperQueue.destroyAfterComplete = value;
		}

		public function get queueComplete():DeluxeSignal
		{
			return timelineWrapperQueue.queueComplete;
		}

		public function get wrappedMC():MovieClip
		{
			return timelineWrapperQueue.wrappedMC;
		}

		public function get isPlaying():Boolean
		{
			return timelineWrapperQueue.isPlaying;
		}

		public function get onComplete():DeluxeSignal
		{
			return timelineWrapperQueue.onComplete;
		}

		public function get onDestroy():DeluxeSignal
		{
			return timelineWrapperQueue.onDestroy;
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
	}
}

