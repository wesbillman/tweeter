package com.salesbuilder.events
{
	import com.salesbuilder.model.Contact;
	
	import flash.events.Event;

	public class PhoneEvent extends Event
	{
		public static const MAKE_CALL:String = "makeCall";
	
		public var phoneNumber:String;
		public var contact:Contact;
	
		public function PhoneEvent(type:String, phoneNumber:String, contact:Contact = null, bubbles:Boolean = true, cancelable:Boolean = false)
   		{
   			this.phoneNumber = phoneNumber;
   			this.contact = contact;
			super(type, bubbles, cancelable);
		}
	}
}