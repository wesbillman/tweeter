package com.salesbuilder.events
{
	import com.salesbuilder.model.Account;
	
	import flash.events.Event;

	public class AccountEvent extends Event
	{
		public static const NEW:String = "newAccount";
		public static const OPEN:String = "openAccount";
		public static const SAVED:String = "accountSaved";
	
		public var account:Account;
	
		public function AccountEvent(type:String, account:Account = null, bubbles:Boolean = true, cancelable:Boolean = false)
   		{
   			this.account = account;
			super(type, bubbles, cancelable);
		}
	}
}