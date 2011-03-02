//------------------------------------------------------------------------------
//copyright 2010 
//------------------------------------------------------------------------------

package com.percentjuice.utils.movieClipWrappers
{
	import flash.display.MovieClip;
	/**
	 * Decorates TimelineWrapper
	 * Adds ability to queue labelPlay requests.
	 *
	 * adds props:
	 * * signal_queueComplete:TimelineWrapperSignal
	 * adds methods:
	 * * playLabelWhenReady(label:String):void
	 * * clearQueue():void
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperQueue implements ITimelineWrapper
	{
		public function TimelineWrapperQueue(timelineWrapper:TimelineWrapper)
		{
			this.timelineWrapper=timelineWrapper;
			init();
		}

		private var timelineWrapper:TimelineWrapper;
		private var _signal_queueComplete:TimelineWrapperSignal;
		private var queueList:Array;

		public function clearQueue():void
		{
			queueList.length=0;
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
			_signal_queueComplete.removeAll();
			_signal_queueComplete = null;
			queueList = null;

			timelineWrapper.destroy();
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndStop(frame, scene);
		}

		public function get totalFrames():int
		{
			return timelineWrapper.totalFrames;
		}

		public function get playsQueuedUp():Boolean
		{
			return (queueList.length!=0);
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndPlayUntilNextLabel(frame, scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			timelineWrapper.gotoAndPlayUntilStop(frame, stopOn, scene);
		}

		/**
		 * Plays frame if not busy.
		 * Queues frame if busy.
		 * @param frame
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

		public function get signal_reachedStop():TimelineWrapperSignal
		{
			return timelineWrapper.signal_reachedStop;
		}

		public function get signal_queueComplete():TimelineWrapperSignal
		{
			return _signal_queueComplete;
		}

		public function stop():void
		{
			timelineWrapper.stop();
		}

		public function get isPlaying():Boolean
		{
			return timelineWrapper.isPlaying;
		}

		private function handleHitStopPointSignalDispatched(signal:TimelineWrapperSignal):void
		{
			if (queueList.length)
			{
				gotoAndPlayUntilNextLabel(queueList.shift());
			}
			else
			{
				signal_queueComplete.dispatchSignalClone(signal.completedRequest);
			}
		}

		private function init():void
		{
			queueList = [];
			_signal_queueComplete = new TimelineWrapperSignal(this);
			timelineWrapper.signal_reachedStop.add(handleHitStopPointSignalDispatched);
		}
	}
}

