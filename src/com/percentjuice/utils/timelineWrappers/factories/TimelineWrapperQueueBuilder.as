package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.UntypedSignal;
	import flash.display.MovieClip;

	public class TimelineWrapperQueueBuilder implements ITimelineWrapperQueueBuilder
	{
		private var timelineWrapperBuilder:TimelineWrapperBuilder;

		public function TimelineWrapperQueueBuilder(wrappedMC:MovieClip, preventRewrapping:Boolean = false)
		{
			init(wrappedMC, preventRewrapping);
		}

		private function init(wrappedMC:MovieClip, preventRewrapping:Boolean):void
		{
			timelineWrapperBuilder = new TimelineWrapperBuilder(wrappedMC, preventRewrapping);
			timelineWrapperBuilder.wrapperInstantiator = timelineWrapperQueueCreator;
		}

		private function timelineWrapperQueueCreator():ITimelineWrapper
		{
			if (timelineWrapperBuilder.preventRewrapping)
			{
				return TimelineWrapperQueueFactory.getInstance().getOneWrapperPerMC(timelineWrapperBuilder.wrappedMC);
			}
			else
			{
				var timelineWrapper:TimelineWrapper = new TimelineWrapper();
				timelineWrapper.wrappedMC = timelineWrapperBuilder.wrappedMC;
				return new TimelineWrapperQueue(timelineWrapper);
			}
		}

		public function playWhenQueueEmpty(frame:Object):ITimelineWrapperQueueBuilder
		{
			timelineWrapperBuilder.trigger = ITimelineWrapperQueue(timelineWrapperBuilder.timelineWrapper).playWhenQueueEmpty;
			timelineWrapperBuilder.params = [frame];
			return this;
		}

		public function setQueueCompleteHandler(handler:Function):ITimelineWrapperQueueBuilder
		{
			(ITimelineWrapperQueue(timelineWrapperBuilder.timelineWrapper).queueComplete as UntypedSignal).setOnDispatchHandler(handler);
			return this;
		}

		public function setOnceQueueCompleteHandler(handler:Function):ITimelineWrapperQueueBuilder
		{
			(ITimelineWrapperQueue(timelineWrapperBuilder.timelineWrapper).queueComplete as UntypedSignal).setOnceOnDispatchHandler(handler);
			return this;
		}

		public function setQueueCompleteHandlerParams(params:Array):ITimelineWrapperQueueBuilder
		{
			(ITimelineWrapperQueue(timelineWrapperBuilder.timelineWrapper).queueComplete as UntypedSignal).setOnDispatchHandlerParams(params);
			return this;
		}

		public function setOnCompleteHandler(handler:Function):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.setOnCompleteHandler(handler);
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.setOnceOnCompleteHandler(handler);
			return this;
		}

		public function setOnCompleteHandlerParams(params:Array):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.setOnCompleteHandlerParams(params);
			return this;
		}

		public function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.setOnceOnDestroyHandler(handler);
			return this;
		}

		public function setDestroyAfterComplete():ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.setDestroyAfterComplete();
			return this;
		}
		
		public function gotoAndPlay(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.gotoAndPlay(frame, scene);
			
			return this;
		}
		
		public function gotoAndStop(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.gotoAndStop(frame, scene);

			return this;
		}
		
		public function gotoAndPlayUntilNextLabel(frame:Object, scene:String = null):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.gotoAndPlayUntilNextLabel(frame, scene);

			return this;
		}
		
		public function gotoAndPlayUntilStop(frame:Object, stopOn:Object, scene:String = null):ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.gotoAndPlayUntilStop(frame, stopOn, scene);
			
			return this;
		}
		
		public function play():ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.play();
			
			return this;
		}
		
		public function stop():ITimelineWrapperBuilder
		{
			timelineWrapperBuilder.stop();

			return this;
		}

		public function build():ITimelineWrapper
		{
			return timelineWrapperBuilder.build();
		}
	}
}
