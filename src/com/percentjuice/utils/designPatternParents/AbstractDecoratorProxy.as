//------------------------------------------------------------------------------
//copyright 2010
//------------------------------------------------------------------------------

package com.percentjuice.utils.designPatternParents
{
	import com.percentjuice.utils.ReflectionUtil;

	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * extend this class to facilate DecoratorProxy use.
	 * use DecoratorProxy when child props are either undetermined or overly numerous (as when decorating a Sprite).
	 * 		ex:
	 * 			if this has public var name,
	 * 			calling this.name returns this.name whereas
	 * 			calling this.blah returns child.blah.
	 * 			you'll want to assure that child contains prop blah.
	 *
	 * 		your IDE may throw Errors unless using dynamic syntax such as:
	 * 			trace(proxyInstance["thePropery"]);
	 * 			trace((proxyInstance as Object).theProperty);
	 *
	 * @author C Stuempges
	 */
	public class AbstractDecoratorProxy extends Proxy
	{

		public function AbstractDecoratorProxy()
		{
			super();
			registerNonDecorated();
		}

		private var _decorated:Object;

		/**
		 * stores ref's to public methods of Decorator.
		 */
		private var methods:Dictionary;

		/**
		 * stores ref's to public props of Decorator.
		 */
		private var props:Dictionary;

		public function injectDecorated(dec:*):void
		{
			_decorated = dec;
		}

		protected function get decorated():Object
		{
			return _decorated;
		}

		/**
		 * @private
		 * calls method from decorated:Object unless
		 * 	  DecoratorProxy has a public method by that title
		 */
		flash_proxy override function callProperty(methodName:*, ...args):*
		{
			if(!methods[methodName])return decorated[methodName].apply(null,args);
			return this[methodName].apply(null,args);
		}

		/**
		 * @private
		 * gets property from decorated:Object unless
		 * 	  	DecoratorProxy has a public property by that name
		 */
		flash_proxy override function getProperty(name:*):*
		{
			if(!props[name]) {return decorated[name];}
			else {return this[name];}
		}

		/**
		 * @private
		 * sets property from decorated:Object unless
		 * 	  DecoratorProxy has a public property by that title
		 */
		flash_proxy override function setProperty(name:*, value:*):void
		{
			if(!props[name]){decorated[name]=value;}
			else {this[name]=value;}
		}

		private function registerNonDecorated():void
		{
			props = ReflectionUtil.findPublic(this, ReflectionUtil.METHOD);
			methods = ReflectionUtil.findPublic(this);
		}
	}
}

