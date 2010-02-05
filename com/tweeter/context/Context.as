package com.tweeter.context
{
	import mx.collections.ArrayCollection;

	public dynamic class Context
	{
		private static var instance:Context;
		
		public var stateList:ArrayCollection;
		
		public var accountNameList:ArrayCollection = new ArrayCollection([
			{data: 0, label:"wesbillman"}, 
			{data: 1, label:"appiness"}]); 

		// Static initializer
		{
			instance = new Context();
		}
		
		public function Context()
		{

		}

		public static function getAttribute(name:String):*
		{
			if (instance.hasOwnProperty(name))
			{
				return instance[name];
			}
			else
			{
				trace("Context property '" + name + "' not found");
				return null;
			}
		}		

		public static function setAttribute(name:String, value:*):void
		{
			instance[name] = value;	
		}		

	}
}