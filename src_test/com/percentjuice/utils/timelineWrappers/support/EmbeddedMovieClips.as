package com.percentjuice.utils.timelineWrappers.support
{
	public class EmbeddedMovieClips
	{
		[Embed(source="./assets/testMC_labels.swf", mimeType="application/octet-stream")]
		public static const TESTMC_LABELS:Class;

		[Embed(source="./assets/testMC_noLabels.swf", mimeType="application/octet-stream")]
		public static const TESTMC_NOLABELS:Class;

		[Embed(source="./assets/testMC_2Frames.swf", mimeType="application/octet-stream")]
		public static const TESTMC_2FRAMES:Class;

		[Embed(source="./assets/testMC_1Frame.swf", mimeType="application/octet-stream")]
		public static const TESTMC_1FRAME:Class;

		private var getAssetClass:Function;
		private var _assetLabels:Vector.<String>;

		public function EmbeddedMovieClips(getAssetClass:Function, assetLabels:Vector.<String>)
		{
			this.getAssetClass = getAssetClass;
			_assetLabels = assetLabels;
		}

		public function get assetClass():Class
		{
			return getAssetClass();
		}

		public function get assetLabels():Vector.<String>
		{
			return _assetLabels;
		}
	}
}


