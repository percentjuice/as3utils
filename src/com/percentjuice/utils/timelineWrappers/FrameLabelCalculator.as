package com.percentjuice.utils.timelineWrappers
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	public class FrameLabelCalculator
	{
		private var wrappedMC:MovieClip;
		private var l:int;

		internal function from(wrappedMC:MovieClip):FrameLabelCalculator
		{
			this.wrappedMC = wrappedMC;
			return this;
		}

		internal function getNextLabelMinusOneFrameOrGetTotalFrames(frame:Object):int
		{
			l = wrappedMC.currentLabels.length - 1;

			if (wrappedMC.currentLabels.length == 0 || (String(frame) == (wrappedMC.currentLabels[l] as FrameLabel).name) || (int(frame) > 0 && (wrappedMC.currentLabels[l] as FrameLabel).frame <= frame))
			{
				return wrappedMC.totalFrames;
			}
			else
			{
				if (int(frame) > 0)
					frame = getLabelForFrame(int(frame));

				if (String(frame) == null)
					throw new IllegalOperationError("Not a settable Frame: '" + frame + "'");

				return getNextLabelMinusOneFrame(String(frame));
			}
		}

		/**
		 * @throws IllegalOperationError if MovieClip has no label @frame
		 */
		private function getLabelForFrame(frame:int):String
		{
			for (l = wrappedMC.currentLabels.length - 1; l != -1; l+=-1)
			{
				var fl:FrameLabel = wrappedMC.currentLabels[l];
				if (fl.frame <= frame)
				{
					return FrameLabel(wrappedMC.currentLabels[l]).name;
				}
			}
			throw new IllegalOperationError('Frame "' + frame + '" not found in ' + wrappedMC);
		}

		internal function getNextLabelMinusOneFrame(label:String):int
		{
			l = wrappedMC.currentLabels.length;

			for (var i:int = 0; i < l; i++)
			{
				var fl:FrameLabel = wrappedMC.currentLabels[i];
				if (fl.name == label)
				{
					var nextLabel:FrameLabel = FrameLabel(wrappedMC.currentLabels[i + 1]);
					return nextLabel.frame - 1;
				}
			}
			throw new IllegalOperationError('Label "' + label + '" not found in ' + wrappedMC);
		}
	}
}
