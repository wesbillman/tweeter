package com.salesbuilder.model
{
	import com.salesbuilder.dao.ContactDAO;
	import com.salesbuilder.dao.IContactDAO;
	import com.salesbuilder.dao.IOpportunityDAO;
	import com.salesbuilder.dao.OpportunityDAO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Account
	{
		public var accountId:int;
		public var name:String;
		public var type:int;
		public var industry:int;
		public var owner:int;
		public var phone:String;
		public var fax:String;
		public var ticker:String;
		public var ownership:String;
		public var numberEmployees:int;
		public var annualRevenue:Number = 0;
		public var priority:int;
		public var address1:String;
		public var address2:String;
		public var city:String;
		public var state:String;
		public var zip:String;
		public var notes:String;
		public var lastUpdated:Number = 0;
		public var offlineOperation:String;
		public var url:String;
		public var rating:int;
		public var currentYearResults:Number = 0;
		public var lastYearResults:Number = 0;
		
		public var contactDAO:IContactDAO = new ContactDAO();
		public var opportunityDAO:IOpportunityDAO = new OpportunityDAO();
		
		private var _contacts:ArrayCollection = new ArrayCollection();
		public var contactsLoaded:Boolean = false;
		
		private var _opportunities:ArrayCollection = new ArrayCollection();
		public var opportunitiesLoaded:Boolean = false;
		
		public var loaded:Boolean = true;
		
		// Lazy loading of the list of contacts
		[Bindable(event="contactsChanged")]
		public function get contacts():ArrayCollection
		{
			if (!contactsLoaded && accountId > 0)
			{
				_contacts = contactDAO.findByAccount(accountId);
				contactsLoaded = true;
			}
			return _contacts;
		}
		
		// Lazy loading of the list of opportunities
		[Bindable(event="opportunitiesChanged")]
		public function get opportunities():ArrayCollection
		{
			if (!opportunitiesLoaded && accountId > 0)
			{
				_opportunities = opportunityDAO.findByAccount(accountId);
				opportunitiesLoaded = true;
			}
			return _opportunities;
		}
		
	}
}