package com.percentjuice.utils.movieClipWrappers
{
	import org.osflash.signals.Signal;
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.mockito.integrations.flexunit4.MockitoRule;

	public class TimelineWrapperSignalTest
	{
		private static var timelineWrapperSignal:TimelineWrapperSignal;

		private const REQUEST:String = "sampleLabelRequest";
		private const HANDLE_SIGNAL_DISPATCHED_SIG_REST:Function = function(e:* = null, ...args):void
		{
		};
		private const HANDLE_SIGNAL_DISPATCHED_SIG_EMPTY:Function = function():void
		{
		};

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
			// timelineWrapperSignal.addOnce(HANDLE_SIGNAL_DISPATCHED_SIG_EMPTY);
			// timelineWrapperSignal.addOnce(HANDLE_SIGNAL_DISPATCHED_SIG_REST);
			
			var signal:Signal = new Signal();
			signal.strict = false;
			signal.add(handleSignalDispatch);
			try
			{
				signal.dispatch(new String("test"));
			}
			catch (error:ArgumentError)
			{
				throw new ArgumentError("Dispatcher may be forcing a signature.  Threw:\r\r" + error);
			}
		}

		private function handleSignalDispatch():void
		{
		}
	}
}


