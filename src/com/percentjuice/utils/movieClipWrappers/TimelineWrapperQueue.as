package com.percentjuice.utils.movieClipWrappers
{
	import flash.display.MovieClip;

	/**
	 * Decorates TimelineWrapper
	 * Adds ability to queue labelPlay requests.
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperQueue implements ITimelineWrapper, ITimelineWrapperQueue
	{
		private var timelineWrapper:ITimelineWrapper;
		private var _queueComplete:TimelineWrapperSignal;
		private var queueList:Array;

		public function TimelineWrapperQueue(timelineWrapper:TimelineWrapper)
		{
			this.timelineWrapper = timelineWrapper;
			init();
		}

		private function init():void
		{
			queueList = [];
			_queueComplete = new TimelineWrapperSignal(this);
			timelineWrapper.reachedStop.add(handleHitStopPointSignalDispatched);
		}

		private function handleHitStopPointSignalDispatched(signal:TimelineWrapperSignal):void
		{
			if (queueList.length)
			{
				gotoAndPlayUntilNextLabel(queueList.shift());
			}
			else
			{
				queueComplete.dispatchSignalClone(signal.completedRequest);
			}
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
		}

		/**
		 * Plays label or frame number passed in if not busy.
		 * Queues label or frame number if busy.
		 */
		public function playWhenQueueEmpty(frame:Object):void
		{
			if (!queueList.length && !isPlaying)
			{
				gotoAndPlayUntilNextLabel(frame);
			}
			else
			{
				queueList.push(frame);
			}
		}

		public function isQueueEmpty():Boolean
		{
			return (queueList.length == 0);
		}

		public function clearQueue():void
		{
			queueList.length = 0;
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndStop(frame, scene);
		}

		public function get totalFrames():int
		{
			return timelineWrapper.totalFrames;
		}

		public function play():void
		{
			timelineWrapper.play();
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndPlay(frame, scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
		}

		public function get reachedStop():TimelineWrapperSignal
		{
			return timelineWrapper.reachedStop;
		}

		public function get queueComplete():TimelineWrapperSignal
		{
			return _queueComplete;
		}

		public function stop():void
		{
			timelineWrapper.stop();
		}

		public function get isPlaying():Boolean
		{
			return timelineWrapper.isPlaying;
		}

		public function get wrappedMC():MovieClip
		{
			return timelineWrapper.wrappedMC;
		}

		public function get currentLabel():String
		{
			return timelineWrapper.currentLabel;
		}

		public function get currentFrame():int
		{
			return timelineWrapper.currentFrame;
		}

		public function destroy():void
		{
			_queueComplete.removeAll();
			_queueComplete = null;
			queueList = null;

			timelineWrapper.destroy();
		}
	}
}

