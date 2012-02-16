package com.percentjuice.utils.timelineWrappers.builder.dto
{
	import flash.display.MovieClip;
	public class BuilderDTO
	{
		public var wrappedMC:MovieClip;
		public var onCompleteHandler:Function;
		public var onceOnCompleteHandler:Function;
		public var onCompleteHandlerParams:Object;
		public var firstCompleteParamIsTimelineWrapper:Boolean;
		public var destroyAfterComplete:Boolean;
		public var playQueue:Object;
		public var queueCompleteHandler:Function;
		public var onceQueueCompleteHandler:Function;
		public var queueCompleteHandlerParams:Object;
		public var firstQueueCompleteParamIsTimelineWrapper:Boolean;
		public var playLoopedWhenQueueEmpty:Object;
		public var preventRewrapping:Boolean;
	}
}		