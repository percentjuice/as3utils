package com.percentjuice.utils.movieClipWrappers
{
	import org.osflash.signals.DeluxeSignal;

	import flash.errors.IllegalOperationError;

	/**
	 * allows access to most commonly used dispatch variables.
	 *
	 * to use: dispatch the completed request Object.
	 * listener function will receive a clone of this Signal.
	 *
	 * @author C Stuempges
	 */
	public class TimelineWrapperSignal extends DeluxeSignal
	{
		/**
		 * the DeluxeSignal is set to dispatch an instance of TimelineWrapperSignal
		 * @param target
		 */
		public function TimelineWrapperSignal(target:ITimelineWrapper)
		{
			super(target, TimelineWrapperSignal);
			strict = false;
		}

		public function get dispatcher():ITimelineWrapper
		{
			return _target as ITimelineWrapper;
		}

		public function dispatchSignalClone(completedRequest:Object):void
		{
			super.dispatch(new TimelineWrapperSignalClone(dispatcher, completedRequest));
		}

		override public function dispatch(...valueObjects):void
		{
			throw new IllegalOperationError('Use TimelineWrapperSignal::dispatchSignalClone.');
		}

		public function get completedRequest():Object
		{
			throw new Error("completedRequest implemented by TimelineWrapperSignalClone.");
			return null;
		}
	}
}

import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;
import com.percentjuice.utils.movieClipWrappers.TimelineWrapperSignal;

import org.osflash.signals.ISignalBinding;

import flash.errors.IllegalOperationError;

class TimelineWrapperSignalClone extends TimelineWrapperSignal
{
	private static const CLONE_ERROR_MSG:String = "apply this function to dispatcher's TimelineWrapperSignal, not the dispatched TimelineWrapperSignal.";
	private var _completedRequest:Object;

	public function TimelineWrapperSignalClone(target:ITimelineWrapper, completedRequest:Object)
	{
		super(target);
		_completedRequest = completedRequest;
	}

	public override function get completedRequest():Object
	{
		return _completedRequest;
	}

	//--------------------------------------
	//  unimplemented inherited functions
	//--------------------------------------

	public override function addWithPriority(listener:Function, priority:int = 0):ISignalBinding
	{
		return handleUnimplementedParentFunction();
	}

	public override function addOnceWithPriority(listener:Function, priority:int = 0):ISignalBinding
	{
		return handleUnimplementedParentFunction();
	}

	public override function add(listener:Function):ISignalBinding
	{
		return handleUnimplementedParentFunction();
	}

	public override function addOnce(listener:Function):ISignalBinding
	{
		return handleUnimplementedParentFunction();
	}

	public override function dispatch(...valueObjects):void
	{
		handleUnimplementedParentFunction();
	}

	private function handleUnimplementedParentFunction():ISignalBinding
	{
		throw new IllegalOperationError(CLONE_ERROR_MSG);
		return null;
	}
}


