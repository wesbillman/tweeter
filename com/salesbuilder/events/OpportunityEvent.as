package com.salesbuilder.events
{
	import com.salesbuilder.model.Opportunity;
	
	import flash.events.Event;

	public class OpportunityEvent extends Event
	{
		public static const NEW:String = "newOpportunity";
		public static const OPEN:String = "openOpportunity";
		public static const SAVED:String = "opportunitySaved";
	
		public var opportunity:Opportunity;
	
		public function OpportunityEvent(type:String, opportunity:Opportunity = null, bubbles:Boolean = true, cancelable:Boolean = false)
   		{
   			this.opportunity = opportunity;
			super(type, bubbles, cancelable);
		}
	}
}