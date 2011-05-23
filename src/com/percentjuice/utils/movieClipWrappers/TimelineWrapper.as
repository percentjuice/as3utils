package com.percentjuice.utils.movieClipWrappers
{
	import flash.errors.IllegalOperationError;
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
		private var _reachedStop:TimelineWrapperSignal;

		private var _wrappedMC:MovieClip;
		private var startRequest:Object;
		private var stopOnFrame:int;

		private var timelineWrapperAssertions:TimelineWrapperAssertions;

		/**
		 * @param wrappedMC: a movieClip with labels||frames you will
		 * 	* reference for animation start and stop points
		 */
		public function TimelineWrapper(wrappedMC:MovieClip)
		{
			_wrappedMC = wrappedMC;
			init();
		}

		private function init():void
		{
			timelineWrapperAssertions = new TimelineWrapperAssertions();
			timelineWrapperAssertions.assertWrappedMCNotNull(_wrappedMC);

			_wrappedMC.stop();

			_reachedStop = new TimelineWrapperSignal(this);
		}

		public function play():void// TODO: requires test
		{
			gotoAndPlayUntilNextLabelOrStop(currentFrame, totalFrames, null);
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void//TODO: requires test
		{
			gotoAndPlayUntilNextLabelOrStop(frame, totalFrames, scene);
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			gotoAndPlayUntilNextLabelOrStop(frame, getFrameBeforeNextLabelOrLastFrame(frame), scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			if (stopOn is String)
			{
				stopOn = getFrameBeforeNextLabel(stopOn as String);
			}

			gotoAndPlayUntilNextLabelOrStop(frame, stopOn as int, scene);
		}

		private function getFrameBeforeNextLabelOrLastFrame(frame:Object):int
		{
			var l:int = wrappedMC.currentLabels.length - 1;

			if (wrappedMC.currentLabels.length == 0 || (String(frame) == (wrappedMC.currentLabels[l] as FrameLabel).name) || (int(frame) > 0 && (wrappedMC.currentLabels[l] as FrameLabel).frame <= frame))
			{
				return totalFrames;
			}
			else
			{
				if (int(frame) > 0)
					frame = getLabelForFrame(int(frame));

				if (String(frame) == null)
					throw new IllegalOperationError("Not a settable Frame: '" + frame + "'");

				return getFrameBeforeNextLabel(String(frame));
			}
		}

		private function getLabelForFrame(frame:int):String
		{
			for (var l:int = wrappedMC.currentLabels.length - 1; l != -1; l--)
			{
				var fl:FrameLabel = wrappedMC.currentLabels[l];
				if (fl.frame <= frame)
				{
					return FrameLabel(wrappedMC.currentLabels[l]).name;
				}
			}
			throw new Error('Frame "' + frame + '" not found in ' + wrappedMC);
		}

		private function getFrameBeforeNextLabel(label:String):int
		{
			var l:int = wrappedMC.currentLabels.length;

			for (var i:int = 0; i < l; i++)
			{
				var fl:FrameLabel = wrappedMC.currentLabels[i];
				if (fl.name == label)
				{
					var nextLabel:FrameLabel = FrameLabel(wrappedMC.currentLabels[i + 1]);
					return nextLabel.frame - 1;
				}
			}
			throw new Error('Label "' + label + '" not found in ' + wrappedMC);
		}

		/* kicks off start label || frame & end label || frame */
		private function gotoAndPlayUntilNextLabelOrStop(frame:Object, stopOn:int, scene:String = null):void
		{
			timelineWrapperAssertions.assertInstanceIsNotDestroyed(this);

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

			if (stopOn > 0)
			{
				stopOnFrame = stopOn;
			}
			else
			{
				throw new IllegalOperationError("Not a settable Stop Frame: " + stopOn);
			}

			wrappedMC.addEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			timelineWrapperAssertions.assertInstanceIsNotDestroyed(this);
			
			stop();
			wrappedMC.gotoAndStop(frame, scene);
		}

		public function stop():void
		{
			clearCurrentAction();
			wrappedMC.stop();
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

			reachedStop.dispatchSignalClone(startRequest);
		}

		public function destroy():void
		{
			if (timelineWrapperAssertions.isInstanceDestroyed(this))
			{
				trace("TimelineWrapper::destroy() called on already destroyed object.");
			}
			else
			{
				stop();
				_reachedStop.removeAll();
				_reachedStop = null;
			}
		}

		public function get reachedStop():TimelineWrapperSignal
		{
			return _reachedStop;
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

