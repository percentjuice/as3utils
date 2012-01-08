package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueueSetDefault;

	import org.flexunit.asserts.assertTrue;
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.mockito.integrations.any;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;

	import flash.display.MovieClip;

	public class TimelineWrapperQueueSetDefaultFactoryTest
	{
		use namespace pj_as3utils_namespace;

		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var accessor:CollectionAccessor;

		private var timelineWrapperQueueSetDefaultFactory:TimelineWrapperQueueSetDefaultFactory;

		[Before]
		public function setup():void
		{
			timelineWrapperQueueSetDefaultFactory = TimelineWrapperQueueSetDefaultFactory.getInstance();
			timelineWrapperQueueSetDefaultFactory.collectionAccessor = accessor;
		}

		[After]
		public function teardown():void
		{
			timelineWrapperQueueSetDefaultFactory.destroy();
		}
		
		[Test]
		public function should_return_correct_instance_type():void
		{
			TimelineWrapperFactoryTestRunner.should_return_correct_instance_type(TimelineWrapperQueueSetDefault, timelineWrapperQueueSetDefaultFactory);
		}

		[Test]
		public function should_return_new_instance_for_same_movieclip_after_original_instance_destroyed():void
		{
			TimelineWrapperFactoryTestRunner.should_return_new_instance_for_same_movieclip_after_original_instance_destroyed(timelineWrapperQueueSetDefaultFactory);
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function should_throw_error_on_instantiation_by_nonchild_class():void
		{
			TimelineWrapperFactoryTestRunner.should_throw_error_on_instantiation_by_nonchild_class(TimelineWrapperQueueSetDefaultFactory);
		}
		
		[Test]
		public function should_cross_reference_other_factory_type_and_return_this_type():void
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper();
			var movieClip:MovieClip = new MovieClip();
			timelineWrapper.wrappedMC = movieClip;
			
			given(timelineWrapperQueueSetDefaultFactory.collectionAccessor.getAnyMatchingITimelineWrapper(any())).willReturn(timelineWrapper);
			var timelineWrapperQueueSetDefault:TimelineWrapperQueueSetDefault = TimelineWrapperQueueSetDefault(timelineWrapperQueueSetDefaultFactory.getOneWrapperPerMC(movieClip));
			
			assertThat(timelineWrapper.isDestroyed(), isFalse());
			assertThat(timelineWrapperQueueSetDefault.isDestroyed(), isFalse());
			
			var timelineWrapperQueue:TimelineWrapperQueue = timelineWrapperQueueSetDefault.undecorate() as TimelineWrapperQueue;
			assertTrue(timelineWrapperQueue is TimelineWrapperQueue);
			assertThat(timelineWrapperQueue.wrappedMC, equalTo(movieClip));
		}
	}
}