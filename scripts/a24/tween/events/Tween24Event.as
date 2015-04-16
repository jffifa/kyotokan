package a24.tween.events
{
   import flash.events.Event;
   import a24.tween.Tween24;
   
   public class Tween24Event extends Event
   {
      
      public function Tween24Event(param1:Tween24, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this._tween = param1;
      }
      
      public static const PLAY:String = "play";
      
      public static const DELAY:String = "delay";
      
      public static const INIT:String = "init";
      
      public static const PAUSE:String = "pause";
      
      public static const SKIP:String = "skip";
      
      public static const STOP:String = "stop";
      
      public static const UPDATE:String = "update";
      
      public static const COMPLETE:String = "complete";
      
      private var _tween:Tween24;
      
      override public function toString() : String
      {
         return String("[Tween24Event type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + "]");
      }
      
      public function get tween() : Tween24
      {
         return this._tween;
      }
   }
}
