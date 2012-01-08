package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueueSetDefault;

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
				case timelineWrapper is TimelineWrapperQueue:
					(timelineWrapper as TimelineWrapperQueue).clearQueue();
					break;
				case timelineWrapper is TimelineWrapperQueueSetDefault:
					(timelineWrapper as TimelineWrapperQueueSetDefault).clearQueue();
					timelineWrapper = (timelineWrapper as TimelineWrapperQueueSetDefault).undecorate();
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return timelineWrapper;
		}
	}
}
