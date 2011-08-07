// ------------------------------------------------------------------------------
// copyright 2010
// ------------------------------------------------------------------------------

package com.percentjuice.utils.nativeSignalDecorators
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import org.osflash.signals.natives.NativeSignal;

	/**
	 * Utility for common SoundChannel methods
	 *  though no support for queuing.
	 *
	 * handles sound firing in rapid, overlapping succession.
	 * allows for organized listening to any consecutive SoundComplete Signal.
	 * allows for multiple overlapping loops.  all loops are tied to one kill switch.
	 * @author C Stuempges
	 */
	public class SoundChannelDecorator
	{
		/**
		 * @param loopingSound
		 * sending a loopingSound on init doesn't make sense unless your SoundChannelMod
		 * 		will only be used once.  SoundChannelMod uses this internally to create
		 * 		multiple looping sounds.
		 */
		public function SoundChannelDecorator(loopingSound:Sound = null)
		{
			init(loopingSound);
		}

		public var soundComplete:NativeSignal;
		private var loopingSCM:Array;
		private var loopingSound:Sound;
		private var _persistantSoundChannel:SoundChannel;

		private function get persistantSoundChannel():SoundChannel
		{
			if (!_persistantSoundChannel)
			{
				_persistantSoundChannel = new SoundChannel();
			}
			return _persistantSoundChannel;
		}

		/**
		 * ends all Loops running
		 * @throws Error
		 */
		public function killLooping():void
		{
			/* if Parent, ends all loops at next repeat */
			if (loopingSCM)
			{
				for (var i:String in loopingSCM)
				{
					var killSCM:SoundChannelDecorator = loopingSCM[i] as SoundChannelDecorator;
					killSCM.killLooping();
					loopingSCM.splice(loopingSCM.indexOf(killSCM));
					killSCM = null;
					loopingSCM = null;
				}
			}
			/*  else ends this loop at next repeat */
			else if (loopingSound)
			{
				loopingSound = null;
				soundComplete = null;
			}
			/* may have called killLooping() though no loops are running */
			else
			{
				throw new Error();
			}
		}

		/**
		 * fires sound immediately in new SoundChannel.
		 * Sound(s) will loop until killLooping() is called.
		 *
		 */
		public function loopSound(sound:Sound):void
		{
			/* if no loops are running already */
			if (!loopingSCM)
			{
				loopingSCM = [];
			}
			var scm:SoundChannelDecorator = new SoundChannelDecorator(sound);
			loopingSCM[loopingSCM.length] = scm;
		}

		/**
		 * fires sound immediately in persistant SoundChannel.
		 * sounds can not overlap.
		 */
		public function playOverriding(sound:Sound):void
		{
			persistantSoundChannel.stop();
			_persistantSoundChannel = playSound(sound);
		}

		/**
		 * fires sound immediately in new SoundChannel.
		 * sounds can overlap.
		 */
		public function playOverlapping(sound:Sound):SoundChannel
		{
			var channel:SoundChannel = new SoundChannel();
			channel = playSound(sound);
			return channel;
		}

		private function playSound(sound:Sound):SoundChannel
		{
			try
			{
				return sound.play(0, 0);
			}
			catch (error:Error)
			{
				trace("SoundChannelDecorator::playSound " + error);
			}
			return null;
		}

		/**
		 * fires sound immediately in new SoundChannel.
		 * overlap/not overlap determined by instantiator of this.
		 * allows listening to last fired Sound's completion.
		 */
		public function playSoundConsecutive(sound:Sound):void
		{
			/* sound play must precede addition of listeners */
			var channel:SoundChannel = playOverlapping(sound);
			/* if there are no current sounds playing */
			if (!soundComplete)
			{
				soundComplete = new NativeSignal(channel, Event.SOUND_COMPLETE, Event);
				soundComplete.addOnce(handleSoundComplete);
			}
			else
			{
				soundComplete.removeAll();
				soundComplete = null;
				playSoundConsecutive(sound);
			}
		}

		private function handleSoundComplete(e:Event):void
		{
			/* this == not a child in loopingSCM */
			if (!loopingSound)
			{
				soundComplete = null;
			}
			/* child in loopingSCM */
			else
			{
				playSoundConsecutive(loopingSound);
			}
		}

		private function init(loopingSound:Sound = null):void
		{
			if (loopingSound)
			{
				this.loopingSound = loopingSound;
				playSoundConsecutive(loopingSound);
			}
		}

	}
}


