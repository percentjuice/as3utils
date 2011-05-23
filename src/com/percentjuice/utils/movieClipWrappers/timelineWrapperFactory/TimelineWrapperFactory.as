package com.percentjuice.utils.movieClipWrappers.timelineWrapperFactory
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperQueue;

	import flash.display.MovieClip;

	/**
	 * TimelineWrapperFactory faciliates creation of ITimelineWrappers with
	 * * 1) no need to track which MovieClips already have ITimelineWrappers:
	 * * * all methods
	 * * 2) no need to destroy ITimelineWrappers after one Signal dispatch:
	 * * * these methods: getOneSingleUseTimelineWrapperPerMC, getOneSingleUseTimelineWrapperQueuePerMC
	 * *
	 * @author CStuempges
	 */
	public class TimelineWrapperFactory
	{
		private static var _iTimelineWrapperCollectionAccessor:ITimelineWrapperCollectionAccessor;
		private static var _iTimelineWrapperFactoryInstantiator:ITimelineWrapperFactoryInstantiator;
		private static var _iTimelineWrapperCompleteDestroyer:ITimelineWrapperCompleteHandler;

		private static var _timelineWrappers:Vector.<ITimelineWrapper>;
		private static var _timelineWrapperQueues:Vector.<ITimelineWrapper>;

		/**
		 * If the Factory has been used to create a previous TimelineWrapper for this wrappedMovieClip, that is returned.
		 * * Else a new TimelineWrapper is returned.
		 * @param wrappedMovieClip
		 * @return
		 */
		public static function getOneTimelineWrapperPerMC(wrappedMovieClip:MovieClip):TimelineWrapper
		{
			return getOneTimelineWrapperPerMCWithOptionToStopActive(wrappedMovieClip, false) as TimelineWrapper;
		}

		/**
		 * If the Factory has been used to create a previous TimelineWrapper for this wrappedMovieClip, that is returned.
		 * * Else a new TimelineWrapper is returned.
		 * The returned TimelineWrapper is destroyed when TimelineWrapper::signal_stopReached is dispatched.
		 * @param wrappedMovieClip
		 * @return
		 */
		public static function getOneSingleUseTimelineWrapperPerMC(wrappedMovieClip:MovieClip):TimelineWrapper
		{
			var timelineWrapper:TimelineWrapper = getOneTimelineWrapperPerMC(wrappedMovieClip);

			iTimelineWrapperCompleteDestroyer.addTimelineWrapperSignalHandler(timelineWrapper);

			return timelineWrapper;
		}

		/**
		 * If the Factory has been used to create a previous TimelineWrapperQueue for this wrappedMovieClip, that is returned.
		 * * Else a new TimelineWrapperQueue is returned.
		 * If the Factory has been used to create a previous TimelineWrapper for this wrappedMovieClip, that is the Child of this TimelineWrapperQueue.
		 * * That reused Child will have all existing listeners removed to avoid TimelineWrapper::destroy() being called twice.
		 * * Else a new TimelineWrapper is the Child.
		 * @param wrappedMovieClip
		 * @return
		 */
		public static function getOneTimelineWrapperQueuePerMC(wrappedMovieClip:MovieClip):TimelineWrapperQueue
		{
			return getOneTimelineWrapperQueuePerMCAndItsChildTimelineWrapper(wrappedMovieClip)[0] as TimelineWrapperQueue;
		}

		/**
		 * If the Factory has been used to create a previous TimelineWrapperQueue for this wrappedMovieClip, that is returned.
		 * * Else a new TimelineWrapperQueue is returned.
		 * If the Factory has been used to create a previous TimelineWrapper for this wrappedMovieClip, that is the Child of this TimelineWrapperQueue.
		 * * That reused Child will have all existing listeners removed to avoid TimelineWrapper::destroy() being called twice.
		 * * Else a new TimelineWrapper is the Child.
		 * The returned TimelineWrapperQueue is destroyed when TimelineWrapper::signal_queueComplete is dispatched.
		 * @param wrappedMovieClip
		 * @return
		 */
		public static function getOneSingleUseTimelineWrapperQueuePerMC(wrappedMovieClip:MovieClip):TimelineWrapperQueue
		{
			var iTimelineWrappers:Vector.<ITimelineWrapper> = getOneTimelineWrapperQueuePerMCAndItsChildTimelineWrapper(wrappedMovieClip);
			var timelineWrapperQueue:TimelineWrapperQueue = iTimelineWrappers[0] as TimelineWrapperQueue;

			iTimelineWrapperCompleteDestroyer.addTimelineWrapperQueueSignalHandler(iTimelineWrappers[1], timelineWrapperQueue);

			return timelineWrapperQueue;
		}

		private static function getOneTimelineWrapperQueuePerMCAndItsChildTimelineWrapper(wrappedMovieClip:MovieClip):Vector.<ITimelineWrapper>
		{
			var timelineWrapperQueue:ITimelineWrapper = iTimelineWrapperCollectionAccessor.getAnyMatchingITimelineWrapper(wrappedMovieClip, timelineWrapperQueues);
			var timelineWrapper:TimelineWrapper = getOneTimelineWrapperPerMCWithOptionToStopActive(wrappedMovieClip, true) as TimelineWrapper;

			if (timelineWrapperQueue == ITimelineWrapperCollectionAccessor.NULL_ITIMELINE_WRAPPER)
			{
				timelineWrapperQueue = iTimelineWrapperFactoryInstantiator.getTimelineWrapperQueue(timelineWrapper);
			}

			return new <ITimelineWrapper> [timelineWrapperQueue, timelineWrapper];
		}

		/**
		 * Reuse any existing TimelineWrapper in the TimelineWrapperQueue.
		 * use case: If a TimelineWrapperQueue is requested for a MovieClip with an existing TimelineWrapper, stop the TimelineWrapper.
		 * @param wrappedMovieClip
		 * @param stopActiveAnimation: returns a TimelineWrapper without other dependent listeners && with animations stopped.
		 * 			Used when other listeners might call TimelineWrapper::destroy().
		 * @return
		 */
		private static function getOneTimelineWrapperPerMCWithOptionToStopActive(wrappedMovieClip:MovieClip, stopActiveAnimation:Boolean):ITimelineWrapper
		{
			var timelineWrapper:ITimelineWrapper = iTimelineWrapperCollectionAccessor.getAnyMatchingITimelineWrapper(wrappedMovieClip, timelineWrappers);

			if (timelineWrapper == ITimelineWrapperCollectionAccessor.NULL_ITIMELINE_WRAPPER)
			{
				timelineWrapper = iTimelineWrapperFactoryInstantiator.getTimelineWrapper(wrappedMovieClip);
			}

			if (stopActiveAnimation)
			{
				timelineWrapper.stop();
				timelineWrapper.reachedStop.removeAll();
			}

			return timelineWrapper;
		}

		public static function destroy():void
		{
			_iTimelineWrapperCollectionAccessor = null;
			_iTimelineWrapperFactoryInstantiator = null;
			_iTimelineWrapperCompleteDestroyer = null;

			destroyITimelineWrapperCollection(_timelineWrappers);
			destroyITimelineWrapperCollection(_timelineWrapperQueues);
		}

		private static function destroyITimelineWrapperCollection(collection:Vector.<ITimelineWrapper>):void
		{
			if (collection != null)
			{
				for each (var iTimelineWrapper:ITimelineWrapper in collection)
				{
					if (iTimelineWrapper.reachedStop != null)
						iTimelineWrapper.destroy();
				}
				collection = null;
			}
		}

		static private function get iTimelineWrapperCompleteDestroyer():ITimelineWrapperCompleteHandler
		{
			if (_iTimelineWrapperCompleteDestroyer == null)
				_iTimelineWrapperCompleteDestroyer = new ITimelineWrapperCompleteHandler(timelineWrappers, timelineWrapperQueues);
			return _iTimelineWrapperCompleteDestroyer;
		}

		static private function get iTimelineWrapperCollectionAccessor():ITimelineWrapperCollectionAccessor
		{
			if (_iTimelineWrapperCollectionAccessor == null)
				_iTimelineWrapperCollectionAccessor = new ITimelineWrapperCollectionAccessor();
			return _iTimelineWrapperCollectionAccessor;
		}

		static private function get iTimelineWrapperFactoryInstantiator():ITimelineWrapperFactoryInstantiator
		{
			if (_iTimelineWrapperFactoryInstantiator == null)
				_iTimelineWrapperFactoryInstantiator = new ITimelineWrapperFactoryInstantiator(timelineWrappers, timelineWrapperQueues);
			return _iTimelineWrapperFactoryInstantiator;
		}

		static private function get timelineWrappers():Vector.<ITimelineWrapper>
		{
			if (_timelineWrappers == null)
				_timelineWrappers = new <ITimelineWrapper>[];
			return _timelineWrappers;
		}

		static private function get timelineWrapperQueues():Vector.<ITimelineWrapper>
		{
			if (_timelineWrapperQueues == null)
				_timelineWrapperQueues = new <ITimelineWrapper>[];
			return _timelineWrapperQueues;
		}
	}
}


