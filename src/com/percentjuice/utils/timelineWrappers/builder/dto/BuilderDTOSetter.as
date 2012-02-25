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

		public function setPreRunProps(target:ITimelineWrapperQueueSetDefault):void
		{
			target.destroyAfterComplete = builderDTO.destroyAfterComplete;

			applyParam(builderDTO.onCompleteHandler, onHandlerSetter(target.onComplete));
			applyParam(builderDTO.onceOnCompleteHandler, onHandlerSetter(target.onComplete));
			applyParam(builderDTO.queueCompleteHandler, onHandlerSetter(target.queueComplete));
			applyParam(builderDTO.onceQueueCompleteHandler, onHandlerSetter(target.queueComplete));

			applyArgs(builderDTO.firstCompleteParamIsTimelineWrapper, builderDTO.onCompleteHandlerParams, onParamsSetter(target.onComplete), target);
			applyArgs(builderDTO.firstQueueCompleteParamIsTimelineWrapper, builderDTO.queueCompleteHandlerParams, onParamsSetter(target.queueComplete), target);
		}

		/* order of play setters is important.  Queue complete is true where no play method is set.  Queue Empty is true where there is no queue. */
		public function setPostRunProps(to:ITimelineWrapperQueueSetDefault):void
		{
			applyParam(builderDTO.playLoopedWhenQueueEmpty, to.setDefaultAnim);
		}

		private function applyParam(applyParam:*, to:Function):void
		{
			if (applyParam == null)
				return;

			to(applyParam);
		}

		private function applyArgs(applyParam:Boolean, addArgs:Object, targetFunction:Function, target:ITimelineWrapperQueueSetDefault):void
		{
			if (applyParam == false && addArgs == null)
				return;
			else if (addArgs == null)
				targetFunction(applyParam);
			else if (applyParam == false)
				targetFunction.apply(null, [false].concat(addArgs));
			else
				targetFunction.apply(null, [false].concat(target, addArgs));
		}

		private function onHandlerSetter(signal:UntypedSignal):Function
		{
			return signal.setOnDispatchHandler;
		}

		private function onParamsSetter(signal:UntypedSignal):Function
		{
			return signal.setOnDispatchHandlerParams;
		}
	}
}
