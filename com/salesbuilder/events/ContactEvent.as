package com.salesbuilder.events
{
	import com.salesbuilder.model.Contact;
	
	import flash.events.Event;

	public class ContactEvent extends Event
	{
		public static const NEW:String = "newContact";
		public static const OPEN:String = "openContact";
	
		public var contactId:int;
		public var contact:Contact;
	
		public function ContactEvent(type:String, contact:Contact = null, contactId:int = 0, bubbles:Boolean = true, cancelable:Boolean = false)
   		{
   			this.contact = contact;
   			this.contactId = contactId;
			super(type, bubbles, cancelable);
		}
	}
}