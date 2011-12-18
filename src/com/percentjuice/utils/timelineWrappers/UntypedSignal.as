package com.percentjuice.utils.timelineWrappers
{
	import com.percentjuice.utils.pj_as3utils_namespace;

	import org.osflash.signals.DeluxeSignal;

	/**
	 * to use: 	see included Setters for Handler and Parameter assignment.
	 * 			Handler method must implement parameters for values being sent by dispatchSetParams().
	 *
	 * @author C Stuempges
	 */
	public class UntypedSignal extends DeluxeSignal
	{
		use namespace pj_as3utils_namespace;

		private var onDispatchHandlerParams:Array;

		/**
		 * the DeluxeSignal is set to dispatch any number of parameters to any method set in setOnCompleteHandler.
		 */
		public function UntypedSignal(target:ITimelineWrapper)
		{
			super(target);
			strict = false;
		}

		public function setOnDispatchHandler(handler:Function):void
		{
			super.add(handler);
		}

		public function setOnceOnDispatchHandler(handler:Function):void
		{
			super.addOnce(handler);
		}

		public function setOnDispatchHandlerParams(firstParamIsTarget:Boolean, concatParams:Array = null):void
		{
			if (firstParamIsTarget)
			{
				onDispatchHandlerParams = (concatParams == null) ? [target] : [target].concat(concatParams);
			}
			else if (concatParams == null)
			{
				return;
			}
			else
			{
				onDispatchHandlerParams = concatParams;
			}
		}

		public function dispatchSetParams():void
		{
			if (onDispatchHandlerParams == null)
			{
				super.dispatch.apply();
			}
			else
			{
				super.dispatch.apply(undefined, onDispatchHandlerParams);
			}
		}
	}
}