package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperSetter extends TimelineWrapperTriggerer implements ITimelineWrapperSetter, ITimelineWrapperCompleteHandlerParams, ITimelineWrapperQueueSetterAndTriggerer, ITimelineWrapperQueueSetterHandlerParams, ITimelineWrapperDestroyHandlerParams
	{
		public function setOnCompleteHandler(handler:Function):ITimelineWrapperCompleteHandlerParams
		{
			builderDTO.onCompleteHandler = handler;
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperCompleteHandlerParams
		{
			builderDTO.onceOnCompleteHandler = handler;
			return this;
		}

		public function addOnCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperSetter
		{
			builderDTO.firstCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.onCompleteHandlerParams = concatParams;
			return this;
		}

		public function noOnCompleteHandlerParams():ITimelineWrapperSetter
		{
			return this;
		}

		public function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperDestroyHandlerParams
		{
			builderDTO.onceOnDestroyHandler = handler;
			return this;
		}

		public function concatParamsToTimelineWrapper(concatParams:Array):ITimelineWrapperSetter
		{
			builderDTO.onDestroyHandlerParams = concatParams;
			return this;
		}
		
		public function noAdditionalOnDestroyHandlerParams():ITimelineWrapperSetter
		{
			return this;
		}

		public function setDestroyAfterComplete():ITimelineWrapperSetter
		{
			builderDTO.destroyAfterComplete = true;
			return this;
		}

		public function playWhenQueueEmpty(frame:Object):ITimelineWrapperQueueSetterAndTriggerer
		{
			builderDTO.playWhenQueueEmptyParams = [frame];
			return this;
		}

		public function setRewrappingPrevention():ITimelineWrapperSetter
		{
			builderDTO.preventRewrapping = true;
			return this;
		}

		public function addQueuingAbility():ITimelineWrapperQueueSetterAndTriggerer
		{
			builderDTO.queueEnabled = true;
			return this;
		}
		
		public function noAdditionalQueueOptions():ITimelineWrapperSetter
		{
			return this;
		}

		public function setQueueCompleteHandler(handler:Function):ITimelineWrapperQueueSetterHandlerParams
		{
			builderDTO.queueCompleteHandler = handler;
			return this;
		}

		public function setOnceQueueCompleteHandler(handler:Function):ITimelineWrapperQueueSetterHandlerParams
		{
			builderDTO.onceQueueCompleteHandler = handler;
			return this;
		}

		public function addQueueCompleteHandlerParams(firstParamIsTimelineWrapper:Boolean, concatParams:Array = null):ITimelineWrapperQueueSetterAndTriggerer
		{
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = firstParamIsTimelineWrapper;
			builderDTO.queueCompleteHandlerParams = concatParams;
			return this;
		}

		public function noQueueCompleteHandlerParams():ITimelineWrapperQueueSetterAndTriggerer
		{
			return this;
		}

		public function addAutoPlayFunction():ITimelineWrapperTriggerer
		{
			return this;
		}
	}
}
