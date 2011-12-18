package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.mockito.integrations.any;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;

	import flash.display.MovieClip;

	public class TimelineWrapperQueueFactoryTest
	{
		use namespace pj_as3utils_namespace;

		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var accessor:CollectionAccessor;

		private var timelineWrapperQueueFactory:TimelineWrapperQueueFactory;

		[Before]
		public function setup():void
		{
			timelineWrapperQueueFactory = TimelineWrapperQueueFactory.getInstance();
			timelineWrapperQueueFactory.collectionAccessor = accessor;
		}

		[After]
		public function teardown():void
		{
			timelineWrapperQueueFactory.destroy();
		}
		
		[Test]
		public function should_return_correct_instance_type():void
		{
			TimelineWrapperFactoryTestRunner.should_return_correct_instance_type(TimelineWrapperQueue, timelineWrapperQueueFactory);
		}

		[Test]
		public function should_return_new_instance_for_same_movieclip_after_original_instance_destroyed():void
		{
			TimelineWrapperFactoryTestRunner.should_return_new_instance_for_same_movieclip_after_original_instance_destroyed(timelineWrapperQueueFactory);
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function should_throw_error_on_instantiation_by_nonchild_class():void
		{
			TimelineWrapperFactoryTestRunner.should_throw_error_on_instantiation_by_nonchild_class(TimelineWrapperQueueFactory);
		}
		
		[Test]
		public function should_cross_reference_other_factory_type_and_return_this_type():void
		{
			var timelineWrapper:TimelineWrapper = new TimelineWrapper();
			var movieClip:MovieClip = new MovieClip();
			timelineWrapper.wrappedMC = movieClip;
			
			given(timelineWrapperQueueFactory.collectionAccessor.getAnyMatchingITimelineWrapper(any())).willReturn(timelineWrapper);
			var timelineWrapperQueue:TimelineWrapperQueue = TimelineWrapperQueue(timelineWrapperQueueFactory.getOneWrapperPerMC(movieClip));
			
			assertThat(timelineWrapper.isDestroyed(), isFalse());
			assertThat(timelineWrapperQueue.isDestroyed(), isFalse());
			
			assertThat(timelineWrapperQueue.undecorate(), equalTo(timelineWrapper));
		}
	}
}