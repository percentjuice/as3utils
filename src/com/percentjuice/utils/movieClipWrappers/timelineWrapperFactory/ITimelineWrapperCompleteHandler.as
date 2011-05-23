package com.percentjuice.utils.movieClipWrappers.timelineWrapperFactory
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperSignal;

	public class ITimelineWrapperCompleteHandler
	{
		private var timelineWrappers:Vector.<ITimelineWrapper>;
		private var timelineWrapperQueues:Vector.<ITimelineWrapper>;

		public function ITimelineWrapperCompleteHandler(timelineWrappers:Vector.<ITimelineWrapper>, timelineWrapperQueues:Vector.<ITimelineWrapper>)
		{
			this.timelineWrappers = timelineWrappers;
			this.timelineWrapperQueues = timelineWrapperQueues;
		}

		internal function addTimelineWrapperSignalHandler(timelineWrapper:ITimelineWrapper):void
		{
			timelineWrapper.reachedStop.addOnce(createCollectionRemovalFunction(timelineWrapper, timelineWrappers));
			
			timelineWrapper.reachedStop.addOnce(handleITimelineWrapperDestroy);
		}

		internal function addTimelineWrapperQueueSignalHandler(timelineWrapper:ITimelineWrapper, timelineWrapperQueue:ITimelineWrapper):void
		{
			timelineWrapper.reachedStop.addOnce(createCollectionRemovalFunction(timelineWrapper, timelineWrappers));
			(timelineWrapperQueue as TimelineWrapperQueue).queueComplete.addOnce(createCollectionRemovalFunction(timelineWrapperQueue, timelineWrapperQueues));
			
			(timelineWrapperQueue as TimelineWrapperQueue).queueComplete.addOnce(handleITimelineWrapperDestroy);
		}

		private function createCollectionRemovalFunction(iTimelineWrapper:ITimelineWrapper, returnTypeCollection:Vector.<ITimelineWrapper>):Function
		{
			return new ITimelineWrapperRemovalHandler(iTimelineWrapper, returnTypeCollection).handleCollectionRemoval;
		}

		private function handleITimelineWrapperDestroy(signal:TimelineWrapperSignal):void
		{
			signal.dispatcher.destroy();
		}
	}
}

import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
import com.percentjuice.utils.movieClipWrappers.TimelineWrapperSignal;

class ITimelineWrapperRemovalHandler
{
	private var watched:ITimelineWrapper;
	private var returnTypeCollection:Vector.<ITimelineWrapper>;

	public function ITimelineWrapperRemovalHandler(watched:ITimelineWrapper, returnTypeCollection:Vector.<ITimelineWrapper>)
	{
		this.watched = watched;
		this.returnTypeCollection = returnTypeCollection;
	}

	public function handleCollectionRemoval(signal:TimelineWrapperSignal):void
	{
		returnTypeCollection.splice(returnTypeCollection.indexOf(watched), 1);
		// returnTypeCollection = null;
	}
}
