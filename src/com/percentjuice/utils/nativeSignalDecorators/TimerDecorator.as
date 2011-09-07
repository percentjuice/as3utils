// ------------------------------------------------------------------------------
// copyright 2010
// ------------------------------------------------------------------------------

package com.percentjuice.utils.nativeSignalDecorators
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.natives.NativeSignal;

	public class TimerDecorator extends Timer
	{

		/**
		 * @param delay The delay, in milliseconds, between timer events.
		 * @param repeatCount The total number of times the timer is set to run.  0 == forever.
		 * @param noPause set true to fire first Event on start
		 */
		public function TimerDecorator(delay:Number, repeatCount:int = 0, noPause:Boolean = false)
		{
			super(delay, repeatCount);
			this.noPause = noPause;
			init();
		}

		public var timerComplete:NativeSignal;
		public var timerEvent:NativeSignal;

		private var noPause:Boolean;

		override public function start():void
		{
			super.start();
			if (noPause)
			{
				timerEvent.dispatch(new TimerEvent(TimerEvent.TIMER));
			}
		}

		private function init():void
		{
			timerEvent = new NativeSignal(this, TimerEvent.TIMER, TimerEvent);
			timerComplete = new NativeSignal(this, TimerEvent.TIMER_COMPLETE, TimerEvent);
		}
	}
}

