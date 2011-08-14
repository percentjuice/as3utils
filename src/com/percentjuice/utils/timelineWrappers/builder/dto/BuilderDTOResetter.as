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
			builderDTO.onceOnDestroyHandler = null;
			builderDTO.destroyAfterComplete = false;
			builderDTO.queueEnabled = false;
			builderDTO.playWhenQueueEmptyParams = null;
			builderDTO.queueCompleteHandler = null;
			builderDTO.onceQueueCompleteHandler = null;
			builderDTO.queueCompleteHandlerParams = null;
			builderDTO.preventRewrapping = false;
		}
	}
}
