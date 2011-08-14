package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.DummyTimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.builder.dto.BuilderDTO;
	import com.percentjuice.utils.timelineWrappers.builder.dto.BuilderDTOResetter;
	import com.percentjuice.utils.timelineWrappers.builder.dto.BuilderDTOSetter;
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperFactory;
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperQueueFactory;

	public class TimelineWrapperCompleteBuilder implements ITimelineWrapperCompleteBuilder
	{
		protected static var builderDTO:BuilderDTO;
		protected static var nullTimelineWrapper:DummyTimelineWrapper;
		protected var _timelineWrapper:ITimelineWrapper;

		private static var builderDTOResetter:BuilderDTOResetter;
		private static var builderDTOSetter:BuilderDTOSetter;

		public function TimelineWrapperCompleteBuilder()
		{
			builderDTO = new BuilderDTO();
			builderDTOResetter = new BuilderDTOResetter(builderDTO);
			builderDTOSetter = new BuilderDTOSetter(builderDTO);
		}

		public function build():ITimelineWrapper
		{
			builderDTOSetter.setProps(timelineWrapper);

			if (builderDTO.queueEnabled)
			{
				builderDTOSetter.setQueueProps(timelineWrapper as TimelineWrapperQueue);
			}

			builderDTOResetter.reset();

			return _timelineWrapper;
		}

		protected function get timelineWrapper():ITimelineWrapper
		{
			if (_timelineWrapper == nullTimelineWrapper)
				buildTimelineWrapper();

			return _timelineWrapper;
		}

		private function buildTimelineWrapper():void
		{
			if (builderDTO.preventRewrapping)
			{
				createTimelineWrapperFromFactory(builderDTO.queueEnabled);
			}
			else
			{
				createTimelineWrapper(builderDTO.queueEnabled);
			}
		}

		private function createTimelineWrapperFromFactory(queueEnabled:Boolean):void
		{
			_timelineWrapper = (queueEnabled) ? TimelineWrapperQueueFactory.getInstance().getOneWrapperPerMC(builderDTO.wrappedMC) : TimelineWrapperFactory.getInstance().getOneWrapperPerMC(builderDTO.wrappedMC);
		}

		private function createTimelineWrapper(queueEnabled:Boolean):void
		{
			_timelineWrapper = (queueEnabled) ? new TimelineWrapperQueue(new TimelineWrapper()) : new TimelineWrapper();
			_timelineWrapper.wrappedMC = builderDTO.wrappedMC;
		}
	}
}
