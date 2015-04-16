package util
{
   import dto.scene.RecordSceneDTO;
   import scene.ISceneDTO;
   import dto.scene.ItemlistSceneDTO;
   import dto.scene.SceneDTO;
   import dto.scene.SallySceneDTO;
   import port.PortMain;
   import common.util.SceneLoadThread;
   import a24.tween.Tween24;
   import scene.ISceneMain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   
   public class SceneManager extends Object
   {
      
      public function SceneManager()
      {
         super();
      }
      
      private var _nowSceneID:int = 0;
      
      private var _nextSceneID:int = 0;
      
      public function get nowSceneID() : int
      {
         return _nowSceneID;
      }
      
      public function get sceneChangeNow() : Boolean
      {
         return !(_nowSceneID == _nextSceneID);
      }
      
      public function move(param1:int) : Boolean
      {
         var _loc2_:* = null;
         if(sceneChangeNow == true)
         {
            return false;
         }
         if(_nowSceneID == param1 || _nextSceneID == param1)
         {
            return false;
         }
         _nextSceneID = param1;
         var _loc3_:* = param1;
         if(21 !== _loc3_)
         {
            if(26 !== _loc3_)
            {
               if(28 !== _loc3_)
               {
                  if(25 !== _loc3_)
                  {
                     if(27 !== _loc3_)
                     {
                        if(24 !== _loc3_)
                        {
                           if(0 !== _loc3_)
                           {
                              if(15 !== _loc3_)
                              {
                                 if(14 !== _loc3_)
                                 {
                                    if(11 !== _loc3_)
                                    {
                                       if(16 !== _loc3_)
                                       {
                                          if(12 !== _loc3_)
                                          {
                                             if(13 !== _loc3_)
                                             {
                                                if(30 === _loc3_)
                                                {
                                                   _loc2_ = new SceneDTO();
                                                   _createSceneCls(param1,_loc2_);
                                                }
                                             }
                                             else
                                             {
                                                _loc2_ = new SceneDTO();
                                                _createSceneCls(param1,_loc2_);
                                             }
                                          }
                                          else
                                          {
                                             _loc2_ = new SceneDTO();
                                             _createSceneCls(param1,_loc2_);
                                          }
                                       }
                                       else
                                       {
                                          _loc2_ = new SallySceneDTO();
                                          _createSceneCls(param1,_loc2_);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = new SceneDTO();
                                       _createSceneCls(param1,_loc2_);
                                    }
                                 }
                                 else
                                 {
                                    _loc2_ = new SceneDTO();
                                    _createSceneCls(param1,_loc2_);
                                 }
                              }
                              else
                              {
                                 _loc2_ = new SceneDTO();
                                 _createSceneCls(param1,_loc2_);
                              }
                           }
                           else
                           {
                              gotoPort(param1);
                           }
                        }
                        else
                        {
                           _loc2_ = new SceneDTO();
                           _createSceneCls(param1,_loc2_);
                        }
                     }
                     else
                     {
                        _loc2_ = new SceneDTO();
                        _createSceneCls(param1,_loc2_);
                     }
                  }
                  else
                  {
                     _loc2_ = new SceneDTO();
                     _createSceneCls(param1,_loc2_);
                  }
               }
               else
               {
                  _loc2_ = new ItemlistSceneDTO();
                  ItemlistSceneDTO(_loc2_).state = "STATE_ITEMSHOP";
                  _createSceneCls(param1,_loc2_);
               }
            }
            else
            {
               _loc2_ = new ItemlistSceneDTO();
               _createSceneCls(param1,_loc2_);
            }
         }
         else
         {
            _loc2_ = new RecordSceneDTO();
            _createSceneCls(param1,_loc2_);
         }
         return true;
      }
      
      private function _createSceneCls(param1:int, param2:ISceneDTO) : void
      {
         sceneID = param1;
         dto = param2;
         var portMain:PortMain = AppFacade.portMain as PortMain;
         var cls:Class = Assets.getSceneCLS(sceneID);
         if(cls == null)
         {
            SceneLoadThread.actionBlockLayer = portMain.view.blockActionLayer;
            var thread:SceneLoadThread = new SceneLoadThread(sceneID,dto);
            Tween24.serial(portMain.view.fadeLayer.getTween(1,0.15),thread.createTween(true,portMain)).onComplete(function():void
            {
               _move(new thread.cls(),sceneID,dto);
            }).play();
         }
         else
         {
            portMain.view.fadeLayer.getTween(1,0.3).onComplete(_move,new cls(),sceneID,dto).play();
         }
      }
      
      private function _move(param1:ISceneMain, param2:int, param3:ISceneDTO) : void
      {
         var _loc5_:* = null;
         var _loc4_:PortMain = AppFacade.portMain as PortMain;
         if(_nowSceneID == 0)
         {
            _loc4_.finalize();
         }
         else if(_loc4_.view.contentsLayer.numChildren)
         {
            _loc5_ = _loc4_.view.contentsLayer.getChildAt(0);
            if(_loc5_ is Loader)
            {
               _loc5_ = Loader(_loc5_).content;
            }
            if(_loc5_ as ISceneMain)
            {
               ISceneMain(_loc5_).finalize();
            }
         }
         
         if(SettingFacade.ANIMATION_TYPE == 1)
         {
            _changeSceneType1(param1,param2,param3);
         }
         else
         {
            _changeScene(param1,param2,param3);
         }
      }
      
      private function gotoPort(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:PortMain = AppFacade.portMain as PortMain;
         if(_nowSceneID == 0)
         {
            _loc2_.finalize();
         }
         else if(_loc2_.view.contentsLayer.numChildren)
         {
            _loc3_ = _loc2_.view.contentsLayer.getChildAt(0);
            if(_loc3_ is Loader)
            {
               _loc3_ = Loader(_loc3_).content;
            }
            if(_loc3_ as ISceneMain)
            {
               ISceneMain(_loc3_).finalize();
            }
         }
         
         _loc2_.view.setState(param1);
         _loc2_.view.frameView.circleChange(_nowSceneID,param1);
         _loc2_.view.contentsLayer.removeChildren();
         _loc2_.cutinLayer.removeChildren();
         _nowSceneID = param1;
      }
      
      private function _changeScene(param1:ISceneMain, param2:int, param3:ISceneDTO) : void
      {
         sceneMain = param1;
         nextSceneID = param2;
         dto = param3;
         var portMain:PortMain = AppFacade.portMain as PortMain;
         portMain.view.frameView.sideMenu.getTween(nextSceneID).play();
         Tween24.serial(Tween24.func(portMain.view.frameView.circleChange,_nowSceneID,nextSceneID),Tween24.removeAllChildren(portMain.view.contentsLayer,portMain.view.cutinLayer),Tween24.addChild(portMain.view.contentsLayer,sceneMain as DisplayObject),Tween24.func(portMain.view.setState,nextSceneID),sceneMain.initialTween(dto),Tween24.func(sceneMain.initialize,dto),portMain.view.fadeLayer.getTween(0,0.15),Tween24.func(function():void
         {
            _nowSceneID = nextSceneID;
         })).play();
      }
      
      private function _changeSceneType1(param1:ISceneMain, param2:int, param3:ISceneDTO) : void
      {
         sceneMain = param1;
         nextSceneID = param2;
         dto = param3;
         var portMain:PortMain = AppFacade.portMain as PortMain;
         portMain.view.frameView.sideMenu.getTween(nextSceneID).play();
         Tween24.serial(Tween24.func(portMain.view.frameView.circleChange,_nowSceneID,nextSceneID),Tween24.removeAllChildren(portMain.view.contentsLayer,portMain.view.cutinLayer),Tween24.addChild(portMain.view.contentsLayer,sceneMain as DisplayObject),Tween24.func(portMain.view.setState,nextSceneID),sceneMain.initialTween(dto),Tween24.func(sceneMain.initialize,dto),portMain.view.fadeLayer.getTween(0,0),Tween24.func(function():void
         {
            _nowSceneID = nextSceneID;
         })).play();
      }
   }
}
