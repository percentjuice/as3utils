package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperSetter extends TimelineWrapperTriggerer implements ITimelineWrapperSetter
	{
		public function setOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = concatParams;
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onceOnCompleteHandler = handler;
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = concatParams;
			return this;
		}

		public function setDestroyAfterComplete():ITimelineWrapperSetter
		{
			builderDTO.destroyAfterComplete = true;
			return this;
		}

		public function setRewrappingPrevention():ITimelineWrapperSetter
		{
			builderDTO.preventRewrapping = true;
			return this;
		}

		public function setQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.queueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = concatParams;
			return this;
		}

		public function setOnceQueueCompleteHandler(handler:Function, firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.onceQueueCompleteHandler = handler;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = concatParams;
			return this;
		}

		public function playWhenQueueEmpty(frame:Object):ITimelineWrapperSetter
		{
			builderDTO.playWhenQueueEmptyParams = [frame];
			return this;
		}

		public function setDefaultAnimation(frame:Object):ITimelineWrapperSetter
		{
			builderDTO.defaultAnim = frame;
			return this;
		}

		public function addAutoPlayFunctionAndBuild():ITimelineWrapperTriggerer
		{
			return this;
		}
	}
}
