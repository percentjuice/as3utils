package com.percentjuice.utils.timelineWrappers
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	public class FrameLabelCalculator
	{
		private var _wrappedMC:MovieClip;
		private var l:int;

		internal function getFrameBeforeNextLabelOrLastFrame(frame:Object):int
		{
			l = _wrappedMC.currentLabels.length - 1;

			if (_wrappedMC.currentLabels.length == 0 || (String(frame) == (_wrappedMC.currentLabels[l] as FrameLabel).name) || (int(frame) > 0 && (_wrappedMC.currentLabels[l] as FrameLabel).frame <= frame))
			{
				return _wrappedMC.totalFrames;
			}
			else
			{
				if (int(frame) > 0)
					frame = getLabelForFrame(int(frame));

				if (String(frame) == null)
					throw new IllegalOperationError("Not a settable Frame: '" + frame + "'");

				return getFrameBeforeNextLabel(String(frame));
			}
		}

		internal function getLabelForFrame(frame:int):String
		{
			for (l = _wrappedMC.currentLabels.length - 1; l != -1; l+=-1)
			{
				var fl:FrameLabel = _wrappedMC.currentLabels[l];
				if (fl.frame <= frame)
				{
					return FrameLabel(_wrappedMC.currentLabels[l]).name;
				}
			}
			throw new IllegalOperationError('Frame "' + frame + '" not found in ' + _wrappedMC);
		}

		internal function getFrameBeforeNextLabel(label:String):int
		{
			l = _wrappedMC.currentLabels.length;

			for (var i:int = 0; i < l; i++)
			{
				var fl:FrameLabel = _wrappedMC.currentLabels[i];
				if (fl.name == label)
				{
					var nextLabel:FrameLabel = FrameLabel(_wrappedMC.currentLabels[i + 1]);
					return nextLabel.frame - 1;
				}
			}
			throw new IllegalOperationError('Label "' + label + '" not found in ' + _wrappedMC);
		}

		internal function set wrappedMC(wrappedMC:MovieClip):void
		{
			_wrappedMC = wrappedMC;
		}
	}
}
