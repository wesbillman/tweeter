package com.salesbuilder.util
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeDragOptions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	
	public class DragExcel
	{
		private var _dataGrid:DataGrid;
		private var dateFormatter:DateFormatter;
		private var dragIcon:BitmapData;
		
		public function DragExcel()
		{
			var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function ():void
				{
					dragIcon = Bitmap(loader.content).bitmapData;
				}
			);
			loader.load(new URLRequest("assets/icon_excel.png"));
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYY-MM-DD-HH-NN-SS";
		} 
		
		public function set dataGrid(dataGrid:DataGrid):void
		{
			_dataGrid = dataGrid;
			_dataGrid.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
			_dataGrid.addEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, dragCompleteHandler);
		}
		
		private function dragCompleteHandler(event:NativeDragEvent):void
		{
			_dataGrid.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
		}

		private function startDragging(event:MouseEvent):void
		{
			if (!event.buttonDown) 
			{
				return;
			}
			_dataGrid.removeEventListener(MouseEvent.MOUSE_MOVE, startDragging)
			var options:NativeDragOptions = new NativeDragOptions();
			options.allowCopy = true;
			options.allowLink = true;
			options.allowMove = false;

			var clipboard:Clipboard = new Clipboard();
			clipboard.setData(ClipboardFormats.TEXT_FORMAT, dgToHTML());
			clipboard.setData(ClipboardFormats.FILE_LIST_FORMAT, [createXLS()]);
			NativeDragManager.doDrag(_dataGrid, clipboard, dragIcon, null, options);
		}
		
		private function createXLS():File
		{
			var file:File = File.createTempDirectory().resolvePath("data-"+dateFormatter.format(new Date())+".xls");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(dgToHTML());
			fileStream.close();
			return file;
		}

		private function dgToHTML():String
		{
			var rows:Array = _dataGrid.selectedItems;
			if (!rows || rows.length == 0)
			{
				return "";
			}
			var html:String = "<table>";
			for (var j:int = 0; j<rows.length; j++)
			{
				var row:Object = rows[j];
				html += "<tr>";
				for (var k:int = 0; k<_dataGrid.columnCount; k++)
				{
					var dataField:Object = DataGridColumn(_dataGrid.columns[k]).dataField;
					if (dataField)
					{
						html += "<td>" + row[dataField] + "</td>";							
					}
				}
				html += "</tr>";
			}
			html += "</table>";
			return html;
		}
			
	}
}