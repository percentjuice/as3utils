package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperSetter extends TimelineWrapperFinish implements ITimelineWrapperSetter
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
		
		public function setOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = concatParams;
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onceOnCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = concatParams;
			return this;
		}

		public function setQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.queueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = concatParams;
			return this;
		}

		public function setOnceQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean = false, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onceQueueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = concatParams;
			return this;
		}

		public function buildWithAutoPlayFunction():ITimelineWrapperPlay
		{
			return new TimelineWrapperPlay(this);
		}
	}
}
