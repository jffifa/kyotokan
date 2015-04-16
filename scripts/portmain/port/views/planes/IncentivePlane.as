package port.views.planes
{
   import flash.display.Sprite;
   import common.display.ClickAreaLayer;
   import flash.events.Event;
   import dto.IncentiveDTO;
   import common.reward.views.IncentiveShip;
   import common.reward.views.IncentiveSlotitem;
   import common.reward.views.IncentiveUseitem;
   import common.reward.views.IncentiveFurniture;
   import a24.tween.Tween24;
   import flash.display.DisplayObjectContainer;
   
   public class IncentivePlane extends Sprite
   {
      
      public function IncentivePlane(param1:DisplayObjectContainer)
      {
         super();
         if(DataFacade.getIncentiveData().hasIncentive())
         {
            _initView();
            param1.addChild(this);
            _incentiveGet();
         }
      }
      
      private function _initView() : void
      {
         var _loc1_:ClickAreaLayer = new ClickAreaLayer(0.5);
         addChild(_loc1_);
      }
      
      private function _incentiveGet(param1:Event = null) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc6_:IncentiveDTO = DataFacade.getIncentiveData().shiftIncentiveItem();
         if(_loc6_)
         {
            _loc5_ = {
               "mstId":_loc6_.mstId,
               "message":_loc6_.message
            };
            addEventListener("INCENTIVE_END",_incentiveGet);
         }
         else
         {
            removeEventListener("INCENTIVE_END",_incentiveGet);
            _removePlane();
         }
         if(_loc6_)
         {
            return;
         }
      }
      
      private function _removePlane() : void
      {
         Tween24.removeChild(this).play();
      }
   }
}
