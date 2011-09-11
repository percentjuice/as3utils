package com.percentjuice.utils.timelineWrappers
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class UntypedSignalTest
	{
		private static const TEST_PARAM:String = "test_param";
		
		private static var timelineWrapper:ITimelineWrapper;
		private static var signal:UntypedSignal;

		[Before]
		public function setup():void
		{
			signal = new UntypedSignal(timelineWrapper);
		}

		[Test]
		public function should_show_that_untyped_signal_dispatches_params():void
		{
			signal.setOnceOnDispatchHandler(handleSignalWithParamDispatched);
			signal.setOnDispatchHandlerParams(false, [TEST_PARAM]);
			signal.dispatchSetParams();
		}

		private function handleSignalWithParamDispatched(param:String):void
		{
			assertThat(TEST_PARAM, equalTo(param));
		}

		[Test(expects="ArgumentError")]
		public function should_force_signature_when_param_set():void
		{
			signal.setOnceOnDispatchHandler(handleSignalDispatch_emptySignature);
			signal.setOnDispatchHandlerParams(false, [TEST_PARAM]);
			assertThat(signal.dispatchSetParams(), throws(allOf(instanceOf(ArgumentError))));
		}

		private function handleSignalDispatch_emptySignature():void
		{
		}

		[Test]
		public function should_not_force_any_signature_in_handler():void
		{
			signal_should_allow_dispatch(handleSignalDispatch_properSignature);
		}

		[Test]
		public function should_not_resist_rest_signature_in_handler():void
		{
			signal_should_allow_dispatch(handleSignalDispatch_restSignature0);
			signal_should_allow_dispatch(handleSignalDispatch_restSignature1);
		}

		private function signal_should_allow_dispatch(handler:Function):void
		{
			signal.setOnceOnDispatchHandler(handler);

			try
			{
				signal.setOnDispatchHandlerParams(false, [TEST_PARAM]);
				signal.dispatchSetParams();
			}
			catch (error:ArgumentError)
			{
				throw new ArgumentError("Dispatcher may be forcing a signature.  Threw:\r\r" + error);
			}
		}

		private function handleSignalDispatch_properSignature(value:String):void
		{
		}

		private function handleSignalDispatch_restSignature0(e:* = null, ...args):void
		{
		}

		private function handleSignalDispatch_restSignature1(...args):void
		{
		}
		
		[Test]
		public function should_dispatch_timelineWrapper_as_first_param():void
		{
			signal.setOnceOnDispatchHandler(handleSignalWithParamsDispatched);
			signal.setOnDispatchHandlerParams(true, [TEST_PARAM]);
			signal.dispatchSetParams();
		}

		private function handleSignalWithParamsDispatched(param1:ITimelineWrapper, param2:String):void
		{
			assertThat(timelineWrapper, equalTo(param1));
			assertThat(TEST_PARAM, equalTo(param2));
		}
	}
}


