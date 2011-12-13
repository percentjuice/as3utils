package com.percentjuice.utils.timelineWrappers.support
{
	import flash.display.MovieClip;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;


	public class MovieClipsLoaded
	{
		protected static var loadComplete:Boolean;

		protected static var mcWithLabels:MovieClip;
		protected static var mcWithoutLabels:MovieClip;
		protected static var mcWith1Frame:MovieClip;

		private static var mcLoader:EmbeddedMovieClipLoader;
		
		[Before(async, order=1)]
		public function loadAssets():void
		{
			if (loadComplete)
				return;

			mcLoader = new EmbeddedMovieClipLoader();
			handleSignal(this, mcLoader.loadComplete, handleMovieWithLabelsLoaded, 5000);
			mcLoader.load(EmbeddedMovieClips.TESTMC_LABELS);
		}

		private function handleMovieWithLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithLabels = MovieClip(event.args[1]);

			handleSignal(this, mcLoader.loadComplete, handleMovieWithoutLabelsLoaded, 1000);
			mcLoader.load(EmbeddedMovieClips.TESTMC_NOLABELS);
		}

		private function handleMovieWithoutLabelsLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWithoutLabels = MovieClip(event.args[1]);

			handleSignal(this, mcLoader.loadComplete, handleMovieWith1FrameLoaded, 1000);
			mcLoader.load(EmbeddedMovieClips.TESTMC_1FRAME);
		}

		private function handleMovieWith1FrameLoaded(event:SignalAsyncEvent, passThroughData:*):void
		{
			mcWith1Frame = MovieClip(event.args[1]);

			loadComplete = true;
			mcLoader = null;
		}
	}
}
