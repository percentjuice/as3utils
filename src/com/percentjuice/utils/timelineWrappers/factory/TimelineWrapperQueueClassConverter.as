package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	public class TimelineWrapperQueueClassConverter extends TimelineWrapperClassConverter
	{
		public function TimelineWrapperQueueClassConverter(collectionAccessor:CollectionAccessor)
		{
			super(collectionAccessor);
		}
		
		protected override function convertInstance(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			switch(true)
			{
				case timelineWrapper is TimelineWrapper:
					timelineWrapper = new TimelineWrapperQueue((timelineWrapper as TimelineWrapper));
					break;
				case timelineWrapper is ITimelineWrapperQueue:
					(timelineWrapper as ITimelineWrapperQueue).clearQueue();
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return timelineWrapper;
		}
	}
}
