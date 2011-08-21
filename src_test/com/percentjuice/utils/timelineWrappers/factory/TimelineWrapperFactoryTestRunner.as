package com.percentjuice.utils.timelineWrappers.factory
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.notNullValue;
	import org.mockito.integrations.any;
	import org.mockito.integrations.given;

	public class TimelineWrapperFactoryTestRunner
	{

		public static function should_return_correct_instance_type(classRequired:Class, factory:TimelineWrapperFactory):void
		{
			given(TimelineWrapperFactory.collectionAccessor.getAnyMatchingITimelineWrapper(any())).willReturn(CollectionAccessor.DUMMY_WRAPPER);

			var testInstance:* = classRequired(factory.getOneWrapperPerMC(new MovieClip()));
			assertThat(testInstance, notNullValue);
		}

		public static function should_return_new_instance_for_same_movieclip_after_original_instance_destroyed(factory:TimelineWrapperFactory):void
		{
			var movieClip:MovieClip = new MovieClip();
			
			given(TimelineWrapperFactory.collectionAccessor.getAnyMatchingITimelineWrapper(any())).willReturn(CollectionAccessor.DUMMY_WRAPPER);
			
			var timelineWrapper0:ITimelineWrapper = factory.getOneWrapperPerMC(movieClip);
			timelineWrapper0.destroy();
			
			var timelineWrapper1:ITimelineWrapper = factory.getOneWrapperPerMC(movieClip);
			assertThat(timelineWrapper0, not(timelineWrapper1));
		}

		public static function should_throw_error_on_instantiation_by_nonchild_class(factoryClass:Class):void
		{
			assertThat(new factoryClass(), throws(allOf(instanceOf(IllegalOperationError))));
		}
	}
}