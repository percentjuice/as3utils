package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.*;
	import com.percentjuice.utils.timelineWrappers.builder.dto.*;
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperQueueSetDefaultFactory;

	public class TimelineWrapperCompleteBuilder implements ITimelineWrapperCompleteBuilder
	{
		protected static var builderDTO:BuilderDTO;
		protected static var nullTimelineWrapper:ITimelineWrapperQueueSetDefault;
		protected var _timelineWrapper:ITimelineWrapperQueueSetDefault;

		private static var builderDTOResetter:BuilderDTOResetter;
		private static var builderDTOSetter:BuilderDTOSetter;

		public function TimelineWrapperCompleteBuilder()
		{
			builderDTO = new BuilderDTO();
			builderDTOResetter = new BuilderDTOResetter(builderDTO);
			builderDTOSetter = new BuilderDTOSetter(builderDTO);
		}

		public function build():ITimelineWrapperQueueSetDefault
		{
			builderDTOSetter.setProps(timelineWrapper);
			builderDTOResetter.reset();

			return _timelineWrapper;
		}

		protected function get timelineWrapper():ITimelineWrapperQueueSetDefault
		{
			if (_timelineWrapper == nullTimelineWrapper)
			{
				createTimelineWrapperPerRewrapSetting();
			}
			return _timelineWrapper;
		}

		private function createTimelineWrapperPerRewrapSetting():void
		{
			if (builderDTO.preventRewrapping)
			{
				createTimelineWrapperFromFactory();
			}
			else
			{
				createTimelineWrapper();
			}
		}

		private function createTimelineWrapperFromFactory():void
		{
			_timelineWrapper = TimelineWrapperQueueSetDefaultFactory.getInstance().getOneWrapperPerMC(builderDTO.wrappedMC) as ITimelineWrapperQueueSetDefault;
		}

		private function createTimelineWrapper():void
		{
			_timelineWrapper = new TimelineWrapperQueueSetDefault(new TimelineWrapperQueue(new TimelineWrapper()));
			_timelineWrapper.wrappedMC = builderDTO.wrappedMC;
		}
	}
}
