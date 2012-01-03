package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueueSetDefault;

	public class TimelineWrapperClassConverter
	{
		use namespace pj_as3utils_namespace;

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
				case timelineWrapper is TimelineWrapperQueueSetDefault:
					return getDecoratedFrom(timelineWrapper);
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return null;
		}

		private function getDecoratedFrom(timelineWrapper:ITimelineWrapper):ITimelineWrapper
		{
			var decorated:ITimelineWrapper = ITimelineWrapperQueue(timelineWrapper).undecorate();
			timelineWrapper = CollectionAccessor.DUMMY_WRAPPER;
			collectionAccessor.addToWatchList(decorated);
			return decorated;
		}
	}
}
