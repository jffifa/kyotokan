package port.display
{
   import flash.display.MovieClip;
   import vo.UserData;
   import common.Consts;
   import vo.UseItemData;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import a24.tween.Tween24;
   import common.util.MCUtil;
   import common.display.DisplayUtil;
   
   public class UpperBar extends Object
   {
      
      public function UpperBar(param1:MovieClip)
      {
         super();
         _mc = param1;
         _mc.header_bauxite.stop();
         DisplayUtil.setButtonMode(_mc.btn_record,_handleClickTopMenuItem(21));
         DisplayUtil.setButtonMode(_mc.btn_friend);
         DisplayUtil.setButtonMode(_mc.btn_album,_handleClickTopMenuItem(25));
         DisplayUtil.setButtonMode(_mc.btn_items,_handleClickTopMenuItem(26));
         DisplayUtil.setButtonMode(_mc.btn_interior,_handleClickTopMenuItem(27));
         DisplayUtil.setButtonMode(_mc.btn_duty,_handleClickTopMenuItem(24));
         DisplayUtil.setButtonMode(_mc.btn_shop,_handleClickTopMenuItem(28));
      }
      
      private var _mc:MovieClip;
      
      private var _initialized:Boolean = false;
      
      public var clickTopMenuHandler:Function = null;
      
      public function update() : void
      {
         updateUserData();
         updateMaterial();
      }
      
      public function updateUserData() : void
      {
         var _loc1_:UserData = DataFacade.getUserData();
         _mc.user_name.text = _loc1_.getNickName();
         _mc.user_level.text = _loc1_.getLevel();
         _mc.user_rank.text = "[" + Consts.RANK_NAME[_loc1_.getRank()] + "]";
         _mc.user_fleets.text = DataFacade.getUserDeckData().deckCount;
         _mc.ship_totalnum.text = DataFacade.getUserDeckData().shipCount;
      }
      
      public function updateMaterial() : void
      {
         var _loc1_:UseItemData = DataFacade.getUseItemData();
         _mc.fuel.text = _loc1_.fuel;
         _mc.ammo.text = _loc1_.ammo;
         _mc.steel.text = _loc1_.steel;
         _mc.bauxite.text = _loc1_.baux;
         _mc.develop_material.text = _loc1_.devKit;
         _mc.hispeed_repair.text = _loc1_.repairKit;
         if(!_initialized)
         {
            _loc1_.addEventListener("EVENT_CHANGE",_handleMaterialCountChange);
            _loc1_.addEventListener("EVENT_USE_BAUXITE_AT_SUPPLY",_handleUseBauxiteAtSupply);
            _initialized = true;
         }
      }
      
      private function _handleClickTopMenuItem(param1:int) : Function
      {
         sceneID = param1;
         return function(param1:MouseEvent):void
         {
            param1.stopImmediatePropagation();
            if(clickTopMenuHandler != null)
            {
               clickTopMenuHandler(sceneID);
            }
         };
      }
      
      private function _handleMaterialCountChange(param1:Event) : void
      {
         updateMaterial();
      }
      
      private function _handleUseBauxiteAtSupply(param1:Event) : void
      {
         Tween24.serial(Tween24.gotoAndStop(1,_mc.header_bauxite),MCUtil.frameTween(_mc.header_bauxite,1,_mc.header_bauxite.totalFrames),Tween24.gotoAndStop(1,_mc.header_bauxite)).play();
      }
   }
}
