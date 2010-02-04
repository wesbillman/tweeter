// Christophe Coenraets, christophe@coenraets.org - http://coenraets.org
package com.salesbuilder.controls
{
	import mx.controls.TextInput;

	public class TextInput extends mx.controls.TextInput
	{
		override protected function createChildren():void
		{
			super.createChildren();
			height=29;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			textField.y = 5;
		}
		
	}
}