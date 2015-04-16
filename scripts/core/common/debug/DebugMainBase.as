package common.debug
{
   import flash.display.Sprite;
   import scene.IAppRoot;
   import scene.IPortMain;
   import scene.SceneLoader;
   import a24.tween.Tween24;
   import manager.JSBridgeManager;
   import flash.display.Loader;
   import flash.display.DisplayObject;
   import manager.DebugManager;
   import connection.Connector;
   import flash.system.ApplicationDomain;
   import flash.text.Font;
   import flash.events.Event;
   import flash.display.MovieClip;
   import scene.ISceneMain;
   
   public class DebugMainBase extends Sprite implements IAppRoot, IPortMain
   {
      
      public function DebugMainBase()
      {
         _cutinLayer = new Sprite();
         _blockLayer = new Sprite();
         _debugLayer = new Sprite();
         _jsBridgeManager = new JSBridgeManager();
         connectionTween = Tween24.wait(0);
         params = {};
         super();
         _cacheTrigger = new Date().getTime().toString();
      }
      
      protected var _deployRoot:String = "../";
      
      protected var _scenesRoot:String = "../scenes/";
      
      protected var _debugSWFLoader:SceneLoader;
      
      protected var _iconAssetsLoader:SceneLoader;
      
      protected var _commonAssetsLoader:SceneLoader;
      
      protected var _fontAssetsLoader:SceneLoader;
      
      protected var _soundBGMAssetsLoader:SceneLoader;
      
      protected var _soundSEAssetsLoader:SceneLoader;
      
      protected var _bgSetLoader:SceneLoader;
      
      protected var _mainLoader:SceneLoader;
      
      protected var _cutinLayer:Sprite;
      
      protected var _blockLayer:Sprite;
      
      protected var _debugLayer:Sprite;
      
      public function set deployRoot(param1:String) : void
      {
         _deployRoot = param1;
      }
      
      public function set scenesRoot(param1:String) : void
      {
         _scenesRoot = param1;
      }
      
      public function get deployRoot() : String
      {
         return _deployRoot;
      }
      
      public function get scenesRoot() : String
      {
         return _scenesRoot;
      }
      
      public function get loadProgress() : Number
      {
         return 0;
      }
      
      public function startApp(param1:Object) : void
      {
      }
      
      public function gotoPort(param1:Boolean = false) : void
      {
      }
      
      public function showErrorScreen(param1:String = "") : void
      {
         Debug.log("Error: " + param1);
         Tween24.stopAllTweens().play();
      }
      
      private var _jsBridgeManager:JSBridgeManager;
      
      public function get jsBridgeManager() : JSBridgeManager
      {
         return _jsBridgeManager;
      }
      
      public function log(param1:String = null) : void
      {
         var _loc2_:* = null;
         if(SettingFacade.DEBUG)
         {
            if(_debugLayer.numChildren)
            {
               _loc2_ = (_debugLayer.getChildAt(0) as Loader).content;
               if(_loc2_ && _loc2_.hasOwnProperty("log") && _loc2_["log"] is Function)
               {
                  _loc2_["log"](param1);
               }
            }
         }
         if(optionalLogFunc != null)
         {
            optionalLogFunc(param1);
         }
      }
      
      public function getDebugManager() : DebugManager
      {
         return null;
      }
      
      public function isLoadedSoundBGM() : Boolean
      {
         return true;
      }
      
      public function isLoadedSoundSE() : Boolean
      {
         return true;
      }
      
      public function loadSoundBGMTween(param1:Boolean) : Tween24
      {
         return null;
      }
      
      public function loadSoundSETween(param1:Boolean) : Tween24
      {
         return null;
      }
      
      public function get blockLayer() : Sprite
      {
         return _blockLayer;
      }
      
      public function get debugLayer() : Sprite
      {
         return _debugLayer;
      }
      
      public function get cutinLayer() : Sprite
      {
         return _cutinLayer;
      }
      
      public function finalize() : void
      {
      }
      
      public function backToPort() : void
      {
      }
      
      public function backToPortFromBattle() : void
      {
      }
      
      public function gotoShop() : void
      {
      }
      
      public function updateUpperBar() : void
      {
      }
      
      public function changeFurnitureView(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
      }
      
      public function openJukeBox() : void
      {
      }
      
      public var sceneID:int;
      
      public var filePath:String = "";
      
      public var fileName:String = "";
      
      public var className:String = "";
      
      public var connectionTween:Tween24;
      
      public var startSWFFunc:Function = null;
      
      public var optionalLogFunc:Function = null;
      
      public var params:Object;
      
      private var _cacheTrigger:String;
      
      public function initialize() : void
      {
         _debugSWFLoader = new SceneLoader(_deployRoot + "debug.swf",_cacheTrigger);
         _iconAssetsLoader = new SceneLoader(_deployRoot + "resources/swf/icons.swf",_cacheTrigger);
         _commonAssetsLoader = new SceneLoader(_deployRoot + "resources/swf/commonAssets.swf",_cacheTrigger);
         _fontAssetsLoader = new SceneLoader(_deployRoot + "resources/swf/font.swf",_cacheTrigger);
         _soundBGMAssetsLoader = new SceneLoader(_deployRoot + "resources/swf/sound_bgm.swf",_cacheTrigger);
         _soundSEAssetsLoader = new SceneLoader(_deployRoot + "resources/swf/sound_se.swf",_cacheTrigger);
         _bgSetLoader = new SceneLoader("assets/res_portBG.swf",_cacheTrigger);
         AppFacade.root = this;
         AppFacade.portMain = this;
         Connector.actionBlockLayer = _blockLayer;
         _mainLoader = new SceneLoader(filePath,new Date().getTime().toString());
         params = params == null?{}:params;
         Debug.log("parametors:" + JSON.stringify(params));
         new SettingFacade().initialize(params,_loadDebug);
      }
      
      private function _loadDebug() : void
      {
         _debugSWFLoader.load("debug",_loadedDebug,_loadError);
      }
      
      private function _loadedDebug(param1:SceneLoader) : void
      {
         _debugLayer.addChild(param1.loader);
         _loadIconAsset();
      }
      
      private function _loadIconAsset() : void
      {
         _iconAssetsLoader.load("iconAssets",_loadCommonAsset,_loadError);
      }
      
      private function _loadCommonAsset(param1:SceneLoader = null) : void
      {
         _commonAssetsLoader.load("commonAssets",_loadFontAsset,_loadError);
      }
      
      private function _loadFontAsset(param1:SceneLoader = null) : void
      {
         _fontAssetsLoader.load("fontAsset",_loadSoundAsset,_loadError);
      }
      
      private function _loadSoundAsset(param1:SceneLoader = null) : void
      {
         _soundBGMAssetsLoader.load("soundBGM Asset",_loadSoundSEAsset,_loadError);
      }
      
      private function _loadSoundSEAsset(param1:SceneLoader = null) : void
      {
         _soundSEAssetsLoader.load("soundSE Asset",_loadBGSet,_loadError);
      }
      
      private function _loadBGSet(param1:SceneLoader = null) : void
      {
         var _loc2_:Class = ApplicationDomain.currentDomain.getDefinition("res.fonts.FontJp") as Class;
         Font.registerFont(_loc2_);
         var _loc3_:Class = ApplicationDomain.currentDomain.getDefinition("res.fonts.FontNumber") as Class;
         Font.registerFont(_loc3_);
         _bgSetLoader.load("bgset",_connection,_loadError);
      }
      
      private function _connection(param1:SceneLoader = null) : void
      {
         loader = param1;
         connectionTween.onComplete(function():void
         {
            connectionTween = null;
            dispatchEvent(new Event("complete"));
         }).play();
      }
      
      public function loadMain(param1:SceneLoader = null) : void
      {
         _mainLoader.load("main",_loadComplete,_loadError);
      }
      
      private function _loadComplete(param1:SceneLoader = null) : void
      {
         var _loc2_:* = null;
         _fontAssetsLoader.loader.unload();
         _fontAssetsLoader = null;
         try
         {
            _loc2_ = ApplicationDomain.currentDomain.getDefinition("res.port.MCPortBG") as Class;
         }
         catch(e:ReferenceError)
         {
            showErrorScreen("背景セットクラスの読み込みに失敗 " + e.message);
            return;
         }
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.gotoAndStop(sceneID);
         addChildAt(_loc3_,0);
         _bgSetLoader.loader.unload();
         _bgSetLoader = null;
         __initialize();
      }
      
      protected function _startSWF(param1:ISceneMain) : void
      {
         if(startSWFFunc == null)
         {
            param1.initialTween().onComplete(param1.initialize).play();
         }
         else
         {
            startSWFFunc(param1);
         }
      }
      
      private function __initialize() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         if(className == "")
         {
            _loc2_ = _mainLoader.loader.content;
         }
         else
         {
            _loc1_ = ApplicationDomain.currentDomain.getDefinition(className) as Class;
            _loc2_ = new _loc1_();
         }
         addChild(_loc2_ as DisplayObject);
         addChild(_cutinLayer);
         addChild(_blockLayer);
         _debugLayer.mouseEnabled = false;
         _debugLayer.mouseChildren = false;
         _debugLayer.visible = SettingFacade.DEBUG;
         addChild(_debugLayer);
         _startSWF(_loc2_);
      }
      
      protected function _loadError(param1:SceneLoader) : void
      {
         trace("[Load Error] " + param1.loadID + " (" + param1.url + ")");
         Debug.log("[Load Error] " + param1.loadID + " (" + param1.url + ")");
         showErrorScreen("[mainD2] " + param1.loadID + " load Error");
      }
   }
}
