package
{
	import com.percentjuice.utils.timelineWrappers.*;
	import com.percentjuice.utils.timelineWrappers.builder.*;
	import com.percentjuice.utils.timelineWrappers.factory.*;
	import flash.display.Sprite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TimelineWrapperSuite extends Sprite
	{ 
		public var timelineWrapperBuilderTest:TimelineWrapperBuilderTest;
		public var timelineWrapperTest:TimelineWrapperTest;
		public var timelineWrapperQueueTest:TimelineWrapperQueueTest;
		public var timelineWrapperFactoryTest:TimelineWrapperFactoryTest;
		public var timelineWrapperQueueFactoryTest:TimelineWrapperQueueFactoryTest;
		public var collectionAccessorTest:CollectionAccessorTest;
		public var untypedSignalTest:UntypedSignalTest;
	}
}