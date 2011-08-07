package com.percentjuice.utils.timelineWrappers.support
{
	import org.osflash.signals.Signal;

	import flash.display.MovieClip;

	/**
	 * Asynchronous Loading of Embedded SWF's.
	 */
	public class MCLoader
	{
		public var signal_loadComplete:Signal;

		private var loaders:Vector.<LoaderHandler>;

		public function MCLoader()
		{
			signal_loadComplete = new Signal(Class, MovieClip);
			loaders = new <LoaderHandler>[];
		}

		public function load(asset:MCProperties):void
		{
			var loader:LoaderHandler = new LoaderHandler(asset.assetClass);
			loaders[loaders.length] = loader;
			loader.signal_loadComplete.addOnce(loadCompleteListener);
		}

		private function loadCompleteListener(assetRequest:Class, loadedMC:MovieClip, loaderHandler:LoaderHandler):void
		{
			loaders.splice(loaders.indexOf(loaderHandler), 1);
			signal_loadComplete.dispatch(assetRequest, loadedMC);
		}
	}
}

import org.osflash.signals.Signal;

import mx.core.ByteArrayAsset;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;

/**
 * ByteArrayAsset method used here required per Loader idiosyncrasies.
 */
class LoaderHandler
{
	public var signal_loadComplete:Signal;

	private var AssetClass:Class;
	private var byteArrayAssetInstance:ByteArrayAsset;
	private var loader:Loader;

	public function LoaderHandler(AssetClass:Class)
	{
		this.AssetClass = AssetClass;
		byteArrayAssetInstance = new AssetClass();
		loader = new Loader();
		signal_loadComplete = new Signal(Class, MovieClip, LoaderHandler); // TODO: remove LoaderHandler dispatch

		loader.contentLoaderInfo.addEventListener(Event.INIT, loadCompleteListener);
		loader.loadBytes(byteArrayAssetInstance);
	}

	private function loadCompleteListener(event:Event):void
	{
		loader.removeEventListener(Event.INIT, loadCompleteListener);
		var content:MovieClip = MovieClip(loader.content);
		signal_loadComplete.dispatch(AssetClass, content, this);
	}
}

