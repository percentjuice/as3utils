package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperSetter extends TimelineWrapperPlayFinish implements ITimelineWrapperSetter
	{
		public function addDestroyAfterComplete():ITimelineWrapperSetter
		{
			builderDTO.destroyAfterComplete = true;
			return this;
		}

		public function addRewrappingPrevention():ITimelineWrapperSetter
		{
			builderDTO.preventRewrapping = true;
			return this;
		}

		public function setAFallbackLoopedAnimation(frame:Object):ITimelineWrapperSetter
		{
			builderDTO.playLoopedWhenQueueEmpty = frame;
			return this;
		}
		
		public function setOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter
		{
			builderDTO.onCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = params;
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter
		{
			builderDTO.onceOnCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = params;
			return this;
		}

		public function setQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter
		{
			builderDTO.queueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = params;
			return this;
		}

		public function setOnceQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, ...params):ITimelineWrapperSetter
		{
			builderDTO.onceQueueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = params;
			return this;
		}

		public function buildWithAutoPlayFunction():ITimelineWrapperPlayFinish
		{
			return this;
		}
	}
}
