package com.percentjuice.utils.timelineWrappers.builder.dto
{
	public class BuilderDTOResetter
	{
		private var builderDTO:BuilderDTO;

		public function BuilderDTOResetter(dataTO:BuilderDTO)
		{
			this.builderDTO = dataTO;
		}
		
		public function reset():void
		{
			builderDTO.wrappedMC = null;
			builderDTO.onCompleteHandler = null;
			builderDTO.onceOnCompleteHandler = null;
			builderDTO.onCompleteHandlerParams = null;
			builderDTO.firstCompleteParamIsTimelineWrapper = false;
			builderDTO.destroyAfterComplete = false;
			builderDTO.playQueue = null;
			builderDTO.queueCompleteHandler = null;
			builderDTO.onceQueueCompleteHandler = null;
			builderDTO.queueCompleteHandlerParams = null;
			builderDTO.firstQueueCompleteParamIsTimelineWrapper = false;
			builderDTO.playLoopedWhenQueueEmpty = null;
			builderDTO.preventRewrapping = false;
		}
	}
}
