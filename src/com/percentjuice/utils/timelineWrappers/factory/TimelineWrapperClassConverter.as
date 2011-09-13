package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;

	public class TimelineWrapperClassConverter
	{
		protected static const ERROR_NOT_SUPPORTED:String = " is not a supported Class type.";

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
					break;
				case timelineWrapper is ITimelineWrapperQueue:
					timelineWrapper = (timelineWrapper as ITimelineWrapperQueue).undecorate();
					break;
				default:
					throw new ArgumentError(timelineWrapper + ERROR_NOT_SUPPORTED);
			}
			return timelineWrapper;
		}
	}
}
