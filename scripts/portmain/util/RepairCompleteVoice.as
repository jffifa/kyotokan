package util
{
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import common.util.SoundUtil;
   
   public class RepairCompleteVoice extends Object
   {
      
      public function RepairCompleteVoice()
      {
         super();
      }
      
      private var _activeFlag:Boolean = false;
      
      private var _timers:Array;
      
      private var _timerNum:int;
      
      public function setTimer(param1:Array) : void
      {
         var _loc4_:* = 0;
         var _loc3_:Date = new Date();
         var _loc2_:Number = _loc3_.time;
         _timers = [];
         _timerNum = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] > 0)
            {
               _timers.push(new Timer(param1[_loc4_] - _loc2_,1));
               _timers[_timerNum].addEventListener("timer",_handleOnTime);
               _timers[_timerNum].start();
               _timerNum = _timerNum + 1;
            }
            _loc4_++;
         }
      }
      
      public function stopTimer() : void
      {
         var _loc1_:* = 0;
         _loc1_ = 0;
         while(_loc1_ < _timers.length)
         {
            _timers[_loc1_].removeEventListener("timer",_handleOnTime);
            _loc1_++;
         }
      }
      
      private function _handleOnTime(param1:TimerEvent) : void
      {
         SoundUtil.playVoice(DataFacade.getUserDeckData().getFlagShipData(1).getCharaID(),6);
      }
   }
}
