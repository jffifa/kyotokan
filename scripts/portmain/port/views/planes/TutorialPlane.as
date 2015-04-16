package port.views.planes
{
   import res.port.MCTutorial;
   import flash.events.MouseEvent;
   import a24.tween.Tween24;
   import connection.Connector;
   import connection.api_req_member.UpdateTutorialProgressAPI;
   import flash.display.DisplayObjectContainer;
   import common.display.DisplayUtil;
   import common.util.SoundUtil;
   
   public class TutorialPlane extends MCTutorial
   {
      
      public function TutorialPlane(param1:DisplayObjectContainer)
      {
         var _loc3_:* = 0;
         super();
         var _loc2_:int = DataFacade.getUserData().getTutorialProgress();
         if(_loc2_ < 100)
         {
            if(_loc2_ >= 50)
            {
               gotoAndStop(6);
               DisplayUtil.setButtonMode(btnClose,_handleClickCloseBtn);
               _loc3_ = DataFacade.getUserDeckData().getFlagShipData(1).getCharaID();
               SoundUtil.playVoice(_loc3_,26);
            }
            else
            {
               if(_loc2_ < 10)
               {
                  gotoAndStop(1);
               }
               else if(_loc2_ < 20)
               {
                  gotoAndStop(2);
               }
               else if(_loc2_ < 30)
               {
                  gotoAndStop(3);
               }
               else if(_loc2_ < 40)
               {
                  gotoAndStop(4);
               }
               else
               {
                  gotoAndStop(5);
               }
               
               
               
               DisplayUtil.setButtonMode(plane,_handleClickPlane);
            }
            Tween24.addChild(param1,this).play();
         }
      }
      
      private function _handleClickPlane(param1:MouseEvent) : void
      {
         Tween24.serial(Tween24.tween(this,0.3).alpha(0),Tween24.removeChild(this)).play();
      }
      
      private function _handleClickCloseBtn(param1:MouseEvent) : void
      {
         Tween24.serial(Tween24.tween(this,0.3).alpha(0),Tween24.removeChild(this),Connector.createTween(true,this,new UpdateTutorialProgressAPI(100))).play();
      }
   }
}
