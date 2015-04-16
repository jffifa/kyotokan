package res.common
{
   import flash.display.MovieClip;
   
   public dynamic class LoadingShipAnimation extends MovieClip
   {
      
      public function LoadingShipAnimation()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public var wave2:MovieClip;
      
      public var wave3:MovieClip;
      
      function frame1() : *
      {
         this.wave2.gotoAndPlay(20);
         this.wave3.gotoAndPlay(40);
      }
   }
}
