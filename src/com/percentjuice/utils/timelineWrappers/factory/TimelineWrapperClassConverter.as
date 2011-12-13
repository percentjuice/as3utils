package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	public class TimelineWrapperClassConverter
	{
		protected static const ERROR_NOT_SUPPORTED:String = " is not a supported Class type.";
		protected var collectionAccessor:CollectionAccessor;

		public function TimelineWrapperClassConverter(collectionAccessor:CollectionAccessor)
		{
			this.collectionAccessor = collectionAccessor;
		}

		public function fromInstance(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			timelineWrapper.stop();

			return convertInstance(timelineWrapper);
		}

		protected function convertInstance(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			switch(true)
			{
				case timelineWrapper is TimelineWrapper:
					return timelineWrapper;
					break;
				case timelineWrapper is TimelineWrapperQueue:
					var decorated:ITimelineWrapper = (timelineWrapper as TimelineWrapperQueue).undecorate();
					timelineWrapper = CollectionAccessor.DUMMY_WRAPPER;
					collectionAccessor.addToWatchList(decorated);
					return decorated;
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return null;
		}
	}
}
