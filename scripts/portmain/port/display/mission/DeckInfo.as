package port.display.mission
{
   import flash.display.MovieClip;
   import a24.tween.Tween24;
   import port.models.dto.MissionResultDTO;
   import manager.resource.IShipAttacher;
   import vo.UserShipData;
   import common.display.girl.Banner;
   import flash.events.IEventDispatcher;
   
   public class DeckInfo extends Object
   {
      
      public function DeckInfo(param1:MovieClip)
      {
         var _loc2_:* = 0;
         super();
         _mc = param1;
         param1.stop();
         param1.visible = false;
         _bannerCanvases = Vector.<MovieClip>([param1.s1,param1.s2,param1.s3,param1.s4,param1.s5,param1.s6]);
         _infos = Vector.<MovieClip>([param1.info1,param1.info2,param1.info3,param1.info4,param1.info5,param1.info6]);
         _nexts = Vector.<MovieClip>([param1.next1,param1.next2,param1.next3,param1.next4,param1.next5,param1.next6]);
         _loc2_ = 0;
         while(_loc2_ < _bannerCanvases.length)
         {
            _bannerCanvases[_loc2_].alpha = 0;
            _bannerCanvases[_loc2_].removeChildren();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _nexts.length)
         {
            _infos[_loc2_].alpha = 0;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _nexts.length)
         {
            _nexts[_loc2_].alpha = 0;
            _loc2_++;
         }
      }
      
      private var _mc:MovieClip;
      
      private var _bannerCanvases:Vector.<MovieClip>;
      
      private var _nexts:Vector.<MovieClip>;
      
      private var _infos:Vector.<MovieClip>;
      
      public function getTweenInitialize(param1:MissionResultDTO) : Tween24
      {
         var _loc7_:* = 0;
         var _loc3_:* = null;
         var _loc2_:* = 0;
         var _loc6_:* = null;
         var _loc8_:IShipAttacher = AppFacade.createShipAttacher();
         var _loc5_:Array = param1.shipIDs;
         var _loc4_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < 6)
         {
            _loc3_ = null;
            if(_loc5_.hasOwnProperty(_loc7_))
            {
               _loc2_ = _loc5_[_loc7_];
               _loc3_ = DataFacade.getUserDeckData().getShipData(_loc2_);
            }
            if(_loc3_)
            {
               _loc6_ = new Banner();
               _loc6_.reserve(_loc8_,_loc3_.getCharaID(),_loc3_.getCondition());
               _loc6_.setStateIcon(_loc3_.getIconType(),_loc3_.isInRepairDock(),_loc3_.isInMission(),_loc3_.getCondition());
               _loc6_.setVitalState(_loc3_.getTired());
               _loc6_.setRing(_loc3_.getLevel());
               _bannerCanvases[_loc7_].addChild(_loc6_);
               _infos[_loc7_].nameText.text = _loc3_.getName();
               _infos[_loc7_].levelText.text = _loc3_.getLevel();
               _nexts[_loc7_].removeChildren();
            }
            else
            {
               _infos[_loc7_].removeChildren();
               _nexts[_loc7_].removeChildren();
            }
            _loc7_++;
         }
         return Tween24.funcAndWaitEvent(_loc8_ as IEventDispatcher,"complete",_loc8_.load);
      }
      
      public function getTween() : Tween24
      {
         return Tween24.serial(Tween24.visible(true,_mc),Tween24.parallel(getTweenShowShips(),getTweenShowInfos().delay(0.5)));
      }
      
      private function getTweenShowShips() : Tween24
      {
         var _loc2_:* = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _bannerCanvases.length)
         {
            _bannerCanvases[_loc2_].y = _bannerCanvases[_loc2_].y + 10;
            _loc1_.push(Tween24.tween(_bannerCanvases[_loc2_],0.2).alpha(1).$$y(-10).delay(_loc2_ * 0.2));
            _loc2_++;
         }
         return Tween24.parallel(_loc1_);
      }
      
      private function getTweenShowInfos() : Tween24
      {
         var _loc2_:* = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _infos.length)
         {
            _infos[_loc2_].y = _infos[_loc2_].y + 5;
            _loc1_.push(Tween24.tween(_infos[_loc2_],0.2).alpha(1).$$y(-5).delay(_loc2_ * 0.1));
            _loc2_++;
         }
         return Tween24.parallel(_loc1_);
      }
   }
}
