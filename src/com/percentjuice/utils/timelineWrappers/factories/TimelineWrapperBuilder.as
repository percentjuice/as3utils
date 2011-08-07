package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.UntypedSignal;

	import flash.display.MovieClip;

	public class TimelineWrapperBuilder implements ITimelineWrapperBuilder
	{
		internal var wrappedMC:MovieClip;
		internal var preventRewrapping:Boolean;
		internal var trigger:Function;
		internal var params:Array;

		private var _wrapperInstantiator:Function;
		private var _timelineWrapper:ITimelineWrapper;

		public function TimelineWrapperBuilder(wrappedMC:MovieClip, preventRewrapping:Boolean = false)
		{
			init(wrappedMC, preventRewrapping);
		}

		internal function set wrapperInstantiator(wrapperInstantiator:Function):void
		{
			_wrapperInstantiator = wrapperInstantiator;
		}

		private function init(wrappedMC:MovieClip, preventRewrapping:Boolean):void
		{
			this.wrappedMC = wrappedMC;
			this.preventRewrapping = preventRewrapping;

			this.wrapperInstantiator = timelineWrapperCreator;
		}

		private function timelineWrapperCreator():ITimelineWrapper
		{
			var timelineWrapper:ITimelineWrapper;

			if (preventRewrapping)
			{
				timelineWrapper = TimelineWrapperFactory.getInstance().getOneWrapperPerMC(wrappedMC);
			}
			else
			{
				timelineWrapper = new TimelineWrapper();
				timelineWrapper.wrappedMC = wrappedMC;
			}
			
			return timelineWrapper;
		}

		internal function get timelineWrapper():ITimelineWrapper
		{
			if (_timelineWrapper == null)
			{
				_timelineWrapper = _wrapperInstantiator();
			}

			return _timelineWrapper;
		}

		public function setOnCompleteHandler(handler:Function):ITimelineWrapperBuilder
		{
			(timelineWrapper.onComplete as UntypedSignal).setOnDispatchHandler(handler);
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperBuilder
		{
			(timelineWrapper.onComplete as UntypedSignal).setOnceOnDispatchHandler(handler);
			return this;
		}

		public function setOnCompleteHandlerParams(params:Array):ITimelineWrapperBuilder
		{
			(timelineWrapper.onComplete as UntypedSignal).setOnDispatchHandlerParams(params);
			return this;
		}

		public function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperBuilder
		{
			timelineWrapper.onDestroy.addOnce(handler);

			return this;
		}

		public function setDestroyAfterComplete():ITimelineWrapperBuilder
		{
			timelineWrapper.destroyAfterComplete = true;
			return this;
		}
		
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.gotoAndPlay;
			params = [frame, scene];
			
			return this;
		}
		
		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.gotoAndStop;
			params = [frame, scene];

			return this;
		}
		
		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.gotoAndPlayUntilNextLabel;
			params = [frame, scene];

			return this;
		}
		
		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.gotoAndPlayUntilStop;
			params = [frame, stopOn, scene];
			
			return this;
		}
		
		public function play():ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.play;
			
			return this;
		}
		
		public function stop():ITimelineWrapperBuilder
		{
			trigger = timelineWrapper.stop;

			return this;
		}

		public function build():ITimelineWrapper
		{
			if (trigger != null)
				trigger.apply(timelineWrapper, params);
			
			return timelineWrapper;
		}
	}
}
