package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import org.flexunit.rules.IMethodRule;
	import org.mockito.integrations.flexunit4.MockitoRule;


	public class TimelineWrapperFactoryTest
	{
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var accessor:CollectionAccessor;

		private var timelineWrapperFactory:TimelineWrapperFactory;

		[Before]
		public function setup():void
		{
			timelineWrapperFactory = TimelineWrapperFactory.getInstance();
			timelineWrapperFactory._collectionAccessor = accessor;
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
	}
}