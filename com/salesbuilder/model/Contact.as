package com.salesbuilder.model
{
	import com.salesbuilder.dao.AccountDAO;
	import com.salesbuilder.dao.ActivityDAO;
	import com.salesbuilder.dao.ContactDAO;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Contact
	{
		public var contactId:int;
		public var firstName:String;
		public var lastName:String;
		public var title:String;
		public var owner:int;
		public var officePhone:String;
		public var cellPhone:String;
		public var email:String;
		public var fax:String;
		public var address1:String;
		public var address2:String;
		public var city:String;
		public var state:String;
		public var zip:String;
		public var notes:String;
		public var priority:int;
		public var picture:ByteArray;
		public var lastUpdated:Number = 0;
		public var offlineOperation:String;

		private var _account:Account;
		private var _manager:Contact;

		private var _activities:ArrayCollection = new ArrayCollection();
		public var activitiesLoaded:Boolean = false;
		
		public var loaded:Boolean = true;
		
		public function Contact(contactId:int = 0)
		{
			if (contactId > 0)
			{
				this.contactId = contactId;
			}
		}
		
		
		// Lazy loading of account
		[Bindable(event="accountChanged")]
		public function get account():Account
		{
			if (_account && !_account.loaded && _account.accountId > 0)
			{
				var dao:AccountDAO = new AccountDAO();
				_account = dao.getItem(_account.accountId);
			}
			return _account;
		}
		
		public function set account(account:Account):void
		{
			_account = account;
			dispatchEvent(new Event("accountChanged"));
		}

		// Lazy loading of manager
		[Bindable(event="managerChanged")]
		public function get manager():Contact
		{
			if (_manager && !_manager.loaded && _manager.contactId > 0)
			{
				var dao:ContactDAO = new ContactDAO();
				_manager = dao.getItem(_manager.contactId);
			}
			return _manager;
		}
		
		public function set manager(__manager:Contact):void
		{
			_manager = __manager;
			dispatchEvent(new Event("managerChanged"));
		}
		
		// Lazy loading of the list of activities
		[Bindable(event="activitiesChanged")]
		public function get activities():ArrayCollection
		{
			if (!activitiesLoaded && contactId > 0)
			{
				var activityDAO:ActivityDAO = new ActivityDAO();
				_activities = activityDAO.findByContact(contactId);
				activitiesLoaded = true;
			}
			return _activities;
		}
		

	}
}