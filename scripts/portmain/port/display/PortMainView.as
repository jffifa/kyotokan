package port.display
{
   import flash.display.Sprite;
   import common.display.furniture.FurnitureView;
   import common.display.FadeLayer;
   import common.display.ClickAreaLayer;
   import flash.events.Event;
   
   public class PortMainView extends Sprite
   {
      
      public function PortMainView()
      {
         super();
         _initializeViewParts();
         clickAreaActive = false;
         _optionView.addEventListener("PORT::OPTION::OPEN",_handleOpenOption);
         _optionView.addEventListener("PORT::OPTION::CLOSE",_handleCloseOption);
      }
      
      private var _background:Background;
      
      private var _furnitureView:FurnitureView;
      
      private var _partnerShipView:PartnerShipView;
      
      private var _topLeftMenu:LeftMenu;
      
      private var _uiWindowLayer:Sprite;
      
      private var _fadeLayer:FadeLayer;
      
      private var _logBox:LogBox;
      
      private var _frameView:FrameView;
      
      private var _overLayer:Sprite;
      
      private var _optionView:OptionSet;
      
      private var _misstionResultLayer:Sprite;
      
      private var _cutinLayer:Sprite;
      
      private var _clickAreaLayer:ClickAreaLayer;
      
      private var _blockActionLayer:Sprite;
      
      public function get background() : Background
      {
         return _background;
      }
      
      public function get furnitureView() : FurnitureView
      {
         return _furnitureView;
      }
      
      public function get partnerShipView() : PartnerShipView
      {
         return _partnerShipView;
      }
      
      public function get topLeftMenu() : LeftMenu
      {
         return _topLeftMenu;
      }
      
      public function get contentsLayer() : Sprite
      {
         return _uiWindowLayer;
      }
      
      public function get fadeLayer() : FadeLayer
      {
         return _fadeLayer;
      }
      
      public function get logBox() : LogBox
      {
         return _logBox;
      }
      
      public function get frameView() : FrameView
      {
         return _frameView;
      }
      
      public function get overLayer() : Sprite
      {
         return _overLayer;
      }
      
      public function get optionView() : OptionSet
      {
         return _optionView;
      }
      
      public function get missionResultLayer() : Sprite
      {
         return _misstionResultLayer;
      }
      
      public function get cutinLayer() : Sprite
      {
         return _cutinLayer;
      }
      
      public function get clickAreaLayer() : ClickAreaLayer
      {
         return _clickAreaLayer;
      }
      
      public function get blockActionLayer() : Sprite
      {
         return _blockActionLayer;
      }
      
      public function get clickAreaActive() : Boolean
      {
         return _clickAreaLayer.visible;
      }
      
      public function set clickAreaActive(param1:Boolean) : void
      {
         _clickAreaLayer.visible = param1;
      }
      
      public function isShowFurniture() : Boolean
      {
         return frameView.visible;
      }
      
      public function setState(param1:int) : void
      {
         _background.setState(param1);
         _furnitureView.setState(param1);
         _partnerShipView.setState(param1);
         _topLeftMenu.setState(param1);
         _frameView.setState(param1);
         _logBox.setState(param1);
         _optionView.setState(param1);
      }
      
      public function toggleShowFurniture() : void
      {
         var _loc1_:Boolean = isShowFurniture();
         frameView.visible = !_loc1_;
         topLeftMenu.visible = !_loc1_;
         optionView.visible = !_loc1_;
         logBox.visible = !_loc1_;
         overLayer.removeChildren();
      }
      
      private function _initializeViewParts() : void
      {
         _background = new Background();
         _furnitureView = new FurnitureView();
         _partnerShipView = new PartnerShipView();
         _topLeftMenu = new LeftMenu();
         _uiWindowLayer = new Sprite();
         _fadeLayer = new FadeLayer();
         _logBox = new LogBox(356,320);
         _frameView = new FrameView();
         _overLayer = new Sprite();
         _optionView = new OptionSet();
         _misstionResultLayer = new Sprite();
         _cutinLayer = new Sprite();
         _clickAreaLayer = new ClickAreaLayer();
         _blockActionLayer = new Sprite();
         addChild(_background);
         addChild(_furnitureView);
         addChild(_partnerShipView);
         addChild(_topLeftMenu);
         addChild(_uiWindowLayer);
         addChild(_fadeLayer);
         addChild(_logBox);
         addChild(_frameView);
         addChild(_overLayer);
         addChild(_optionView);
         addChild(_misstionResultLayer);
         addChild(_cutinLayer);
         addChild(_clickAreaLayer);
         addChild(_blockActionLayer);
      }
      
      private function _handleOpenOption(param1:Event) : void
      {
         logBox.setState(0);
      }
      
      private function _handleCloseOption(param1:Event) : void
      {
         _furnitureView.callFurnitureMethod(true,null);
      }
   }
}
