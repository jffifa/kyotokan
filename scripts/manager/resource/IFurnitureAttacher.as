package manager.resource
{
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   
   public interface IFurnitureAttacher
   {
      
      function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;
      
      function dispatchEvent(param1:Event) : Boolean;
      
      function hasEventListener(param1:String) : Boolean;
      
      function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void;
      
      function willTrigger(param1:String) : Boolean;
      
      function stack(param1:int, param2:int, param3:DisplayObjectContainer) : void;
      
      function stackThumbnail(param1:int, param2:int, param3:DisplayObjectContainer) : void;
      
      function stackFloor(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function stackWall(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function stackWindow(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function stackObject(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function stackChest(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function stackDesk(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void;
      
      function load() : void;
      
      function cancel() : void;
   }
}
