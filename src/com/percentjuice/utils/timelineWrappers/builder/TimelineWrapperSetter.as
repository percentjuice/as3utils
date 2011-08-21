package com.percentjuice.utils.timelineWrappers.builder
{
	public class TimelineWrapperSetter extends TimelineWrapperTriggerer implements ITimelineWrapperSetter, ITimelineWrapperSetterHandlerParams, ITimelineWrapperQueueSetterAndTriggerer, ITimelineWrapperQueueSetterHandlerParams
	{
		public function setOnCompleteHandler(handler:Function):ITimelineWrapperSetterHandlerParams
		{
			builderDTO.onCompleteHandler = handler;
			return this;
		}

		public function setOnceOnCompleteHandler(handler:Function):ITimelineWrapperSetterHandlerParams
		{
			builderDTO.onceOnCompleteHandler = handler;
			return this;
		}

		public function addOnCompleteHandlerParams(params:Array):ITimelineWrapperSetter
		{
			builderDTO.onCompleteHandlerParams = params;
			return this;
		}

		public function setOnceOnDestroyHandler(handler:Function):ITimelineWrapperSetter
		{
			builderDTO.onceOnDestroyHandler = handler;
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

		public function addQueueCompleteHandlerParams(params:Array):ITimelineWrapperQueueSetterAndTriggerer
		{
			builderDTO.queueCompleteHandlerParams = params;
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

		public function noOnCompleteHandlerParams():ITimelineWrapperSetter
		{
			return this;
		}
	}
}
