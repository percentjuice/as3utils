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
			applyFunction(builderDTO.onCompleteHandler, onUntypedSignalHandler(to.onComplete));
			applyFunction(builderDTO.onceOnCompleteHandler, onUntypedSignalHandler(to.onComplete));
			applyFunction(builderDTO.onceOnDestroyHandler, to.onDestroy.addOnce);
			applyFunction(builderDTO.onCompleteHandlerParams, onUntypedSignalHandlerParams(to.onComplete));

			to.destroyAfterComplete = builderDTO.destroyAfterComplete;
		}

		public function setQueueProps(to:ITimelineWrapperQueue):void
		{
			applyFunction(builderDTO.queueCompleteHandler, onUntypedSignalHandler(to.queueComplete));
			applyFunction(builderDTO.onceQueueCompleteHandler, onUntypedSignalHandler(to.queueComplete));
			applyFunction(builderDTO.queueCompleteHandlerParams, onUntypedSignalHandlerParams(to.queueComplete));
			applyFunction(builderDTO.playWhenQueueEmptyParams, to.playWhenQueueEmpty);
		}

		private function applyFunction(from:*, to:Function):void
		{
			if (from == null)
				return;

			to(from);
		}

		private function onUntypedSignalHandler(to:Signal):Function
		{
			return (to as UntypedSignal).setOnDispatchHandler;
		}

		private function onUntypedSignalHandlerParams(to:Signal):Function
		{
			return (to as UntypedSignal).setOnDispatchHandlerParams;
		}
	}
}
