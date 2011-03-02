//------------------------------------------------------------------------------
//copyright 2010  
//------------------------------------------------------------------------------

package com.percentjuice.utils.designPatternParents
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.ui.ContextMenu;
	/**
	 * Sprite Interface.  modded from Gaia ISprite.
	 * @author C Stuempges
	 */
	public interface ISprite extends IEventDispatcher
	{
		// PROXY DISPLAY OBJECT CONTAINER FUNCTIONS
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#addChild() flash.display.DisplayObjectContainer.addChild()
		 */
		function addChild(child:DisplayObject):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#addChildAt() flash.display.DisplayObjectContainer.addChildAt()
		 */
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#areInaccessibleObjectsUnderPoint() flash.display.DisplayObjectContainer.areInaccessibleObjectsUnderPoint()
		 */
		function areInaccessibleObjectsUnderPoint(point:Point):Boolean;
		// PROXY SPRITE PROPERTIES
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#buttonMode flash.display.Sprite.buttonMode
		 */
		function get buttonMode():Boolean;
		/**
		 * @private
		 */
		function set buttonMode(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#contains() flash.display.DisplayObjectContainer.contains()
		 */
		function contains(child:DisplayObject):Boolean;
		// PROXY INTERACTIVE OBJECT PROPERTIES
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#contextMenu flash.display.InteractiveObject.contextMenu
		 */
		function get contextMenu():ContextMenu;
		/**
		 * @private
		 */
		function set contextMenu(value:ContextMenu):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#doubleClickEnabled flash.display.InteractiveObject.doubleClickEnabled
		 */
		function get doubleClickEnabled():Boolean;
		/**
		 * @private
		 */
		function set doubleClickEnabled(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#dropTarget flash.display.Sprite.dropTarget
		 */
		function get dropTarget():DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#focusRect flash.display.InteractiveObject.focusRect
		 */
		function get focusRect():Object;
		/**
		 * @private
		 */
		function set focusRect(value:Object):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#getChildAt() flash.display.DisplayObjectContainer.getChildAt()
		 */
		function getChildAt(index:int):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#getChildByName() flash.display.DisplayObjectContainer.getChildByName()
		 */
		function getChildByName(name:String):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#getChildIndex() flash.display.DisplayObjectContainer.getChildIndex()
		 */
		function getChildIndex(child:DisplayObject):int;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#getObjectsUnderPoint() flash.display.DisplayObjectContainer.getObjectsUnderPoint()
		 */
		function getObjectsUnderPoint(point:Point):Array;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#graphics flash.display.Sprite.graphics
		 */
		function get graphics():Graphics;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#hitArea flash.display.Sprite.hitArea
		 */
		function get hitArea():Sprite;
		/**
		 * @private
		 */
		function set hitArea(value:Sprite):void;
		// PROXY DISPLAY OBJECT CONTAINER PROPERTIES
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#mouseChildren flash.display.DisplayObjectContainer.mouseChildren
		 */
		function get mouseChildren():Boolean;
		/**
		 * @private
		 */
		function set mouseChildren(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#mouseEnabled flash.display.InteractiveObject.mouseEnabled
		 */
		function get mouseEnabled():Boolean;
		/**
		 * @private
		 */
		function set mouseEnabled(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#numChildren flash.display.DisplayObjectContainer.numChildren
		 */
		function get numChildren():int;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#removeChild() flash.display.DisplayObjectContainer.removeChild()
		 */
		function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#removeChildAt() flash.display.DisplayObjectContainer.removeChildAt()
		 */
		function removeChildAt(index:int):DisplayObject;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#setChildIndex() flash.display.DisplayObjectContainer.setChildIndex()
		 */
		function setChildIndex(child:DisplayObject, index:int):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#soundTransform flash.display.Sprite.soundTransform
		 */
		function get soundTransform():SoundTransform;
		/**
		 * @private
		 */
		function set soundTransform(value:SoundTransform):void;
		// PROXY SPRITE FUNCTIONS
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#startDrag() flash.display.Sprite.startDrag()
		 */
		function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#stopDrag() flash.display.Sprite.stopDrag()
		 */
		function stopDrag():void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#swapChildren() flash.display.DisplayObjectContainer.swapChildren()
		 */
		function swapChildren(child1:DisplayObject, child2:DisplayObject):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#swapChildrenAt() flash.display.DisplayObjectContainer.swapChildrenAt()
		 */
		function swapChildrenAt(index1:int, index2:int):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/DisplayObjectContainer.html#tabChildren flash.display.DisplayObjectContainer.tabChildren
		 */
		function get tabChildren():Boolean;
		/**
		 * @private
		 */
		function set tabChildren(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#tabEnabled flash.display.InteractiveObject.tabEnabled
		 */
		function get tabEnabled():Boolean;
		/**
		 * @private
		 */
		function set tabEnabled(value:Boolean):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/InteractiveObject.html#tabIndex flash.display.InteractiveObject.tabIndex
		 */
		function get tabIndex():int;
		/**
		 * @private
		 */
		function set tabIndex(ivalue:int):void;
		/**
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Sprite.html#useHandCursor flash.display.Sprite.useHandCursor
		 */
		function get useHandCursor():Boolean;
		/**
		 * @private
		 */
		function set useHandCursor(value:Boolean):void;
	}
}