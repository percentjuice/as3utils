package com.percentjuice.utils.movieClipWrappers
{
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.mockito.integrations.flexunit4.MockitoRule;

	public class TimelineWrapperSignalTest
	{
		private static const REQUEST:String = "sampleLabelRequest";
		private static var timelineWrapperSignal:TimelineWrapperSignal;

		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var iTimelineWrapper:ITimelineWrapper;

		[Before]
		public function setUpBeforeEachTest():void
		{
			timelineWrapperSignal = new TimelineWrapperSignal(iTimelineWrapper);
		}

		[Test]
		public function should_show_that_timelineWrapperSignalClone_has_equal_props_to_timelineWrapperSignal():void
		{
			timelineWrapperSignal.addOnce(handleSignalDispatched);
			timelineWrapperSignal.dispatchSignalClone(REQUEST);
		}

		private function handleSignalDispatched(signalClone:TimelineWrapperSignal):void
		{
			assertThat(iTimelineWrapper, equalTo(signalClone.dispatcher));
			assertThat(REQUEST, equalTo(signalClone.completedRequest));
		}


		[Test]
		public function should_not_force_any_signature_in_listener():void
		{
			 signal_should_allow_dispatch(handleSignalDispatch_emptySignature);
		}

		[Test]
		public function should_not_resist_rest_signature_in_listener():void
		{
			 signal_should_allow_dispatch(handleSignalDispatch_restSignature);
		}

		/*
		 * This test fails without merging open pull request 40 from the as3-signals project.
		 * * ref: https://github.com/robertpenner/as3-signals/pull/40
		 */
		private function signal_should_allow_dispatch(listenerFunction:Function):void
		{
			timelineWrapperSignal.addOnce(listenerFunction);
			
			try
			{
				timelineWrapperSignal.dispatchSignalClone(REQUEST);
			}
			catch (error:ArgumentError)
			{
				throw new ArgumentError("Dispatcher may be forcing a signature.  Threw:\r\r" + error);
			}
		}

		private function handleSignalDispatch_emptySignature():void {}
		
		private function handleSignalDispatch_restSignature(e:* = null, ...args):void {}
	}
}


