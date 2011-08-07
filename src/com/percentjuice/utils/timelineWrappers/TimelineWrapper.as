package com.percentjuice.utils.timelineWrappers
{
	import org.osflash.signals.DeluxeSignal;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	/**
	 * Wraps labelled MovieClips to assist Timeline Animation management.
	 * @author C Stuempges
	 */
	public class TimelineWrapper implements ITimelineWrapper
	{
		private var _isPlaying:Boolean;
		private var _onComplete:UntypedSignal;
		private var _onDestroy:DeluxeSignal;
		private var _wrappedMC:MovieClip;
		private var _destroyAfterComplete:Boolean;

		private var startRequest:Object;
		private var stopOnFrame:int;

		private var assertions:Assertions;
		private var frameLabelCalculator:FrameLabelCalculator;

		public function TimelineWrapper()
		{
			init();
		}

		protected function init():void
		{
			assertions = new Assertions();
			frameLabelCalculator = new FrameLabelCalculator();

			_onComplete = new UntypedSignal();
			_onDestroy = new DeluxeSignal(this);
		}

		public function play():void
		{
			gotoAndPlayUntilNextLabelOrStop(currentFrame, totalFrames, null);
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			gotoAndPlayUntilNextLabelOrStop(frame, totalFrames, scene);
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			gotoAndPlayUntilNextLabelOrStop(frame, frameLabelCalculator.getFrameBeforeNextLabelOrLastFrame(frame), scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			if (stopOn is String)
			{
				stopOn = frameLabelCalculator.getFrameBeforeNextLabel(stopOn as String);
			}

			gotoAndPlayUntilNextLabelOrStop(frame, stopOn as int, scene);
		}

		/* kicks off start label || frame & end label || frame */
		private function gotoAndPlayUntilNextLabelOrStop(frame:Object, stopOn:int, scene:String = null):void
		{
			assertions.assertInstanceIsNotDestroyed(this);

			startRequest = frame;
			assertions.assertDoesNotContainNumberAsString([frame, stopOn]);

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

			_wrappedMC.addEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			assertions.assertInstanceIsNotDestroyed(this);

			stop();
			wrappedMC.gotoAndStop(frame, scene);
		}

		public function stop():void
		{
			clearCurrentAction();
			_wrappedMC.stop();
		}

		private function clearCurrentAction():void
		{
			if (wrappedMC.hasEventListener(Event.ENTER_FRAME))
			{
				_wrappedMC.removeEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
			}
			_isPlaying = false;
			stopOnFrame = 0;
		}

		private function handleOnEnterFrame(e:Event):void
		{
			if (stopOnFrame == _wrappedMC.currentFrame)
			{
				handleHitStop();
			}
			else
			{
				_wrappedMC.nextFrame();
			}
		}

		private function handleHitStop():void
		{
			clearCurrentAction();

			_onComplete.dispatchSetParams();

			if (_destroyAfterComplete)
				destroy();
		}

		public function destroy():void
		{
			if (assertions.isInstanceDestroyed(this))
			{
				trace("TimelineWrapper::destroy() called on already destroyed object.");
			}
			else
			{
				stop();

				ifThisNotDecoratedDispatchThis();
				
				_onDestroy.removeAll();
				_onDestroy = null;

				_onComplete.removeAll();
				_onComplete = null;
			}
		}

		private function ifThisNotDecoratedDispatchThis():void
		{
			_onDestroy.dispatch(_onDestroy.target);
		}

		/**
		 * @param wrappedMC a movieClip with labels||frames you will
		 * 	* reference for animation start and stop points
		 */
		public function set wrappedMC(wrappedMC:MovieClip):void
		{
			assertions.assertNotNull(wrappedMC);

			if (_isPlaying)
			{
				stop();
			}

			_wrappedMC = wrappedMC;
			_wrappedMC.stop();

			frameLabelCalculator.wrappedMC = _wrappedMC;
		}

		public function set destroyAfterComplete(value:Boolean):void
		{
			_destroyAfterComplete = value;
		}

		public function get wrappedMC():MovieClip// TODO: not the place to not allow a null return.  public should be able to read a null instance.
		{
			assertions.assertNotNull(_wrappedMC);

			return _wrappedMC;
		}

		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function get onComplete():DeluxeSignal
		{
			return _onComplete;
		}

		/**
		 * onDestroy handlers must handle this ITimelineWrapper as the handler parameter.
		 * * ex: onDestroyHandler(dispatcher:ITimelineWrapper)
		 */
		public function get onDestroy():DeluxeSignal
		{
			return _onDestroy;
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

