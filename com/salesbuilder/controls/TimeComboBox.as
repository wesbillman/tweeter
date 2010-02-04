package com.salesbuilder.controls
{
	import ilog.utils.GregorianCalendar;
	import ilog.utils.TimeUnit;
	import mx.controls.ComboBox;
	import mx.formatters.DateFormatter;
	
	public class TimeComboBox extends mx.controls.ComboBox
	{
		private var _date:Date;
		
		public function TimeComboBox() 
		{
			createModel();	
		}
		
		public function set date(date:Date):void 
		{
			_date = date;
   			this.selectedIndex = _date.hours * 4 + _date.minutes / 15;	
		}

		public function get date():Date
		{
			return _date;
		}
		
		override public function set dataProvider(dataProvider:Object):void 
	   	{
	   		// Ignore: the dataProvider is set in the constructor
	   	}

		override protected function createChildren():void
		{
			super.createChildren();
		}
	   	
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}

		private function createModel():void 
		{     
	        var model:Array = [];
    	    var date:Date = new Date(2008, 1, 1); //only the hour is used.
        
        	var calendar:GregorianCalendar = new GregorianCalendar();
        
        	var df:DateFormatter = new DateFormatter();
        	df.formatString = "LL:NNA";
                
        	for (var j:int = 0; j<4*24; j++) {          
          		model.push({
            				label: df.format(date),
            				hours: date.hours,
            				minutes: date.minutes
          		});
          		date = calendar.addUnits(date, TimeUnit.MINUTE, 15, true);
        	}                   
	        super.dataProvider = model;;                                             
      	}

	}
}