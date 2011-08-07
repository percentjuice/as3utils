package com.percentjuice.utils.timelineWrappers
{
	import org.osflash.signals.DeluxeSignal;

	/**
	 * to use: 	see included Setters for Handler and Parameter assignment.
	 * 			Handler method must implement parameters for values being sent by dispatchSetParams().
	 *
	 * @author C Stuempges
	 */
	public class UntypedSignal extends DeluxeSignal
	{
		private var _onDispatchHandlerParams:Array;

		/**
		 * the DeluxeSignal is set to dispatch any number of parameters to any method set in setOnCompleteHandler.
		 */
		public function UntypedSignal()
		{
			super();
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

		public function setOnDispatchHandlerParams(params:Array):void
		{
			_onDispatchHandlerParams = params;
		}

		public function dispatchSetParams():void
		{
			if (_onDispatchHandlerParams == null)
			{
				super.dispatch.apply();
			}
			else
			{
				super.dispatch.apply(undefined, _onDispatchHandlerParams);
			}
		}

		internal function get onDispatchHandlerParams():Array
		{
			return _onDispatchHandlerParams;
		}
	}
}