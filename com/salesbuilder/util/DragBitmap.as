package com.salesbuilder.util
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.net.URLRequest;
	
	public class DragBitmap
	{
		private var _handle:InteractiveObject;
		
		public var data:DisplayObject;
		
		private var dragIcon:BitmapData;
		
		public function DragBitmap()
		{
			var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function ():void
				{
					dragIcon = Bitmap(loader.content).bitmapData;
				}
			);
			loader.load(new URLRequest("assets/icon_image.png"));
		} 
		
		public function set handle(handle:InteractiveObject):void
		{
			_handle = handle;
			_handle.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
			_handle.addEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, dragCompleteHandler);
		}

		private function dragCompleteHandler(event:NativeDragEvent):void
		{
			_handle.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
		}

		private function startDragging(event:MouseEvent):void
		{
			if (!event.buttonDown)
			{
				return;
			}
			_handle.removeEventListener(MouseEvent.MOUSE_MOVE, startDragging)
			var bitmapData:BitmapData = getBitmapData();
			var clipboard:Clipboard = new Clipboard();
			clipboard.setData(ClipboardFormats.BITMAP_FORMAT, bitmapData, false);
			NativeDragManager.doDrag(_handle, clipboard, dragIcon);
		}
		
		private function getBitmapData():BitmapData
		{
			var bd:BitmapData = new BitmapData(data.width, data.height);
			bd.draw(data);
			return bd;
		}

	}
}