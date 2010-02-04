package com.salesbuilder.events
{
	import flash.events.Event;

	public class DataSyncEvent extends Event
	{
		public static const COMPLETE:String = "dataSyncComplete";
	
		public function DataSyncEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false)
   		{
			super(type, bubbles, cancelable);
		}
	}
}