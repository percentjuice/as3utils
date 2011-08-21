package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	public class TimelineQueueClassConverter extends TimelineClassConverter
	{
		protected override function convertInstance(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			switch(true)
			{
				case timelineWrapper is TimelineWrapper:
					timelineWrapper = new TimelineWrapperQueue((timelineWrapper as TimelineWrapper));
					break;
				case timelineWrapper is TimelineWrapperQueue:
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return timelineWrapper;
		}
	}
}
