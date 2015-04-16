package port
{
   import flash.display.Sprite;
   import scene.IPortMain;
   import util.SceneManager;
   import port.display.PortMainView;
   import util.RepairCompleteVoice;
   import common.views.BlockerLayer;
   import connection.Connector;
   import common.util.SceneLoadThread;
   import a24.tween.Tween24;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import common.util.SoundUtil;
   import manager.CacheManager;
   import connection.api_port.PortAPI;
   import vo.UserShipData;
   import common.util.Util;
   import manager.BGMManager;
   import vo.UserData;
   import vo.UserFurnitureData;
   import port.views.planes.JukeBoxPlane;
   import port.views.planes.TutorialPlane;
   import port.views.planes.IncentivePlane;
   import port.views.planes.CombinedBrokenPlane;
   import port.views.planes.MissionResultPlane;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class PortMain extends Sprite implements IPortMain
   {
      
      public function PortMain()
      {
         super();
         AppFacade.portMain = this;
         _sceneManager = new SceneManager();
         _mainView = new PortMainView();
         addChild(_mainView);
         _mainView.topLeftMenu.clickHandler = menuClickHandler;
         _mainView.frameView.upperBar.clickTopMenuHandler = menuUClickHandler;
         _mainView.frameView.clickMenuHandler = menuClickHandler;
         _mainView.frameView.clickCircleHandler = circleClickHandler;
         alpha = 0;
         _mainView.fadeLayer.alpha = 1;
      }
      
      private var _sceneManager:SceneManager;
      
      private var _mainView:PortMainView;
      
      private var _repairTimer:RepairCompleteVoice;
      
      public function get view() : PortMainView
      {
         return _mainView;
      }
      
      public function get cutinLayer() : Sprite
      {
         return _mainView.cutinLayer;
      }
      
      public function initialize() : void
      {
         BlockerLayer.actionBlockLayer = _mainView.blockActionLayer;
         Connector.actionBlockLayer = _mainView.blockActionLayer;
         SceneLoadThread.actionBlockLayer = _mainView.blockActionLayer;
         Tween24.serial(_preShowBefore(),Tween24.prop(this).alpha(1),_mainView.fadeLayer.getTween(0,1),Tween24.func(function():void
         {
            (AppFacade.root as DisplayObject).dispatchEvent(new Event("Core:FurnitureShowEnd"));
            var _loc1_:int = DataFacade.getUserDeckData().getFlagShipData(1).getCharaID();
            SoundUtil.playVoice(_loc1_,1);
            standardAfterInitPort();
         })).play();
      }
      
      public function backToPort() : void
      {
         Tween24.serial(_preShowBefore(),Tween24.func(function():void
         {
            var _loc1_:* = 0;
            _sceneManager.move(0);
            var _loc2_:Number = Math.random();
            if(_loc2_ <= 0.4)
            {
               _loc1_ = DataFacade.getUserDeckData().getFlagShipData(1).getCharaID();
               if(_loc2_ <= 0.05)
               {
                  SoundUtil.playVoice(_loc1_,4);
               }
               else if(_loc2_ <= 0.2)
               {
                  SoundUtil.playVoice(_loc1_,3);
               }
               else
               {
                  SoundUtil.playVoice(_loc1_,2);
               }
               
            }
            standardAfterInitPort();
         })).play();
      }
      
      public function gotoShop() : void
      {
         _sceneManager.move(28);
      }
      
      public function backToPortFromBattle() : void
      {
         Tween24.serial(_preShowBefore(),Tween24.func(function():void
         {
            _sceneManager.move(0);
            CacheManager.reduceCache();
            var _loc1_:int = DataFacade.getUserDeckData().getFlagShipData(1).getCharaID();
            SoundUtil.playVoice(_loc1_,7);
            standardAfterInitPort();
         })).play();
      }
      
      public function finalize() : void
      {
         trace("母港TOP finalize");
         _mainView.removeEventListener("mouseMove",_handleMouseMove);
         _mainView.removeEventListener("click",_handleMouseClick);
         _mainView.overLayer.removeChildren();
         _mainView.missionResultLayer.removeChildren();
         _mainView.furnitureView.callFurnitureMethod(false,null);
      }
      
      private function _preShowBefore(param1:Boolean = false) : Tween24
      {
         isFirst = param1;
         var logList:Array = [];
         return Tween24.serial(Connector.createTween(true,this,new PortAPI(logList)),Tween24.func(function():void
         {
            _mainView.logBox.update(logList);
            _mainView.clickAreaActive = true;
            var _loc3_:UserShipData = DataFacade.getUserDeckData().getFlagShipData(1);
            var _loc2_:int = _loc3_.getCharaID();
            _mainView.partnerShipView.load(_loc2_,_loc3_.getCondition(),Util.isMarriaged(_loc3_.getLevel()));
            var _loc1_:Boolean = _loc2_ == 182 || _loc2_ == 187;
            _mainView.topLeftMenu.setAkashiBtnState(_loc1_);
            _mainView.frameView.upperBar.update();
            _mainView.setState(0);
            _repairTimer = new RepairCompleteVoice();
         }),Tween24.parallel(Tween24.waitEvent(_mainView.furnitureView,"complete"),Tween24.func(_showFurniture)),Tween24.func(_showPortEvent));
      }
      
      public function standardAfterInitPort() : void
      {
         var bgmID:String = DataFacade.getUserData().getPortMainBGMID();
         Tween24.serial(_mainView.topLeftMenu.getTweenShow(),Tween24.func(function():void
         {
            _mainView.clickAreaActive = false;
            _mainView.addEventListener("mouseMove",_handleMouseMove);
            _mainView.addEventListener("click",_handleMouseClick);
            _mainView.furnitureView.callFurnitureMethod(true,null);
         }),BGMManager.getTweenPortBGM(bgmID)).play();
      }
      
      private function _showFurniture() : void
      {
         var _loc8_:UserData = DataFacade.getUserData();
         var _loc6_:UserFurnitureData = DataFacade.getUserFurnitureData();
         var _loc3_:int = _loc6_.getUserFloorNo(_loc8_);
         var _loc7_:int = _loc6_.getUserWallNo(_loc8_);
         var _loc4_:int = _loc6_.getUserWindowNo(_loc8_);
         var _loc2_:int = _loc6_.getUserObjectNo(_loc8_);
         var _loc5_:int = _loc6_.getUserChestNo(_loc8_);
         var _loc1_:int = _loc6_.getUserDeskNo(_loc8_);
         changeFurnitureView(_loc3_,_loc7_,_loc4_,_loc2_,_loc5_,_loc1_);
      }
      
      public function updateUpperBar() : void
      {
         _mainView.frameView.upperBar.updateUserData();
      }
      
      public function changeFurnitureView(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         _mainView.furnitureView.updateFloor(param1,false);
         _mainView.furnitureView.updateWall(param2,false);
         _mainView.furnitureView.updateWindow(param3,false);
         _mainView.furnitureView.updateObject(param4,false);
         _mainView.furnitureView.updateChest(param5,false);
         _mainView.furnitureView.updateDesk(param6);
      }
      
      public function openJukeBox() : void
      {
      }
      
      private function _showPortEvent() : void
      {
         new TutorialPlane(_mainView.overLayer);
         new IncentivePlane(_mainView.overLayer);
         new CombinedBrokenPlane(_mainView.overLayer);
      }
      
      private function menuUClickHandler(param1:int) : void
      {
         _sceneManager.move(param1);
      }
      
      private function menuClickHandler(param1:int) : void
      {
         if(_sceneManager.move(param1))
         {
            _mainView.frameView.sideMenu.setMouseEnebled(false);
            SoundUtil.playSE(Assets.SE_system23);
         }
      }
      
      private function circleClickHandler(param1:MouseEvent = null) : void
      {
         if(_sceneManager.sceneChangeNow == true)
         {
            return;
         }
         if(_sceneManager.nowSceneID == 0)
         {
            if(param1 != null)
            {
               param1.stopImmediatePropagation();
            }
            _mainView.toggleShowFurniture();
            if(_mainView.isShowFurniture())
            {
            }
         }
         else
         {
            AppFacade.gotoPort();
         }
      }
      
      private function _handleMouseMove(param1:MouseEvent) : void
      {
         if(_sceneManager.sceneChangeNow)
         {
            return;
         }
         if(_mainView.overLayer.numChildren > 0 || _mainView.missionResultLayer.numChildren > 0)
         {
            if(Mouse.cursor != "auto")
            {
               Mouse.cursor = "auto";
            }
            return;
         }
         var _loc2_:Boolean = _mainView.partnerShipView.mouseMove(param1);
         if(_loc2_ == true)
         {
            Mouse.cursor = "button";
         }
         else
         {
            _loc2_ = _mainView.furnitureView.mouseMove(param1);
            if(_loc2_ == true)
            {
               Mouse.cursor = "button";
            }
            else
            {
               Mouse.cursor = "auto";
            }
         }
      }
      
      private function _handleMouseClick(param1:MouseEvent) : void
      {
         if(_sceneManager.sceneChangeNow)
         {
            return;
         }
         if(_mainView.overLayer.numChildren > 0 || _mainView.missionResultLayer.numChildren > 0)
         {
            return;
         }
         var _loc2_:Boolean = _mainView.partnerShipView.mouseClick(param1);
         if(_loc2_ == false)
         {
            _loc2_ = _mainView.furnitureView.mouseClick(param1);
            if(_loc2_ == false)
            {
               if(_mainView.isShowFurniture() == false)
               {
                  circleClickHandler();
               }
            }
         }
      }
   }
}
