package common.debug
{
   public class Debug extends Object
   {
      
      public function Debug()
      {
         super();
      }
      
      public static function log(... rest) : void
      {
         var _loc2_:String = rest.join("\n");
         try
         {
            AppFacade.debugMessage(_loc2_);
         }
         catch(error:ReferenceError)
         {
         }
      }
   }
}
