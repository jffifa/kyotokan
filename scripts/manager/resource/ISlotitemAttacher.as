package manager.resource
{
   import flash.display.DisplayObjectContainer;
   
   public interface ISlotitemAttacher
   {
      
      function stackCard(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackItemOn(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackItemCharacter(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackItemUp(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackStatusTop(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackRemodel(param1:int, param2:DisplayObjectContainer) : void;
      
      function stackBtxt(param1:int, param2:DisplayObjectContainer, param3:Boolean = true) : void;
      
      function load() : void;
      
      function cancel() : void;
   }
}
