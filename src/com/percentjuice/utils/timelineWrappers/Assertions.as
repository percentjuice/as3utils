package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.pj_as3utils_namespace;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class Assertions
	{
		use namespace pj_as3utils_namespace;

		public static const ATTEMPTED_OPERATION_ON_DESTROYED_INSTANCE:String = "Cannot call method on destroyed TimelineWrapper.";
		public static const ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP:String = "Attempted initialization with a null MovieClip.";
		public static const ATTEMPTED_GOTO_WITH_NUMBER_AS_STRING:String = "] this String Request will be run by flash.display.MovieClip::gotoAndStop as a Number.  instead pass in a Number or rename your frame label.";

		pj_as3utils_namespace function notNullValue(wrappedMC:MovieClip):void
		{
			if (wrappedMC == null)
			{
				throw new ArgumentError(ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP);
			}
		}

		pj_as3utils_namespace function isInstanceDestroyed(instance:TimelineWrapper):Boolean
		{
			return instance._wrappedMC == null;
		}

		pj_as3utils_namespace function assertInstanceIsNotDestroyed(instance:TimelineWrapper):void
		{
			if (isInstanceDestroyed(instance) == true)
			{
				throw new IllegalOperationError(ATTEMPTED_OPERATION_ON_DESTROYED_INSTANCE);
			}
		}

		pj_as3utils_namespace function assertDoesNotContainNumberAsString(requests:Array):void
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