package com.percentjuice.utils.timelineWrappers
{
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class Assertions
	{
		public static const ATTEMPTED_ACCESS_OF_DESTROYED_INSTANCE:String = "Cannot call method on destroyed ITimelineWrapper.";
		public static const ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP:String = "MovieClip is null.";
		public static const ATTEMPTED_GOTO_WITH_NUMBER_AS_STRING:String = "] this String Request will be run by flash.display.MovieClip::gotoAndStop as a Number.  instead pass in a Number or rename your frame label.";

		internal function assertNotNull(wrappedMC:MovieClip):void
		{
			if (wrappedMC == null)
				throw new ArgumentError(ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP);
		}

		internal function isInstanceDestroyed(instance:TimelineWrapper):Boolean
		{
			return instance.onComplete == null;
		}

		internal function assertInstanceIsNotDestroyed(instance:TimelineWrapper):void
		{
			if (isInstanceDestroyed(instance) == true)
				throw new IllegalOperationError(ATTEMPTED_ACCESS_OF_DESTROYED_INSTANCE);
		}

		internal function assertDoesNotContainNumberAsString(requests:Array):void
		{
			for each (var request:Object in requests)
			{
				if (request is String && !isNaN(Number(request as String)))
				{
					throw new IllegalOperationError("[" + (request as String) + ATTEMPTED_GOTO_WITH_NUMBER_AS_STRING);
				}
			}
		}
	}
}


