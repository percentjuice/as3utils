package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;

	import flash.display.MovieClip;

	public class CollectionAccessorTest
	{
		private var collectionAccessor:CollectionAccessor;

		private var wrapper0:ITimelineWrapper;
		private var wrapper1:ITimelineWrapper;
		private var wrapper2:ITimelineWrapper;
		private var wrapper3:ITimelineWrapper;
		private var wrapper4:ITimelineWrapper;
		private var wrapper5:ITimelineWrapper;

		private var movieClip0:MovieClip = new MovieClip();
		private var movieClip1:MovieClip = new MovieClip();
		private var movieClip2:MovieClip = new MovieClip();
		private var movieClip3:MovieClip = new MovieClip();
		private var movieClip4:MovieClip = new MovieClip();
		private var movieClip5:MovieClip = new MovieClip();

		[Before]
		public function setup():void
		{
			wrapper0 = new TimelineWrapper();
			wrapper1 = new TimelineWrapper();
			wrapper2 = new TimelineWrapper();
			wrapper3 = new TimelineWrapper();
			wrapper4 = new TimelineWrapper();
			wrapper5 = new TimelineWrapper();

			wrapper0.wrappedMC = movieClip0;
			wrapper1.wrappedMC = movieClip1;
			wrapper2.wrappedMC = movieClip2;
			wrapper3.wrappedMC = movieClip3;
			wrapper4.wrappedMC = movieClip4;
			wrapper5.wrappedMC = movieClip5;

			collectionAccessor = new CollectionAccessor();
		}

		[Test]
		public function should_return_matching_wrapper_for_matching_movieclip():void
		{
			collectionAccessor.addToWatchList(wrapper0);
			collectionAccessor.addToWatchList(wrapper1);
			collectionAccessor.addToWatchList(wrapper2);
			collectionAccessor.addToWatchList(wrapper3);
			collectionAccessor.addToWatchList(wrapper4);
			collectionAccessor.addToWatchList(wrapper5);

			var movieClip4Parent:ITimelineWrapper = collectionAccessor.getAnyMatchingITimelineWrapper(movieClip4);

			assertThat(movieClip4Parent, not(wrapper0));
			assertThat(movieClip4Parent, not(wrapper1));
			assertThat(movieClip4Parent, not(wrapper2));
			assertThat(movieClip4Parent, not(wrapper3));
			assertThat(movieClip4Parent, equalTo(wrapper4));
			assertThat(movieClip4Parent, not(wrapper5));
		}
		
		[Test]
		public function shoud_return_dummy_when_no_matching_wrapper_found():void
		{
			collectionAccessor.addToWatchList(wrapper0);
			collectionAccessor.addToWatchList(wrapper1);
			collectionAccessor.addToWatchList(wrapper2);
			collectionAccessor.addToWatchList(wrapper3);
			collectionAccessor.addToWatchList(wrapper4);
			collectionAccessor.addToWatchList(wrapper5);

			var movieClipNewParent:ITimelineWrapper = collectionAccessor.getAnyMatchingITimelineWrapper(new MovieClip());

			assertThat(movieClipNewParent, not(wrapper0));
			assertThat(movieClipNewParent, not(wrapper1));
			assertThat(movieClipNewParent, not(wrapper2));
			assertThat(movieClipNewParent, not(wrapper3));
			assertThat(movieClipNewParent, not(wrapper4));
			assertThat(movieClipNewParent, not(wrapper5));
			assertThat(movieClipNewParent, equalTo(CollectionAccessor.DUMMY_WRAPPER));
		}

		[Test]
		public function should_purge_collection_of_dummywrappers_after_10_calls():void
		{
			collectionAccessor.referenceCountCollection = new <ITimelineWrapper>[wrapper0, wrapper1, CollectionAccessor.DUMMY_WRAPPER, wrapper3, CollectionAccessor.DUMMY_WRAPPER, wrapper5];

			for (var i:int = 0; i < CollectionAccessor.RESET_PERIOD; i++)
			{
				collectionAccessor.getAnyMatchingITimelineWrapper(movieClip0);
			}

			assertThat(collectionAccessor.referenceCountCollection, arrayWithSize(4));
			assertThat(collectionAccessor.referenceCountCollection, everyItem(isA(ITimelineWrapper)));
			assertThat(collectionAccessor.referenceCountCollection, hasItem(not(CollectionAccessor.DUMMY_WRAPPER)));
		}
	}
}
