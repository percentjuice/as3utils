package com.percentjuice.utils.timelineWrappers.support
{
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.MovieClip;

	public class MCLoaded
	{
		protected static var loadComplete:Boolean;

		protected static var propsForLabelsTest:MCProperties;
		protected static var propsForNoLabelsTest:MCProperties;
		protected static var propsFor1FrameTest:MCProperties;

		protected static var mcWithLabels:MovieClip;
		protected static var mcWithoutLabels:MovieClip;
		protected static var mcWith1Frame:MovieClip;

		private static var mcLoader:MCLoader;
		
		[Before(async, order=1)]
		public function loadAssets():void
		{
			if (loadComplete)
				return;

			propsForLabelsTest = MCProperties.mcWithLabels;
			propsForNoLabelsTest = MCProperties.mcWithoutLabels;
			propsFor1FrameTest = MCProperties.mcWith1Frame;

			mcLoader = new MCLoader();
			handleSignal(this, mcLoader.signal_loadComplete, handleMovieWithLabelsLoaded, 5000);
			mcLoader.load(propsForLabelsTest);
		}

		private function handleMovieWithLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithLabels = MovieClip(event.args[1]);

			handleSignal(this, mcLoader.signal_loadComplete, handleMovieWithoutLabelsLoaded, 1000);
			mcLoader.load(propsForNoLabelsTest);
		}

		private function handleMovieWithoutLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithoutLabels = MovieClip(event.args[1]);

			handleSignal(this, mcLoader.signal_loadComplete, handleMovieWith1FrameLoaded, 1000);
			mcLoader.load(propsFor1FrameTest);
		}

		private function handleMovieWith1FrameLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWith1Frame = MovieClip(event.args[1]);

			loadComplete = true;
			mcLoader = null;
		}
	}
}
