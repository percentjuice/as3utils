package com.percentjuice.utils.timelineWrappers.support
{
	public class MCProperties
	{
		public static var mcWithLabels:MCProperties = new MCProperties(getTESTMC_LABELS, new <String>[LABEL0, LABEL1, LABEL2, LABEL3]);
		public static var mcWithoutLabels:MCProperties = new MCProperties(getTESTMC_NOLABELS, new <String>[]);
		public static var mcWith2Frames:MCProperties = new MCProperties(getTESTMC_2FRAMES, new <String>[]);
		public static var mcWith1Frame:MCProperties = new MCProperties(getTESTMC_1FRAME, new <String>[]);

		[Embed(source="./assets/testMC_labels.swf", mimeType="application/octet-stream")]
		private static const TESTMC_LABELS:Class;

		[Embed(source="./assets/testMC_noLabels.swf", mimeType="application/octet-stream")]
		private static const TESTMC_NOLABELS:Class;

		[Embed(source="./assets/testMC_2Frames.swf", mimeType="application/octet-stream")]
		private static const TESTMC_2FRAMES:Class;

		[Embed(source="./assets/testMC_1Frame.swf", mimeType="application/octet-stream")]
		private static const TESTMC_1FRAME:Class;

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

		private static function getTESTMC_2FRAMES():Class
		{
			return TESTMC_2FRAMES;
		}

		private static function getTESTMC_1FRAME():Class
		{
			return TESTMC_1FRAME;
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


