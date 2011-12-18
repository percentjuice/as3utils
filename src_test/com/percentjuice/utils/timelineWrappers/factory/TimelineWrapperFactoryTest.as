package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.pj_as3utils_namespace;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;

	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.mockito.integrations.any;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;

	import flash.display.MovieClip;

	public class TimelineWrapperFactoryTest
	{
		use namespace pj_as3utils_namespace;

		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var accessor:CollectionAccessor;

		private var timelineWrapperFactory:TimelineWrapperFactory;

		[Before]
		public function setup():void
		{
			timelineWrapperFactory = TimelineWrapperFactory.getInstance();
			timelineWrapperFactory.collectionAccessor = accessor;
		}

		[After]
		public function teardown():void
		{
			timelineWrapperFactory.destroy();
		}

		[Test]
		public function should_return_correct_instance_type():void
		{
			TimelineWrapperFactoryTestRunner.should_return_correct_instance_type(TimelineWrapper, timelineWrapperFactory);
		}

		[Test]
		public function should_return_new_instance_for_same_movieclip_after_original_instance_destroyed():void
		{
			TimelineWrapperFactoryTestRunner.should_return_new_instance_for_same_movieclip_after_original_instance_destroyed(timelineWrapperFactory);
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function should_throw_error_on_instantiation_by_nonchild_class():void
		{
			TimelineWrapperFactoryTestRunner.should_throw_error_on_instantiation_by_nonchild_class(TimelineWrapperFactory);
		}
		
		[Test]
		public function should_cross_reference_other_factory_type_and_return_this_type():void
		{
			var timelineWrapper0:TimelineWrapper = new TimelineWrapper();
			var movieClip:MovieClip = new MovieClip();
			timelineWrapper0.wrappedMC = movieClip;
			var timelineWrapperQueue:TimelineWrapperQueue = new TimelineWrapperQueue(timelineWrapper0);
			
			given(timelineWrapperFactory.collectionAccessor.getAnyMatchingITimelineWrapper(any())).willReturn(timelineWrapperQueue);
			var timelineWrapper1:TimelineWrapper = TimelineWrapper(timelineWrapperFactory.getOneWrapperPerMC(movieClip));
			
			assertThat(timelineWrapper0, equalTo(timelineWrapper1));

			assertThat(timelineWrapper0.isDestroyed(), isFalse());
			assertThat(timelineWrapperQueue.isDestroyed(), isTrue());
		}
	}
}