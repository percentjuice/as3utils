package com.percentjuice.utils.movieClipWrappers.support
{
	public class MCProperties
	{
		public static var mcWithLabels:MCProperties = new MCProperties(getTESTMC_LABELS, new <String>[LABEL0, LABEL1, LABEL2, LABEL3]);
		public static var mcWithoutLabels:MCProperties = new MCProperties(getTESTMC_NOLABELS, new <String>[]);

		[Embed(source="./assets/testMC_labels.swf", mimeType="application/octet-stream")]
		private static const TESTMC_LABELS:Class;

		[Embed(source="./assets/testMC_noLabels.swf", mimeType="application/octet-stream")]
		private static const TESTMC_NOLABELS:Class;

		private static const LABEL0:String = 'label0';
		private static const LABEL1:String = 'label1';
		private static const LABEL2:String = 'label2';
		private static const LABEL3:String = 'label3';

		private var _assetLabels:Vector.<String>;
		private var getAssetClass:Function;

		public function MCProperties(getAssetClass:Function, assetLabels:Vector.<String>)
		{
			this.getAssetClass = getAssetClass;
			_assetLabels = assetLabels;
		}

		private static function getTESTMC_LABELS():Class
		{
			return TESTMC_LABELS;
		}

		private static function getTESTMC_NOLABELS():Class
		{
			return TESTMC_NOLABELS;
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


