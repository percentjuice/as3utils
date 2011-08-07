package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	/**
	 * TimelineWrapperFactory faciliates creation of TimelineWrappers 
	 * * no need to track which MovieClips already have TimelineWrappers.
	 * * this is useful when MovieClips are being rapidly created and destroyed.
	 * *
	 * @author CStuempges
	 */
	public class TimelineWrapperFactory
	{
		protected static var allowInstantiation:Boolean;
		
		private static const SINGLETON_ERROR:String = "Instantiation failed: Use .getInstance() for Singleton instance.";
		private static var instance:TimelineWrapperFactory;

		internal var _collectionAccessor:CollectionAccessor;

		public static function getInstance():TimelineWrapperFactory
		{
			if (!instance)
			{
				allowInstantiation = true;
				instance = new TimelineWrapperFactory();
				allowInstantiation = false;
			}
			return instance;
		}

		public function TimelineWrapperFactory():void
		{
			if (allowInstantiation)
				return;
			throw new IllegalOperationError(SINGLETON_ERROR);
		}

		/**
		 * If the Factory has been used to create a previous TimelineWrapper for this wrappedMovieClip, that is returned.
		 * * Else a new TimelineWrapper is returned.
		 * @param wrappedMovieClip
		 * @return a TimelineWrapper which contains the wrappedMovieClip. remains in its current running state
		 */
		public function getOneWrapperPerMC(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			return getMatchingOrCreateNew(wrappedMovieClip);
		}

		private function getMatchingOrCreateNew(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			var timelineWrapper:ITimelineWrapper = collectionAccessor.getAnyMatchingITimelineWrapper(wrappedMovieClip);

			if (timelineWrapper == CollectionAccessor.DUMMY_WRAPPER)
			{
				timelineWrapper = getNewTimelineWrapper(wrappedMovieClip);
				collectionAccessor.addToWatchList(timelineWrapper);
			}
			else
			{
				stopTimelineWrapper(timelineWrapper);
			}

			return timelineWrapper;
		}

		protected function stopTimelineWrapper(timelineWrapper:ITimelineWrapper):void
		{
			timelineWrapper.stop();
		}

		protected function getNewTimelineWrapper(wrappedMovieClip:MovieClip):ITimelineWrapper
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper();
			timelineWrapper.wrappedMC = wrappedMovieClip;

			return timelineWrapper;
		}

		private function get collectionAccessor():CollectionAccessor
		{
			if (_collectionAccessor == null)
				_collectionAccessor = new CollectionAccessor();
			return _collectionAccessor;
		}

		public function destroy():void
		{
			_collectionAccessor.destroy();

			instance = null;
		}
	}
}
