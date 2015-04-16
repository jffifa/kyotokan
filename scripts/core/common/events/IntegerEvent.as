package common.events
{
   import flash.events.Event;
   
   public class IntegerEvent extends Event
   {
      
      public function IntegerEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         this.data = param1;
         super("EVENT::BOOLEAN",param2,param3);
      }
      
      public static const EVENT_NAME:String = "EVENT::BOOLEAN";
      
      public var data:int = 0;
   }
}
