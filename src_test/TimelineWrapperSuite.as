package
{
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperSignalTest;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperFactoryTest;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperQueueTest;
	import com.percentjuice.utils.movieClipWrappers.TimelineWrapperTest;

	import flash.display.Sprite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TimelineWrapperSuite extends Sprite
	{
		public var timelineWrapperTest:TimelineWrapperTest;
		public var timelineWrapperQueueTest:TimelineWrapperQueueTest;
		public var timelineWrapperFactoryTest:TimelineWrapperFactoryTest;
		public var timelineWrapperSignalTest:TimelineWrapperSignalTest;
	}
}

