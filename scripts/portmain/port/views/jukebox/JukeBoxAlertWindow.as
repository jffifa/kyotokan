package port.views.jukebox
{
   import flash.display.Sprite;
   import res.port.MCJukeDialog;
   import common.models.JukeBGMObject;
   import a24.tween.Tween24;
   import manager.BGMManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import connection.api_req_furniture.JukeMusicSetAPI;
   import connection.Connector;
   
   public class JukeBoxAlertWindow extends Sprite
   {
      
      public function JukeBoxAlertWindow()
      {
         super();
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(-174,-155,800,480);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         _view = new MCJukeDialog();
         _nowFCoin = DataFacade.getUseItemData().getCount(44);
         addChild(_view);
      }
      
      private var _view:MCJukeDialog;
      
      private const MODE_BEFORE:int = 0;
      
      private const MODE_AFTER:int = 1;
      
      private const MODE_PORT_BGM:int = 2;
      
      private var _mode:int = 0;
      
      private var _fairy:JukeFairy;
      
      private var _musicData:JukeBGMObject;
      
      private var _nowFCoin:int;
      
      private var _buyable:Boolean = false;
      
      private var _api:UseFCoinAPI;
      
      private var _titleTween:Tween24;
      
      private var _fairyLayer:Sprite;
      
      public function setData(param1:JukeBGMObject) : void
      {
         _musicData = param1;
         if(_musicData.fCoin > _nowFCoin)
         {
            _view.gotoAndStop(2);
         }
         else
         {
            _buyable = true;
            _view.gotoAndStop(1);
            _view.inBtn.buttonMode = true;
            _view.inBtn.addEventListener("click",_handleClickButton);
            _view.after_box.text = (_nowFCoin - _musicData.fCoin).toString();
         }
         _view.before_box.text = _nowFCoin.toString();
         _view.need_box.text = _musicData.fCoin.toString();
         _view.title_box.text = _musicData.name;
         _view.backBtn.buttonMode = true;
         _view.backBtn.addEventListener("click",_handleClickButton);
         _view.bgmset.gotoAndStop(_musicData.bgmFlag?2:1.0);
      }
      
      public function finalize(param1:Object = null) : void
      {
         var _loc2_:* = null;
      }
      
      private function thirdFrame() : void
      {
         var _loc1_:Object = _api.result;
         _api = null;
         DataFacade.getUseItemData().setKaguCoin(_loc1_.api_coin);
         BGMManager.JUKEBOX_SOUND = _musicData.bgmId;
         Tween24.serial(BGMManager.getTweenPortBGM(_musicData.bgmId,0,null,null,null,finalize,_musicData.loopCount)).play();
         _view.gotoAndStop(3);
         _view.setBGMbutton.gotoAndStop(_musicData.bgmFlag?2:1.0);
         _view.setBGMbutton.addEventListener("click",_handleClickButton);
         _view.setBGMbutton.buttonMode = true;
         _view.closeBtn.buttonMode = true;
         _view.closeBtn.addEventListener("click",_handleClickButton);
         var _loc3_:String = "「" + _musicData.name + "」　リクエスト中♪";
         _view.title_box2.text = _loc3_;
         var _loc2_:Number = _view.title_box2.textWidth;
         _fairyLayer = new Sprite();
         addChild(_fairyLayer);
         _fairy = new JukeFairy();
         _fairy.x = 400;
         _fairy.y = 140;
         _fairyLayer.addChild(_fairy);
         _mode = 1;
         _titleTween = Tween24.loop(0,Tween24.serial(Tween24.tween(_view.title_box2,0.25 * _loc3_.length).x(233 - _loc2_ / 2),Tween24.wait(1.5),Tween24.tween(_view.title_box2,0.25 * _loc3_.length).x(68 - _loc2_),Tween24.prop(_view.title_box2).x(412),Tween24.wait(0.8)));
         _titleTween.play();
      }
      
      private function _setPortBGM(param1:String) : void
      {
         DataFacade.getUserData().setPortMainBGMID(param1);
      }
      
      public function _handleClickButton(param1:MouseEvent) : void
      {
         event = param1;
         var _loc3_:* = event.currentTarget;
         if(_view.inBtn !== _loc3_)
         {
            if(_view.backBtn !== _loc3_)
            {
               if(_view.closeBtn !== _loc3_)
               {
                  if(_view.setBGMbutton === _loc3_)
                  {
                     var api:JukeMusicSetAPI = new JukeMusicSetAPI(_musicData.id);
                     _mode;
                     Tween24.serial(Connector.createTween(true,this,api),Tween24.func(_setPortBGM,_musicData.bgmId),Tween24.func(finalize)).onComplete(function():void
                     {
                        BGMManager.JUKEBOX_SOUND = null;
                        _mode = 2;
                     }).play();
                  }
               }
               else
               {
                  finalize();
               }
            }
            else
            {
               finalize();
            }
         }
         else
         {
            _view.backBtn.removeEventListener("click",_handleClickButton);
            _view.inBtn.removeEventListener("click",_handleClickButton);
            _api = new UseFCoinAPI(_musicData.id);
            Tween24.serial(Connector.createTween(true,this,_api)).onComplete(thirdFrame).play();
         }
      }
   }
}
