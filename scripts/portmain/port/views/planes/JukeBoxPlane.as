package port.views.planes
{
   import flash.display.Sprite;
   import res.port.MCJukeBoxPopup;
   import common.models.JukeBGMObject;
   import port.views.jukebox.JukeBoxListCell;
   import port.views.jukebox.JukeBoxAlertWindow;
   import res.port.MCJukeUpperButton;
   import res.port.MCJukeDownButton;
   import common.display.ClickAreaLayer;
   import a24.tween.Tween24;
   import flash.ui.Mouse;
   import manager.BGMManager;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   import connection.Connector;
   import connection.api_req_furniture.JukeMusicListAPI;
   
   public class JukeBoxPlane extends Sprite
   {
      
      public function JukeBoxPlane(param1:DisplayObjectContainer)
      {
         super();
         _initView();
         param1.addChild(this);
         if(DataFacade.getMasterBGMData().hasJukeBoxMusicData())
         {
            _start();
         }
         else
         {
            Connector.createTween(true,this,JukeMusicListAPI).onComplete(_start).play();
         }
      }
      
      private var _dialog:MCJukeBoxPopup;
      
      private var _musicList:Vector.<JukeBGMObject>;
      
      private var _musicCell:Vector.<JukeBoxListCell>;
      
      private var _page:int = 5;
      
      private var _onMouseArea:Sprite;
      
      private var _textLayer:Sprite;
      
      private var _onMouserFlag:Boolean = false;
      
      private var _openWindowFlag:Boolean = false;
      
      private var _alert:JukeBoxAlertWindow;
      
      private const MUSIC_DISP_NUM:int = 5;
      
      private var _btn_up:MCJukeUpperButton;
      
      private var _btn_dw:MCJukeDownButton;
      
      private function _initView() : void
      {
         var _loc1_:ClickAreaLayer = new ClickAreaLayer(0.2);
         addChild(_loc1_);
      }
      
      private function _start() : void
      {
         _dialog = new MCJukeBoxPopup();
         _textLayer = new Sprite();
         _btn_up = new MCJukeUpperButton();
         _btn_dw = new MCJukeDownButton();
         _btn_up.x = 166;
         _btn_up.y = 125;
         _btn_dw.x = 166;
         _btn_dw.y = 222;
         _btn_dw.visible = false;
         Tween24.serial(Tween24.prop(_dialog).alpha(0),Tween24.addChild(this,_dialog),Tween24.addChild(this,_textLayer),Tween24.tween(_dialog,0.3).alpha(1),Tween24.func(function():void
         {
            _musicList = DataFacade.getMasterBGMData().getJukeBoxMusicData();
            _page = _musicList.length - 5;
            _setData(_page);
            _onMouseArea = new Sprite();
            _onMouseArea.graphics.beginFill(4286945,0);
            _onMouseArea.graphics.drawRect(31,124,286,113);
            _onMouseArea.graphics.endFill();
            addChild(_onMouseArea);
            _onMouseArea.addEventListener("mouseMove",_handleMouseEvent);
            _onMouseArea.addEventListener("rollOver",_handleMouseEvent);
            _onMouseArea.addEventListener("rollOut",_handleMouseEvent);
            _onMouseArea.addEventListener("click",_handleMouseEvent);
            _onMouseArea.addChild(_btn_up);
            _onMouseArea.addChild(_btn_dw);
            _btn_up.addEventListener("click",_handleClickScrollButton);
            _btn_dw.addEventListener("click",_handleClickScrollButton);
            Mouse.cursor = "auto";
            _onMouseArea.buttonMode = true;
            _onMouseArea.useHandCursor = true;
         })).play();
      }
      
      private function _setData(param1:int) : void
      {
         var _loc2_:* = 0;
         _musicCell = new Vector.<JukeBoxListCell>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _musicCell[_loc2_] = new JukeBoxListCell();
            _musicCell[_loc2_].setData(_musicList[_page + _loc2_]);
            _musicCell[_loc2_].x = 37.75;
            _musicCell[_loc2_].y = 140.8 + 16 * _loc2_;
            _textLayer.addChild(_musicCell[_loc2_]);
            _loc2_++;
         }
      }
      
      private function _updateData(param1:int) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _musicCell[_loc2_].setData(_musicList[_page + _loc2_]);
            _loc2_++;
         }
      }
      
      private function _removePlane() : void
      {
         Tween24.removeChild(this).play();
      }
      
      private function _finalize() : void
      {
         var _loc1_:String = DataFacade.getUserData().getPortMainBGMID();
         BGMManager.playPortBGM(_loc1_);
         if(_dialog != null)
         {
            _onMouseArea.removeEventListener("mouseMove",_handleMouseEvent);
            _onMouseArea.removeEventListener("rollOver",_handleMouseEvent);
            _onMouseArea.removeEventListener("rollOut",_handleMouseEvent);
            _onMouseArea.removeEventListener("click",_handleMouseEvent);
            _btn_up.removeEventListener("click",_handleClickScrollButton);
            _btn_dw.removeEventListener("click",_handleClickScrollButton);
            Tween24.serial(Tween24.tween(_dialog,0.3).alpha(0),Tween24.removeChild(_dialog)).onComplete(_removePlane).play();
         }
         else
         {
            _removePlane();
         }
      }
      
      protected function _handleMouseEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = param1.type;
         if("mouseMove" !== _loc3_)
         {
            if("rollOver" !== _loc3_)
            {
               if("rollOut" !== _loc3_)
               {
                  if("click" === _loc3_)
                  {
                     _loc2_ = Math.ceil((mouseY - 140) / 16);
                     if(_loc2_ > 0 && _loc2_ <= 5)
                     {
                        _alert = new JukeBoxAlertWindow();
                        _alert.setData(_musicList[_page + _loc2_ - 1]);
                        _alert.x = 174;
                        _alert.y = 155;
                        _alert.addEventListener("Jukebox:closeWindow",_handleCloseAlertWindow);
                        addChild(_alert);
                        _openWindowFlag = true;
                        _dialog.visible = false;
                        _textLayer.visible = false;
                        _btn_up.visible = false;
                        _btn_dw.visible = false;
                     }
                  }
               }
               else if(_onMouserFlag && !_openWindowFlag)
               {
                  _finalize();
               }
               
            }
            else
            {
               _onMouserFlag = true;
            }
         }
         else if(mouseX > 33 && mouseX < 315 && mouseY > 140 && mouseY < 221)
         {
            if(!_openWindowFlag)
            {
               _onMouseArea.useHandCursor = true;
            }
         }
         else
         {
            _onMouseArea.useHandCursor = false;
         }
         
      }
      
      protected function _handleClickScrollButton(param1:Event) : void
      {
         _page = _page + (param1.currentTarget == _btn_dw?1:-1.0);
         var _loc2_:int = _musicList.length - 5;
         if(_page < 0)
         {
            _page = 0;
         }
         else if(_page > _loc2_)
         {
            _page = _loc2_;
         }
         
         _btn_up.visible = true;
         _btn_dw.visible = true;
         if(_page == 0)
         {
            _btn_up.visible = false;
         }
         else if(_page == _loc2_)
         {
            _btn_dw.visible = false;
         }
         
         _updateData(_page);
      }
      
      protected function _handleCloseAlertWindow(param1:Event) : void
      {
         _alert.removeEventListener("Jukebox:closeWindow",_handleCloseAlertWindow);
         removeChild(_alert);
         _alert.removeChildren();
         _onMouserFlag = false;
         _openWindowFlag = false;
         _finalize();
      }
   }
}
