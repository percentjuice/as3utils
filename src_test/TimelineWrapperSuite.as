package
{
	import com.percentjuice.utils.timelineWrappers.*;
	import com.percentjuice.utils.timelineWrappers.factory.*;
	import flash.display.Sprite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TimelineWrapperSuite extends Sprite
	{ 
		public var timelineWrapperTest:TimelineWrapperTest;
		public var timelineWrapperQueueTest:TimelineWrapperQueueTest;
		public var frameLabelCalculatorTest:FrameLabelCalculatorTest;
		public var collectionAccessorTest:CollectionAccessorTest;
		public var untypedSignalTest:UntypedSignalTest;
	}
}