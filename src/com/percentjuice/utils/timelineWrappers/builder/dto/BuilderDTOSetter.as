package com.percentjuice.utils.timelineWrappers.builder.dto
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueueSetDefault;
	import com.percentjuice.utils.timelineWrappers.UntypedSignal;

	public class BuilderDTOSetter
	{
		private var builderDTO:BuilderDTO;

		public function BuilderDTOSetter(builderDTO:BuilderDTO)
		{
			this.builderDTO = builderDTO;
		}

		public function setProps(to:ITimelineWrapperQueueSetDefault):void
		{
			to.destroyAfterComplete = builderDTO.destroyAfterComplete;

			applyParam(builderDTO.onCompleteHandler, onHandlerSetter(to.onComplete));
			applyParam(builderDTO.onceOnCompleteHandler, onHandlerSetter(to.onComplete));
			applyParam(builderDTO.queueCompleteHandler, onHandlerSetter(to.queueComplete));
			applyParam(builderDTO.onceQueueCompleteHandler, onHandlerSetter(to.queueComplete));

			applyArgs(builderDTO.firstCompleteParamIsTimelineWrapper, builderDTO.onCompleteHandlerParams, onParamsSetter(to.onComplete));
			applyArgs(builderDTO.firstQueueCompleteParamIsTimelineWrapper, builderDTO.queueCompleteHandlerParams, onParamsSetter(to.queueComplete));

			/* order of play setters is important.  Queue complete is true where no play method is set.  Queue Empty is true where there is no queue. */
			applyParam(builderDTO.playLoopedWhenQueueEmpty, to.setDefaultAnim);
			to.appendToGotoAndPlayUntilNextLabelQueue.apply(null, builderDTO.playQueue);
		}

		private function applyParam(applyParam:*, to:Function):void
		{
			if (applyParam == null)
				return;

			to(applyParam);
		}

		private function applyArgs(applyParam1:Boolean, addArgs:Object, to:Function):void
		{
			if (addArgs == null)
				to(applyParam1);
			else
				to.apply(null, [applyParam1].concat(addArgs));
		}

		private function onHandlerSetter(to:UntypedSignal):Function
		{
			return to.setOnDispatchHandler;
		}

		private function onParamsSetter(to:UntypedSignal):Function
		{
			return to.setOnDispatchHandlerParams;
		}
	}
}
