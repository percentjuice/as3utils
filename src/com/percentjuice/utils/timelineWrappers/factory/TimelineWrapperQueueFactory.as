package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	import flash.display.MovieClip;

	/**
	 * TimelineWrapperQueueFactory faciliates creation of TimelineWrapperQueues with
	 * * no need to track which MovieClips already have TimelineWrapperQueues.
	 * * this is useful when MovieClips are being rapidly created and destroyed.
	 * 
	 * @author CStuempges
	 */
	public class TimelineWrapperQueueFactory extends TimelineWrapperFactory
	{
		use namespace pj_as3utils_namespace;

		private static var instance:TimelineWrapperQueueFactory;

		public static function getInstance():TimelineWrapperQueueFactory
		{
			if (!instance)
			{
				allowInstantiation = true;
				instance = new TimelineWrapperQueueFactory();
				allowInstantiation = false;
			}
			return instance;
		}
		
		protected override function getNewTimelineWrapper(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper();
			var timelineWrapperQueue:ITimelineWrapperQueue = new TimelineWrapperQueue(timelineWrapper);
			timelineWrapper.wrappedMC = wrappedMovieClip;

			return timelineWrapperQueue;
		}

		protected override function get timelineClassConverter():TimelineWrapperClassConverter
		{
			if (_classConverter == null)
			{
				_classConverter = new TimelineWrapperQueueClassConverter(collectionAccessor);
			}
			return _classConverter;
		}

		public override function destroy():void
		{
			super.destroy();

			instance = null;
		}
	}
}