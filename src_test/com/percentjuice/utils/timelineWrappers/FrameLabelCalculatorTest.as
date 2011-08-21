package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.timelineWrappers.support.MCLoaded;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class FrameLabelCalculatorTest extends MCLoaded
	{
		private var calculator:FrameLabelCalculator;

		[Before]
		public function setup():void
		{
			calculator = new FrameLabelCalculator();
		}

//		[Test] TODO: to fix for MovieClips with gaps in the label structure.
		public function passing_in_frame_where_no_label_exists_should_return_next_label_or_end():void
		{
			var frameBeforeNextLabel:int = calculator.from(mcWithLabels).getNextLabelMinusOneFrameOrGetTotalFrames(1);

			assertThat(frameBeforeNextLabel, equalTo(1));
		}
	}
}
