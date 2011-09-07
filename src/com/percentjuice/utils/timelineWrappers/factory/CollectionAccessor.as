package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.DummyTimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;

	import flash.display.MovieClip;


	public class CollectionAccessor
	{
		internal static const RESET_PERIOD:int = 10;
		internal static const DUMMY_WRAPPER:ITimelineWrapper = new DummyTimelineWrapper();

		internal var referenceCountCollection:Vector.<ITimelineWrapper>;

		private var i:int;
		private var l:int;
		private var accessCount:int;

		/**
		 * manages reference counting and garbage collection.
		 * handles destroy of an item in the collection.
		 * allows access to the collection when a duplicate MovieClip is passed to getAnyMatchingITimelineWrapper.
		 */
		public function CollectionAccessor()
		{
			referenceCountCollection = new <ITimelineWrapper>[];
		}

		/**
		 * if another watched ITimelineWrapper contains this same MovieClip, it is returned.
		 * if no other watched ITimelineWrapper contains this same MovieClip, DUMMY_WRAPPER is returned.
		 */
		public function getAnyMatchingITimelineWrapper(wrappedMC:MovieClip):ITimelineWrapper
		{
			periodicallyPurgeDestroyedWrappers();

			l = referenceCountCollection.length - 1;
			for (; l != -1; l += -1)
			{
				var timelineWrapper:ITimelineWrapper = referenceCountCollection[l];

				if (timelineWrapper != DUMMY_WRAPPER && timelineWrapper.wrappedMC == wrappedMC)
				{
					return timelineWrapper;
				}
			}
			return DUMMY_WRAPPER;
		}

		/**
		 * garbage collection 
		 */
		private function periodicallyPurgeDestroyedWrappers():void
		{
			++accessCount;
			if (accessCount < RESET_PERIOD)
			{
				return;
			}
			accessCount = 0;

			var oldCollection:Vector.<ITimelineWrapper> = new <ITimelineWrapper>[];
			oldCollection = oldCollection.concat(referenceCountCollection);

			referenceCountCollection.length = 0;

			i = 0;
			l = oldCollection.length - 1;
			for (; l != -1; l += -1)
			{
				var timelineWrapper:ITimelineWrapper = oldCollection[l];
				if (timelineWrapper == DUMMY_WRAPPER)
				{
					continue;
				}
				else if (timelineWrapper.wrappedMC == null)
				{
					timelineWrapper.destroy();
					continue;
				}
				else
				{
					referenceCountCollection[i++] = oldCollection[l];
				}
			}
		}

		/**
		 * pushes object into the collection
		 * @param timelineWrapper this timelineWrapper will be included in the reference count until it calls timelineWrapper.destroy()
		 */
		public function addToWatchList(timelineWrapper:ITimelineWrapper):void
		{
			timelineWrapper.onDestroy.addOnce(handleTimelineWrapperDestroy);
			referenceCountCollection[referenceCountCollection.length] = timelineWrapper;
		}

		private function handleTimelineWrapperDestroy(timelineWrapper:ITimelineWrapper):void
		{
			var index:int = referenceCountCollection.indexOf(timelineWrapper);
			referenceCountCollection[index] = CollectionAccessor.DUMMY_WRAPPER;
		}

		public function destroy():void
		{
			if (referenceCountCollection == null)
			{
				return;
			}
			else
			{
				destroyCollection();
			}
		}

		private function destroyCollection():void
		{
			var l:int = referenceCountCollection.length - 1;
			for (; l != -1; l += -1)
			{
				referenceCountCollection[l].destroy();
			}

			referenceCountCollection = null;
		}
	}
}
