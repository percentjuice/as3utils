package com.percentjuice.utils.movieClipWrappers.timelineWrapperFactory
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperQueue;

	import flash.display.MovieClip;

	public class ITimelineWrapperFactoryInstantiator
	{
		private var timelineWrappers:Vector.<ITimelineWrapper>;
		private var timelineWrapperQueues:Vector.<ITimelineWrapper>;

		public function ITimelineWrapperFactoryInstantiator(timelineWrappers:Vector.<ITimelineWrapper>, timelineWrapperQueues:Vector.<ITimelineWrapper>)
		{
			this.timelineWrappers = timelineWrappers;
			this.timelineWrapperQueues = timelineWrapperQueues;
		}

		internal function getTimelineWrapper(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			var iTimelineWrapper:ITimelineWrapper = new TimelineWrapper(wrappedMovieClip);
			timelineWrappers.push(iTimelineWrapper);
			return iTimelineWrapper;
		}

		internal function getTimelineWrapperQueue(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			var iTimelineWrapper:ITimelineWrapper = new TimelineWrapperQueue(timelineWrapper as TimelineWrapper);
			timelineWrapperQueues.push(iTimelineWrapper);
			return iTimelineWrapper;
		}
	}
}
