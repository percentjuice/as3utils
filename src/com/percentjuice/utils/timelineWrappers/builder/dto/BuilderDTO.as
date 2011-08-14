package com.percentjuice.utils.timelineWrappers.builder.dto
{
	import flash.display.MovieClip;
	public class BuilderDTO
	{
		public var wrappedMC:MovieClip;
		
		public var onCompleteHandler:Function;
		public var onceOnCompleteHandler:Function;
		public var onCompleteHandlerParams:Array;
		
		public var onceOnDestroyHandler:Function;
		public var destroyAfterComplete:Boolean;
		
		public var queueEnabled:Boolean;
		public var playWhenQueueEmptyParams:Array;
		
		public var queueCompleteHandler:Function;
		public var onceQueueCompleteHandler:Function;
		public var queueCompleteHandlerParams:Array;
		
		public var preventRewrapping:Boolean;
	}
}		