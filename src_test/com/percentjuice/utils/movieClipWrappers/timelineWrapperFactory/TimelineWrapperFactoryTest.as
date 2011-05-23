package com.percentjuice.utils.movieClipWrappers.timelineWrapperFactory
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapper;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperAssertions;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperQueue;
	import com.percentjuice.utils.movieClipWrappers.support.MCLoader;
	import com.percentjuice.utils.movieClipWrappers.support.MCProperties;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.instanceOf;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class TimelineWrapperFactoryTest
	{
		private static var mcWithLabelsLoader:MCLoader;
		private static var mcWithLabels:MovieClip;

		private static var propsForLabelsTest:MCProperties;
		private static var propsForNoLabelsTest:MCProperties;

		[BeforeClass(async)]
		public static function setUpBeforeClass():void
		{
			propsForLabelsTest = MCProperties.mcWithLabels;
			propsForNoLabelsTest = MCProperties.mcWithoutLabels;

			mcWithLabelsLoader = new MCLoader();
			mcWithLabelsLoader.load(propsForLabelsTest);
			handleSignal(TimelineWrapperFactoryTest, mcWithLabelsLoader.signal_loadComplete, TimelineWrapperFactoryTest.handleLoadComplete, 3000, null);
		}

		private static function handleLoadComplete(event:SignalAsyncEvent, none:*):void
		{
			mcWithLabels = event.args[1];
			mcWithLabelsLoader = null;
		}

		[Test]
		public function getOneTimelineWrapperPerMC_should_return_identical_timelineWrapper_for_identical_movieClip():void
		{
			should_return_identical_timelineWrapper_for_identical_movieClip(TimelineWrapperFactory.getOneTimelineWrapperPerMC);
		}

		[Test]
		public function getOneTimelineWrapperQueuePerMC_should_return_identical_timelineWrapper_for_identical_movieClip():void
		{
			should_return_identical_timelineWrapper_for_identical_movieClip(TimelineWrapperFactory.getOneTimelineWrapperQueuePerMC);
		}

		[Test]
		public function getOneSingleUseTimelineWrapperPerMC_should_return_identical_timelineWrapper_for_identical_movieClip():void
		{
			should_return_identical_timelineWrapper_for_identical_movieClip(TimelineWrapperFactory.getOneSingleUseTimelineWrapperPerMC);
		}

		[Test]
		public function getOneSingleUseTimelineWrapperQueuePerMC_should_return_identical_timelineWrapper_for_identical_movieClip():void
		{
			should_return_identical_timelineWrapper_for_identical_movieClip(TimelineWrapperFactory.getOneSingleUseTimelineWrapperQueuePerMC);
		}

		private function should_return_identical_timelineWrapper_for_identical_movieClip(timelineWrapperFactoryFunction:Function):void
		{
			var mc0:MovieClip = new MovieClip();
			var mc1:MovieClip = new MovieClip();
			var mc2:MovieClip = new MovieClip();
			var tw0:ITimelineWrapper = timelineWrapperFactoryFunction(mc0);
			var tw1:ITimelineWrapper = timelineWrapperFactoryFunction(mc1);
			var tw2:ITimelineWrapper = timelineWrapperFactoryFunction(mc0);
			var tw3:ITimelineWrapper = timelineWrapperFactoryFunction(mc2);

			assertThat(tw0, equalTo(tw2));
			assertThat(tw0, not(tw1));
			assertThat(tw0, not(tw3));
			assertThat(tw1, not(tw2));
			assertThat(tw1, not(tw3));
			assertThat(tw2, not(tw3));
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function timelineWrapper_should_throw_error_if_used_after_destroy():void
		{
			var selfDestroying:TimelineWrapper = TimelineWrapperFactory.getOneSingleUseTimelineWrapperPerMC(new MovieClip());
			should_show_self_destroying_functionality(selfDestroying);
		}

		[Test(expects="flash.errors.IllegalOperationError")]
		public function timelineWrapperQueue_should_show_self_destroying_functionality():void
		{
			var selfDestroying:TimelineWrapperQueue = TimelineWrapperFactory.getOneSingleUseTimelineWrapperQueuePerMC(new MovieClip());
			should_show_self_destroying_functionality(selfDestroying);
		}

		private function should_show_self_destroying_functionality(selfDestroying:ITimelineWrapper):void
		{
			selfDestroying.reachedStop.dispatchSignalClone("request");
			assertThat(selfDestroying.gotoAndPlayUntilStop(1, 2), throws(allOf(instanceOf(IllegalOperationError), hasPropertyWithValue("message", TimelineWrapperAssertions.ATTEMPTED_ACCESS_OF_DESTROYED_INSTANCE))));
		}
	}
}