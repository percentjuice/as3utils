package com.percentjuice.utils.movieClipWrappers.timelineWrapperFactory
{
	import com.percentjuice.utils.movieClipWrappers.ITimelineWrapper;

	import flash.display.MovieClip;

	public class ITimelineWrapperCollectionAccessor
	{
		internal static const NULL_ITIMELINE_WRAPPER:ITimelineWrapper = null;
		
		internal function getAnyMatchingITimelineWrapper(wrappedMovieClip:MovieClip, returnTypeCollection:Vector.<ITimelineWrapper>):ITimelineWrapper
		{
			var l:int = returnTypeCollection.length;
			for (var i:int = 0; i < l; i++)
			{
				var iTimelineWrapper:ITimelineWrapper = returnTypeCollection[i];
				if (iTimelineWrapper.wrappedMC == wrappedMovieClip)
				{
					iTimelineWrapper.stop();
					return iTimelineWrapper;
				}
			}
			return NULL_ITIMELINE_WRAPPER;
		}
	}
}
