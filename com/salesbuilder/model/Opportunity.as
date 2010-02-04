package com.salesbuilder.model
{
	import com.salesbuilder.dao.AccountDAO;
	
	[Bindable]
	public class Opportunity
	{
		public var opportunityId:int;
		public var name:String;
		public var owner:int;
		public var expectedCloseDate:Date = new Date();
		public var expectedAmount:Number = 0;
		public var probability:Number = 50;
		public var status:int;
		public var leadSource:String;
		public var notes:String;
		public var lastUpdated:Number = 0;
		public var offlineOperation:String;
		
		public var loaded:Boolean = true;

		private var _account:Account;
		
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
		
	}
}