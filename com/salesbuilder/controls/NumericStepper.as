// Christophe Coenraets, christophe@coenraets.org - http://coenraets.org 
package com.salesbuilder.controls
{
	import flash.events.Event;
	import mx.controls.NumericStepper;
	import mx.core.mx_internal;

	use namespace mx_internal;
	
	public class NumericStepper extends mx.controls.NumericStepper
	{
		override protected function createChildren():void
		{
			super.createChildren();
			inputField.addEventListener("updateComplete", updateHandler);
		}

		private function updateHandler(event:Event):void
		{
			inputField.getTextField().y = 5;
		}
		
	}
}