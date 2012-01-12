package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.pj_as3utils_namespace;

	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	public class Assertions
	{
		public static const ATTEMPTED_OPERATION_ON_NULL_INSTANCE:String = "Cannot call method on TimelineWrapper with null MovieClip.";
		public static const ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP:String = "Attempted initialization with a null MovieClip.";
		public static const ATTEMPTED_GOTO_WITH_NUMBER_AS_STRING:String = "] this String Request will be run by flash.display.MovieClip::gotoAndStop as a Number.  instead pass in a Number or rename your frame label.";
		public static const ATTEMPTED_USING_FRAME_NOT_IN_TIMELINE:String = "Frame not located in the Timeline: ";

		pj_as3utils_namespace function notNullValue(wrappedMC:MovieClip):void
		{
			if (wrappedMC == null)
			{
				throw new ArgumentError(ATTEMPTED_INITIALIZATION_WITH_NULL_MOVIECLIP);
			}
		}

		pj_as3utils_namespace function isInstanceDestroyed(instance:TimelineWrapper):Boolean
		{
			return instance.wrappedMC == null;
		}

		pj_as3utils_namespace function assertWrappedIsNotNull(instance:TimelineWrapper):void
		{
			if (instance.wrappedMC == null)
			{
				throw new IllegalOperationError(ATTEMPTED_OPERATION_ON_NULL_INSTANCE);
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

		pj_as3utils_namespace function isValidFrame(frame:int):Boolean
		{
			if (frame > 0)
			{
				return true;
			}
			else
			{
				throw new IllegalOperationError(ATTEMPTED_USING_FRAME_NOT_IN_TIMELINE + frame);
				return false;
			}
		}
	}
}