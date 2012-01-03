package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueueSetDefault;

	import flash.display.MovieClip;

	/**
	 * TimelineWrapperQueueSetDefaultFactory faciliates creation of TimelineWrapperQueueSetDefault's with
	 * * no need to track which MovieClips already have TimelineWrapperQueueSetDefault's.
	 * * this is useful when MovieClips are being rapidly created and destroyed.
	 * 
	 * @author CStuempges
	 */
	public class TimelineWrapperQueueSetDefaultFactory extends TimelineWrapperQueueFactory
	{
		use namespace pj_as3utils_namespace;

		private static var instance:TimelineWrapperQueueSetDefaultFactory;

		public static function getInstance():TimelineWrapperQueueSetDefaultFactory
		{
			if (!instance)
			{
				allowInstantiation = true;
				instance = new TimelineWrapperQueueSetDefaultFactory();
				allowInstantiation = false;
			}
			return instance;
		}
		
		protected override function getNewTimelineWrapper(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper();
			var timelineWrapperQueue:TimelineWrapperQueue = new TimelineWrapperQueue(timelineWrapper);
			var timelineWrapperQueueSetDefault:ITimelineWrapperQueueSetDefault = new TimelineWrapperQueueSetDefault(timelineWrapperQueue);
			timelineWrapperQueueSetDefault.wrappedMC = wrappedMovieClip;

			return timelineWrapperQueueSetDefault;
		}

		protected override function get timelineClassConverter():TimelineWrapperClassConverter
		{
			if (_classConverter == null)
			{
				_classConverter = new TimelineWrapperQueueSetDefaultClassConverter(collectionAccessor);
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