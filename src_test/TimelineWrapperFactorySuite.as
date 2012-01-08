package
{
	import com.percentjuice.utils.timelineWrappers.builder.*;
	import com.percentjuice.utils.timelineWrappers.factory.*;
	import flash.display.Sprite;

	[Suite(order=2)]
	[RunWith("org.flexunit.runners.Suite")]
	public class TimelineWrapperFactorySuite extends Sprite
	{ 
		public var timelineWrapperFactoryTest:TimelineWrapperFactoryTest;
		public var timelineWrapperQueueFactoryTest:TimelineWrapperQueueFactoryTest;
		public var timelineWrapperQueueSetDefaultFactoryTest:TimelineWrapperQueueSetDefaultFactoryTest;
		public var timelineWrapperBuilderTest:TimelineWrapperBuilderTest;
	}
}