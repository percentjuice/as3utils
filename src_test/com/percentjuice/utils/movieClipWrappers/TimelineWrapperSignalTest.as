package com.percentjuice.utils.movieClipWrappers
{
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.mockito.integrations.flexunit4.MockitoRule;

	public class TimelineWrapperSignalTest
	{
		private static var timelineWrapperSignal:TimelineWrapperSignal;
		private var request:String;

		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var iTimelineWrapper:ITimelineWrapper;

		[Before]
		public function setUpBeforeEachTest():void
		{
			timelineWrapperSignal = new TimelineWrapperSignal(iTimelineWrapper);
			request = "sampleLabelRequest";
		}

		[Test]
		public function should_show_that_timelineWrapperSignalClone_has_equal_props_to_timelineWrapperSignal():void
		{
			timelineWrapperSignal.addOnce(handleSignalDispatched);
			timelineWrapperSignal.dispatchSignalClone(request);
		}

		private function handleSignalDispatched(signalClone:TimelineWrapperSignal):void
		{
			assertThat(iTimelineWrapper, equalTo(signalClone.dispatcher));
			assertThat(request, equalTo(signalClone.completedRequest));
		}
	}
}


