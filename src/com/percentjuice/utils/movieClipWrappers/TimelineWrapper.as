// ------------------------------------------------------------------------------
// copyright 2010
// ------------------------------------------------------------------------------

package com.percentjuice.utils.movieClipWrappers
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Wraps labelled MovieClips to assist Timeline Animation management.
	 * @author C Stuempges
	 */
	public class TimelineWrapper implements ITimelineWrapper
	{

		private var _isPlaying:Boolean;
		private var _signal_reachedStop:TimelineWrapperSignal;

		private var _wrappedMC:MovieClip;
		private var startRequest:Object;
		private var stopOnFrame:int;

		private var timelineWrapperAssertions:TimelineWrapperAssertions;

		/**
		 * @param labeledMC: a movieClip with labels/frames you will
		 * 	* reference as animation start/stop points
		 */
		public function TimelineWrapper(wrappedMC:MovieClip)
		{
			_wrappedMC = wrappedMC;
			init();
		}

		private function init():void
		{
			timelineWrapperAssertions = new TimelineWrapperAssertions();
			timelineWrapperAssertions.assertWrappedMCNotNull(wrappedMC);

			_signal_reachedStop = new TimelineWrapperSignal(this);

			_wrappedMC.stop();
		}

		public function destroy():void
		{
			if (timelineWrapperAssertions.isInstanceDestroyed(this))
			{
				trace("ITimelineWrapper::destroy() called on already destroyed ITimelineWrapper.");
			}
			else
			{
				stop();
				_signal_reachedStop.removeAll();
				_signal_reachedStop = null;
			}
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapperAssertions.assertInstanceIsNotDestroyed(this);
			stop();
			wrappedMC.gotoAndStop(frame, scene);
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			timelineWrapperAssertions.assertInstanceIsNotDestroyed(this);
			gotoAndPlayUntilNextLabelOrStop(frame, null, scene);
		}

		/* kicks off start label/frame & end label/frame */
		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			timelineWrapperAssertions.assertInstanceIsNotDestroyed(this);
			gotoAndPlayUntilNextLabelOrStop(frame, stopOn, scene);
		}

		/* kicks off start label/frame & end label/frame */
		private function gotoAndPlayUntilNextLabelOrStop(frame:Object, stopOn:Object = null, scene:String = null):void
		{
			startRequest = frame;
			timelineWrapperAssertions.assertRequestIsNotNumberAsString([frame, stopOn]);

			if (_isPlaying)
			{
				stop();
			}
			else
			{
				_isPlaying = true;
			}

			wrappedMC.gotoAndStop(frame, scene);

			if (stopOn && stopOn is String)
			{
				setStopOnBeforeNextLabel(stopOn as String);
			}
			else if (stopOn && int(stopOn) > 0)
			{
				stopOnFrame = int(stopOn);
			}
			else
			{
				setStopOnBeforeNextLabelOrAtEnd();
			}

			wrappedMC.addEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
		}

		public function stop():void
		{
			clearCurrentAction();
			wrappedMC.stop();
		}

		private function setStopOnBeforeNextLabel(label:String):void
		{
			var l:int = wrappedMC.currentLabels.length;

			for (var i:int = 0; i < l; i++)
			{
				var fl:FrameLabel = wrappedMC.currentLabels[i];
				if (fl.name == label)
				{
					var nextLabel:FrameLabel = FrameLabel(wrappedMC.currentLabels[i + 1]);
					stopOnFrame = nextLabel.frame - 1;
					return;
				}
			}
			throw new Error('Label ' + label + ' not found in ' + wrappedMC);
		}

		private function setStopOnBeforeNextLabelOrAtEnd():void
		{
			var l:int = wrappedMC.currentLabels.length - 1;

			if (wrappedMC.currentLabels.length == 0 || wrappedMC.currentLabel == (wrappedMC.currentLabels[l] as FrameLabel).name)
			{
				stopOnFrame = totalFrames;
			}
			else
			{
				setStopOnBeforeNextLabel(wrappedMC.currentLabel);
			}
		}

		private function clearCurrentAction():void
		{
			if (wrappedMC.hasEventListener(Event.ENTER_FRAME))
			{
				wrappedMC.removeEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
			}
			_isPlaying = false;
			stopOnFrame = 0;
		}

		private function handleOnEnterFrame(e:Event):void
		{
			if (stopOnFrame == wrappedMC.currentFrame)
			{
				handleHitStopPoint();
			}
			else
			{
				wrappedMC.nextFrame();
			}
		}

		private function handleHitStopPoint():void
		{
			clearCurrentAction();

			if (timelineWrapperAssertions.isInstanceDestroyed(this))// TODO: remove unecessary check
			{
				trace("Error with TimelineWrapperFactory use.  Dispatch request on destroyed TimelineWrapper.");
			}
			else
			{
				signal_reachedStop.dispatchSignalClone(startRequest);
			}
		}

		public function get signal_reachedStop():TimelineWrapperSignal
		{
			return _signal_reachedStop;
		}

		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function get wrappedMC():MovieClip
		{
			return _wrappedMC;
		}

		public function get currentLabel():String
		{
			return wrappedMC.currentLabel;
		}

		public function get currentFrame():int
		{
			return wrappedMC.currentFrame;
		}

		public function get totalFrames():int
		{
			return wrappedMC.totalFrames;
		}
	}
}

