//------------------------------------------------------------------------------
//copyright 2010 
//------------------------------------------------------------------------------

package com.percentjuice.utils.nativeSignalDecorators
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.natives.NativeSignal;
	public class TimerDecorator extends Timer
	{

		public function TimerDecorator(delay:Number, repeatCount:int=0,noPause:Boolean=false)
		{
			super(delay, repeatCount);
			this.noPause=noPause;
			init();
		}

		public var timerComplete:NativeSignal;
		public var timerEvent:NativeSignal;
		/* does not initially wait to fire first Event */
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

