package com.percentjuice.utils.timelineWrappers.builder
{
	import com.percentjuice.utils.timelineWrappers.*;
	import com.percentjuice.utils.timelineWrappers.builder.dto.*;
	import com.percentjuice.utils.timelineWrappers.factory.TimelineWrapperQueueSetDefaultFactory;

	public class TimelineWrapperFinish implements ITimelineWrapperFinish
	{
		internal static var builderDTO:BuilderDTO;
		internal static var nullTimelineWrapper:ITimelineWrapperQueueSetDefault;

		private static var builderDTOResetter:BuilderDTOResetter;
		private static var builderDTOSetter:BuilderDTOSetter;

		internal var _timelineWrapper:ITimelineWrapperQueueSetDefault;

		public function TimelineWrapperFinish()
		{
			builderDTO = new BuilderDTO();
			builderDTOResetter = new BuilderDTOResetter(builderDTO);
			builderDTOSetter = new BuilderDTOSetter(builderDTO);
		}

		public function build():ITimelineWrapperQueueSetDefault
		{
			preBuild();
			postBuild();

			return _timelineWrapper;
		}

		protected function preBuild():void
		{
			builderDTOSetter.setPreRunProps(timelineWrapper);
		}

		protected function postBuild():void
		{
			builderDTOSetter.setPostRunProps(timelineWrapper);
			builderDTOResetter.reset();
		}

		internal function get timelineWrapper():ITimelineWrapperQueueSetDefault
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
