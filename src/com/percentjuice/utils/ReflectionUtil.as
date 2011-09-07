//------------------------------------------------------------------------------
//copyright 2010 
//------------------------------------------------------------------------------

package com.percentjuice.utils
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	public class ReflectionUtil
	{
		//----------------------------------------------------------------------------
		//  Methods which inspect the public instance properties/methods of an Object
		//----------------------------------------------------------------------------

		/**
		 * locates the public props of $obj
		 * @param $obj the object to inspect.
		 * @param nodeName 'variable' grabs properties, 'method' grabs methods
		 * @return dictionary of nodes in $obj identified by nodeName
		 */
		public static const VARIABLE:String = 'variable';
		public static const METHOD:String = 'method';
		public static function findPublic($obj:*, nodeName:String=VARIABLE):Dictionary
		{
			var dict:Dictionary = new Dictionary(true);
			var nodeList:XMLList;
			switch (nodeName)
			{
				case VARIABLE:
					nodeList = describeType($obj)..variable;
					break;
				case METHOD:
					nodeList = describeType($obj)..method;
					break;
				default:
					throw new Error('node label is not handled.');
			}
			var n:int=nodeList.length();
			for(var i:int = 0; i < n; i++)
			{
				dict[String(nodeList[i].@name)] = true;
			}
			nodeList = null;
			return dict;
		}

		/*
		 * [Dictionaries use notation: this.varList[i].@name ]
		 * [Objects use notation: this[varList[i].@name] ]
		 */
		/**
		 * sets public properties of parent object equal to matching properties of $obj
		 * @param $obj object whose matching name/type properties will be duplicated (primitives) or pointed to (complex data types)
		 * @param cloneData
		 */
		public static function propsFromObject(copyFrom:*, copyTo:*, cloneData:Boolean=false):void
		{
			var varList:XMLList = describeType(copyTo)..variable;
			var n:int=varList.length();
			for(var i:int=0; i < n; i++)
			{
				var prop:String = String(varList[i].@name);
				if (copyFrom.hasOwnProperty(prop))
				{
					copyTo[prop] = (cloneData) ? returnNewRef(copyFrom[prop], varList[i].@type) : copyFrom[prop];
				}
			}
			varList=null;
		}

		/**
		 * used by propsFromObject if a new instance of the copied property is desired.
		 * create additional cases as needed.
		 * @param prop the value being duplicated
		 * @param type the value's type
		 * @return a new instance of the value
		 * @throws Error if attempting to duplicate an Object which is not handled
		 */
		private static function returnNewRef(prop:*, type:*):*
		{
			var cloneProp:*;
			switch (String(type))
			{
				case "Array":
					cloneProp = new Array().concat((prop as Array));
					break;
				case "flash.display::Bitmap":
					cloneProp = new Bitmap((prop as Bitmap).bitmapData);
					break;
				case "Number":
				case "int":
				case "uint":
				case "String":
				case "Boolean":
				case "Null":
				case "void":
					cloneProp = prop;
					break;
				default:
					throw new Error('returnNewRef:: create instantiation for '+type);
			}
			return cloneProp;
		}

		//--------------------------------------
		//  Methods which inspect Class names
		//--------------------------------------

		/**
		 * @param classIn
		 * @return the class name as String
		 */
		public static function getClassName(classIn:*):String
		{
			/* === flash.utils.getQualifiedClassName(classIn).split("::")[1] */
			return describeType(classIn).@name.split("::")[1];
		}

		/**
		 * checks whether two classes are of the same type
		 * @param compareThis
		 * @param toThis
		 * @return
		 */
		public static function getIsSameType(compareThis:*,toThis:*):Boolean
		{
			return (getClassName(compareThis) == getClassName(toThis));
		}

		/**
		 * checks whether one class is a child of another
		 * @param doesThis the possible child
		 * @param extendThis the possible parent
		 * @return
		 */
		public static function getDoesExtend(doesThis:*,extendThis:*):Boolean
		{
			var doesExtend:Boolean=false;
			var extendsL:XMLList = describeType(doesThis).extendsClass;
			var toThisClassName:String = getClassName(extendThis);
			for each( var i:XML in extendsL)
			{
				if (i.@type.split("::")[1]==toThisClassName)
				{
					doesExtend=true;
					break;
				}
			}
			extendsL=null;
			return doesExtend;
		}
	}
}

