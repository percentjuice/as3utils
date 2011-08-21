package com.percentjuice.utils.timelineWrappers.builder
{
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class TimelineWrapperBuilder extends TimelineWrapperSetter implements ITimelineWrapperRequiredParamSetter
	{
		protected static var allowInstantiation:Boolean;

		private static const SINGLETON_ERROR:String = "Instantiation failed: use TimelineWrapperBuilder.initialize() method to retrieve Builder instance.";
		private static var instance:TimelineWrapperBuilder;

		public function TimelineWrapperBuilder()
		{
			if (allowInstantiation)
			{
				return;
			}
			else
			{
				throw new IllegalOperationError(SINGLETON_ERROR);
			}
		}

		private static function getInstance():TimelineWrapperBuilder
		{
			if (!instance)
			{
				allowInstantiation = true;
				instance = new TimelineWrapperBuilder();
				allowInstantiation = false;
			}
			return instance;
		}

		public static function initialize():ITimelineWrapperRequiredParamSetter
		{
			if (instance != null)
			{
				instance._timelineWrapper = nullTimelineWrapper;
			}

			return getInstance();
		}

		public function setWrappedMC(wrappedMC:MovieClip):ITimelineWrapperSetter
		{
			builderDTO.wrappedMC = wrappedMC;
			return this;
		}

	}
}
