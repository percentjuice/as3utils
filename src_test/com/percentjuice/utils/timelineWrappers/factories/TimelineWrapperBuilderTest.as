package com.percentjuice.utils.timelineWrappers.factories
{
	import com.percentjuice.utils.timelineWrappers.TimelineWrapper;
	import com.percentjuice.utils.timelineWrappers.support.MCLoaded;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import flash.utils.setTimeout;

	public class TimelineWrapperBuilderTest extends MCLoaded
	{
		private static const TEST_PARAMS:Array = ["param0", 1, 2];

		private var test_results:Array = [];
		private var builtWrapperDestroy:TimelineWrapper;

		[Before]
		public function setup():void
		{
			test_results.length = 0;
		}

		[Test(async)]
		public function should_pass_params_on_dispatch():void
		{
			var builtWrapper:TimelineWrapper = TimelineWrapper(new TimelineWrapperBuilder(mcWithoutLabels, false)
				.setOnCompleteHandlerParams(TEST_PARAMS)
				.build());
				
			handleSignal(this, builtWrapper.onComplete, handleDispatchWithParams, 1000);
			builtWrapper.gotoAndPlayUntilStop(1, 2);
		}

		private function handleDispatchWithParams(event:SignalAsyncEvent, passThroughData:*):void
		{
			var handlerParams:Array = event.args;
			assertThat(TEST_PARAMS, equalTo(handlerParams));
		}

		[Test(async)]
		public function should_set_onCompleteHandler_and_pass_params_on_dispatch():void
		{
			var builtWrapper:TimelineWrapper = TimelineWrapper(new TimelineWrapperBuilder(mcWithoutLabels, false)
				.setOnCompleteHandler(handleOnCompleteWithParams)
				.setOnCompleteHandlerParams(TEST_PARAMS)
				.build());
				
			handleSignal(this, builtWrapper.onComplete, handleDispatchWithDelayedFunctionCall, 1000, testThatSetParamsEqualDispatchedParams);
			builtWrapper.gotoAndPlayUntilStop(1, 2);
		}

		private function handleDispatchWithDelayedFunctionCall(event:SignalAsyncEvent, passThroughData:*):void
		{
			var testFunction:Function = passThroughData as Function;

			setTimeout(testFunction, 100);
		}

		private function testThatSetParamsEqualDispatchedParams():void
		{
			assertThat(TEST_PARAMS, equalTo(test_results));
		}

		private function handleOnCompleteWithParams(param1:String, param2:int, param3:int):void
		{
			test_results = [param1, param2, param3];
		}

		[Test(async)]
		public function should_throw_error_if_used_after_dispatch():void
		{
			builtWrapperDestroy = TimelineWrapper(new TimelineWrapperBuilder(mcWithoutLabels, false)
				.setDestroyAfterComplete()
				.build());
				
			handleSignal(this, builtWrapperDestroy.onComplete, handleDispatchWithDelayedFunctionCall, 1000, testThatDispatcherIsDestroyed);
			builtWrapperDestroy.gotoAndPlayUntilStop(1, 2);
		}

		private function testThatDispatcherIsDestroyed():void
		{
			assertThat(builtWrapperDestroy.onComplete, nullValue());
		}
	}
}

