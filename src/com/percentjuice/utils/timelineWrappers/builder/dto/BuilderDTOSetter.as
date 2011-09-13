package com.percentjuice.utils.timelineWrappers.builder.dto
{
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.ITimelineWrapperQueue;
	import com.percentjuice.utils.timelineWrappers.UntypedSignal;

	import org.osflash.signals.Signal;

	public class BuilderDTOSetter
	{
		private var builderDTO:BuilderDTO;

		public function BuilderDTOSetter(builderDTO:BuilderDTO)
		{
			this.builderDTO = builderDTO;
		}

		public function setProps(to:ITimelineWrapper):void
		{
			applyParam(builderDTO.onCompleteHandler, onHandlerSetter(to.onComplete));
			applyParam(builderDTO.onceOnCompleteHandler, onHandlerSetter(to.onComplete));
			applyParam(builderDTO.onceOnDestroyHandler, to.onDestroy.addOnce);
			applyParams(true, builderDTO.onDestroyHandlerParams, onParamsSetter(to.onDestroy));
			applyParams(builderDTO.firstCompleteParamIsTimelineWrapper, builderDTO.onCompleteHandlerParams, onParamsSetter(to.onComplete));

			to.destroyAfterComplete = builderDTO.destroyAfterComplete;
		}

		public function setQueueProps(to:ITimelineWrapperQueue):void
		{
			applyParam(builderDTO.queueCompleteHandler, onHandlerSetter(to.queueComplete));
			applyParam(builderDTO.onceQueueCompleteHandler, onHandlerSetter(to.queueComplete));
			applyParams(builderDTO.firstQueueCompleteParamIsTimelineWrapper, builderDTO.queueCompleteHandlerParams, onParamsSetter(to.queueComplete));
			applyParam(builderDTO.playWhenQueueEmptyParams, to.playWhenQueueEmpty);
		}

		private function applyParam(applyParam:*, to:Function):void
		{
			if (applyParam == null)
				return;

			to(applyParam);
		}

		private function applyParams(applyParam1:*, applyParam2:*, to:Function):void
		{
			to(applyParam1, applyParam2);
		}

		private function onHandlerSetter(to:Signal):Function
		{
			return (to as UntypedSignal).setOnDispatchHandler;
		}

		private function onParamsSetter(to:Signal):Function
		{
			return (to as UntypedSignal).setOnDispatchHandlerParams;
		}
	}
}
