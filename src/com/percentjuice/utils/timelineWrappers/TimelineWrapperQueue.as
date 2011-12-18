package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.pj_as3utils_namespace;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	/**
	 * Decorates TimelineWrapper
	 * Adds ability to queue labelPlay requests.
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperQueue implements ITimelineWrapper, ITimelineWrapperQueue
	{
		use namespace pj_as3utils_namespace;
	
		pj_as3utils_namespace var queueCompleteInternal:Signal;
		
		private var _timelineWrapper:TimelineWrapper;
		private var _queueComplete:UntypedSignal;
		
		private var queueList:Array;

		public function TimelineWrapperQueue(timelineWrapper:TimelineWrapper)
		{
			_timelineWrapper = timelineWrapper;
			init();
		}

		private function init():void
		{
			queueList = [];
			_queueComplete = new UntypedSignal(this);
			queueCompleteInternal = new Signal();

			_timelineWrapper.onCompleteInternal.add(handleHitStopPointSignalDispatched);
			_timelineWrapper.onDestroy.add(handleDestroyed);
			_timelineWrapper.onDestroy.target = this;
		}

		private function handleHitStopPointSignalDispatched(...args):void
		{
			if (queueList.length)
			{
				gotoAndPlayUntilNextLabel(queueList.shift());
			}
			else
			{
				queueComplete.dispatch();
				queueCompleteInternal.dispatch();
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
				queueList[queueList.length] = frame;
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

		public function isDestroyed():Boolean
		{
			return _timelineWrapper == null;
		}

		public function destroy():void
		{
			handleDestroyed(this);
			_timelineWrapper.destroy();
		}

		private function handleDestroyed(timelineWrapper:ITimelineWrapper):void
		{
			_timelineWrapper.onCompleteInternal.remove(handleHitStopPointSignalDispatched);
			_timelineWrapper.onDestroy.remove(handleDestroyed);

			clearQueue();
			_queueComplete.removeAll();
			_queueComplete = null;
			queueCompleteInternal.removeAll();
			queueCompleteInternal = null;
		}

		public function undecorate():ITimelineWrapper
		{
			if (!isDestroyed())
				handleDestroyed(this);

			var undecorated:ITimelineWrapper = _timelineWrapper;
			_timelineWrapper = null;
			return undecorated;
		}

		public function stop():void
		{
			timelineWrapper.stop();
		}

		public function set wrappedMC(wrappedMC:MovieClip):void
		{
			timelineWrapper.wrappedMC = wrappedMC;
		}

		public function set destroyAfterComplete(value:Boolean):void
		{
			timelineWrapper.destroyAfterComplete = value;
		}

		public function get queueComplete():UntypedSignal
		{
			return _queueComplete;
		}

		public function get wrappedMC():MovieClip
		{
			return timelineWrapper.wrappedMC;
		}

		public function get isPlaying():Boolean
		{
			return timelineWrapper.isPlaying;
		}

		public function get onComplete():UntypedSignal
		{
			return timelineWrapper.onComplete;
		}

		pj_as3utils_namespace function get onDestroy():UntypedSignal
		{
			return timelineWrapper.onDestroy;
		}

		public function get currentLabel():String
		{
			return timelineWrapper.currentLabel;
		}

		public function get currentLabels():Array
		{
			return timelineWrapper.currentLabels;
		}

		public function get currentFrame():int
		{
			return timelineWrapper.currentFrame;
		}

		public function get totalFrames():int
		{
			return timelineWrapper.totalFrames;
		}

		private function get timelineWrapper():TimelineWrapper
		{
			if (isDestroyed())
				throw new IllegalOperationError("cannot perform function since instance was destroyed or undecorated.");
				
			return _timelineWrapper;
		}
	}
}

