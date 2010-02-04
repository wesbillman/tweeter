package com.salesbuilder.model
{
	import com.salesbuilder.dao.ContactDAO;
	
	[Bindable]
	public class Activity
	{
		public var id:int;
		public var type:String;
		public var phoneNumber:String;
		public var notes:String;
		public var startTime:Date;
		public var endTime:Date;
		public var lastUpdated:Number = 0;
		public var offlineOperation:String;
		
		public var loaded:Boolean = true;

		private var _contact:Contact;
		
		// Lazy loading of contact
		[Bindable(event="contactChanged")]
		public function get contact():Contact
		{
			if (_contact && !_contact.loaded && _contact.contactId > 0)
			{
				var dao:ContactDAO = new ContactDAO();
				_contact = dao.getItem(_contact.contactId);
			}
			return _contact;
		}
		
		public function set contact(contact:Contact):void
		{
			_contact = contact;
			dispatchEvent(new Event("contactChanged"));
		}
		
	}
}