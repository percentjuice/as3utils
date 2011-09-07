package com.percentjuice.utils.timelineWrappers
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;

	public class FrameLabelCalculator
	{
		private var wrappedMC:MovieClip;
		private var l:int;

		private function wrappedMCHasNoLabels():Boolean
		{
			if (l == -1)
			{
				return true;
			}
			return false;
		}

		public function getFrameBeforeNextLabel(wrappedMC:MovieClip, frame:Object):int
		{
			this.wrappedMC = wrappedMC;
			l = wrappedMC.currentLabels.length - 1;

			if (wrappedMCHasNoLabels())
				return wrappedMC.totalFrames;

			// int(String) == 0
			if (int(frame) > 0)
				return getFrameBeforeNextLabelFromThisFrame(int(frame));

			if (String(frame) == null)
				throw new ArgumentError("Not a locatable Frame: '" + frame + "'");

			return getFrameBeforeNextLabelFromThisLabel(String(frame));
		}

		private function getFrameBeforeNextLabelFromThisFrame(frameNumber:int):int
		{
			// no label after this frame
			if ( frameNumber >= (wrappedMC.currentLabels[l] as FrameLabel).frame )
				return wrappedMC.totalFrames;

			// at label below frameNumber
			for (--l; l != -1; l+=-1)
			{
				if ( frameNumber >= (wrappedMC.currentLabels[l] as FrameLabel).frame )
				{
					return nextLabelMinusOneFrame();
				}
			}

			// no label below frameNumber, return first label minus one frame
			l = -1;
			return nextLabelMinusOneFrame();
		}

		private function getFrameBeforeNextLabelFromThisLabel(label:String):int
		{
			// no label after this label
			if ( label == (wrappedMC.currentLabels[l] as FrameLabel).name )
				return wrappedMC.totalFrames;

			// at matching label
			for (--l; l != -1; l+=-1)
			{
				if ( label == (wrappedMC.currentLabels[l] as FrameLabel).name )
				{
					return nextLabelMinusOneFrame();
				}
			}

			throw new ArgumentError('Label "' + label + '" not found in ' + wrappedMC);
			return -1;
		}

		private function nextLabelMinusOneFrame():int
		{
			return (wrappedMC.currentLabels[l + 1] as FrameLabel).frame - 1;
		}
	}
}
