package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.pj_as3utils_namespace;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Wraps labelled MovieClips to assist Timeline Animation.
	 * 
	 * @author C Stuempges
	 */
	public class TimelineWrapper implements ITimelineWrapper
	{
		use namespace pj_as3utils_namespace;

		pj_as3utils_namespace static var nullMovieClip:MovieClip;

		private static var assertions:Assertions;
		private static var frameLabelCalculator:FrameLabelCalculator;

		pj_as3utils_namespace var onDestroy:UntypedSignal;
		pj_as3utils_namespace var onCompleteInternal:Signal;

		private var _wrappedMC:MovieClip;
		private var _isPlaying:Boolean;
		private var _onComplete:UntypedSignal;
		private var _destroyAfterComplete:Boolean;

		private var stopOnFrame:int = -1;

		public function TimelineWrapper()
		{
			init();
		}

		protected function init():void
		{
			assertions = assertions || new Assertions();
			frameLabelCalculator = frameLabelCalculator || new FrameLabelCalculator();

			_onComplete = new UntypedSignal(this);
			onDestroy = new UntypedSignal(this);
			onDestroy.setOnDispatchHandlerParams(true);
			onCompleteInternal = new Signal();
		}

		public function play():void
		{
			assertions.assertWrappedIsNotNull(this);

			gotoAndPlayUntilNextLabelOrStop(currentFrame, totalFrames, null);
		}

		public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			assertions.assertWrappedIsNotNull(this);

			gotoAndPlayUntilNextLabelOrStop(frame, totalFrames, scene);
		}

		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):void
		{
			assertions.assertWrappedIsNotNull(this);

			gotoAndPlayUntilNextLabelOrStop(frame, frameLabelCalculator.getFrameBeforeNextLabel(_wrappedMC, frame), scene);
		}

		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):void
		{
			assertions.assertWrappedIsNotNull(this);

			if (stopOn is String)
			{
				stopOn = frameLabelCalculator.getFrameBeforeNextLabel(_wrappedMC, stopOn);
			}

			gotoAndPlayUntilNextLabelOrStop(frame, stopOn as int, scene);
		}

		/* kicks off start label || frame & end label || frame */
		private function gotoAndPlayUntilNextLabelOrStop(frame:Object, stopOn:int, scene:String = null):void
		{
			assertions.assertDoesNotContainNumberAsString([frame, stopOn]);

			if (_isPlaying)
			{
				stop();
			}

			_isPlaying = true;

			_wrappedMC.gotoAndStop(frame, scene);

			if (assertions.isValidFrame(stopOn))
				stopOnFrame = stopOn;

			_wrappedMC.addEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			assertions.assertWrappedIsNotNull(this);

			stop();
			_wrappedMC.gotoAndStop(frame, scene);
		}

		public function stop():void
		{
			assertions.assertWrappedIsNotNull(this);

			clearCurrentAction();
			_wrappedMC.stop();
		}

		private function clearCurrentAction():void
		{
			if (_wrappedMC.hasEventListener(Event.ENTER_FRAME))
			{
				_wrappedMC.removeEventListener(Event.ENTER_FRAME, handleOnEnterFrame);
			}

			_isPlaying = false;
			stopOnFrame = -1;
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

			onCompleteInternal.dispatch();
			_onComplete.dispatchSetParams();

			if (_destroyAfterComplete)
				destroy();
		}

		public function destroy():void
		{
			if (isDestroyed())
			{
				trace("TimelineWrapper::destroy() called on already destroyed object.");
			}
			else
			{
				stop();

				onDestroy.dispatchSetParams();
				onDestroy.removeAll();
				onDestroy = null;

				_onComplete.removeAll();
				_onComplete = null;

				onCompleteInternal.removeAll();
				onCompleteInternal = null;

				_wrappedMC = nullMovieClip;
			}
		}

		public function isDestroyed():Boolean
		{
			return assertions.isInstanceDestroyed(this);
		}

		/**
		 * @param wrappedMC a movieClip with labels||frames you will
		 * 	* reference for animation start and stop points
		 */
		public function set wrappedMC(wrappedMC:MovieClip):void
		{
			assertions.notNullValue(wrappedMC);

			if (_isPlaying)
			{
				stop();
			}

			_wrappedMC = wrappedMC;
			_wrappedMC.stop();
		}

		public function set destroyAfterComplete(value:Boolean):void
		{
			_destroyAfterComplete = value;
		}

		public function get wrappedMC():MovieClip
		{
			return _wrappedMC;
		}

		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function get onComplete():UntypedSignal
		{
			return _onComplete;
		}

		public function get currentLabel():String
		{
			return _wrappedMC.currentLabel;
		}

		public function get currentLabels():Array
		{
			return _wrappedMC.currentLabels;
		}

		public function get currentFrame():int
		{
			return _wrappedMC.currentFrame;
		}

		public function get totalFrames():int
		{
			return _wrappedMC.totalFrames;
		}
	}
}

