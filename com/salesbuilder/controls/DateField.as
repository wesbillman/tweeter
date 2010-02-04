// Christophe Coenraets, christophe@coenraets.org - http://coenraets.org
package com.salesbuilder.controls
{
	import flash.events.Event;
	import mx.controls.DateField;
	import mx.core.mx_internal;

	use namespace mx_internal;
	
	public class DateField extends mx.controls.DateField
	{
		override protected function createChildren():void
		{
			super.createChildren();
			textInput.addEventListener("updateComplete", updateHandler);
		}

		private function updateHandler(event:Event):void
		{
			textInput.getTextField().y = 5;
		}
	}
}