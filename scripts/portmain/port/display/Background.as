package port.display
{
   import res.port.MCPortBG;
   
   public class Background extends MCPortBG
   {
      
      public function Background()
      {
         super();
      }
      
      public function setState(param1:int) : void
      {
         gotoAndStop(param1);
      }
   }
}
