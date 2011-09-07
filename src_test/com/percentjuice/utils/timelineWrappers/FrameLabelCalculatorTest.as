package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.timelineWrappers.support.MovieClipsLoaded;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;

	public class FrameLabelCalculatorTest extends MovieClipsLoaded
	{
		private var calculator:FrameLabelCalculator;

		[Before]
		public function setup():void
		{
			calculator = new FrameLabelCalculator();
		}

		[Test]
		public function passing_in_frame_where_no_label_exists_should_return_next_label_minus_one_frame():void
		{
			var frameBeforeNextLabel:int = calculator.getFrameBeforeNextLabel(mcWithLabels, 1);

			assertThat(frameBeforeNextLabel, equalTo(1));
		}

		[Test]
		public function movieClips_with_no_subsequent_labels_should_return_totalFrames():void
		{
			should_return_totalFrames(mcWithoutLabels, mcWith1Frame.totalFrames >> 1);
			should_return_totalFrames(mcWith1Frame, mcWith1Frame.totalFrames >> 1);
			should_return_totalFrames(mcWithLabels, mcWithLabels.totalFrames);
		}
		
		private function should_return_totalFrames(target:MovieClip, start:Object):void
		{
			var frameBeforeNextLabel:int = calculator.getFrameBeforeNextLabel(target, start);

			assertThat(frameBeforeNextLabel, equalTo(target.totalFrames));
		}

		[Test]
		public function movieClips_with_labels_should_return_next_label_minus_one_frame():void
		{
			should_return_next_label_minus_one_frame(FrameLabel(mcWithLabels.currentLabels[0]).name, FrameLabel(mcWithLabels.currentLabels[1]).frame - 1);
			should_return_next_label_minus_one_frame(FrameLabel(mcWithLabels.currentLabels[1]).name, FrameLabel(mcWithLabels.currentLabels[2]).frame - 1);
			should_return_next_label_minus_one_frame(FrameLabel(mcWithLabels.currentLabels[2]).name, FrameLabel(mcWithLabels.currentLabels[3]).frame - 1);

			should_return_next_label_minus_one_frame(1, FrameLabel(mcWithLabels.currentLabels[0]).frame - 1);
		}

		private function should_return_next_label_minus_one_frame(startData:Object, expectedResult:int):void
		{
			var frameBeforeNextLabel:int = calculator.getFrameBeforeNextLabel(mcWithLabels, startData);

			assertThat(frameBeforeNextLabel, equalTo(expectedResult));
		}
	}
}
