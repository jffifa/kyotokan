package port.views.planes
{
   import flash.display.Sprite;
   import common.display.ClickAreaLayer;
   import res.port.MCMissionInfo;
   import dto.MissionDTO;
   import port.models.dto.MissionResultDTO;
   import a24.tween.Tween24;
   import connection.Connector;
   import connection.api_req_mission.ResultAPI;
   import connection.api_port.PortAPI;
   import connection.api_get_member.UseItemAPI;
   import common.cutins.MissionCutin;
   import common.display.ShutterView;
   import port.display.mission.MissionResult;
   import flash.display.DisplayObjectContainer;
   
   public class MissionResultPlane extends Sprite
   {
      
      public function MissionResultPlane(param1:DisplayObjectContainer)
      {
         var _loc2_:* = null;
         _bgLayer = new ClickAreaLayer(0.1);
         _contentLayer = new Sprite();
         _info = new MCMissionInfo();
         super();
         if(DataFacade.getUserDeckData().missionManager.isMissionComplete())
         {
            _loc2_ = DataFacade.getUserDeckData().missionManager.shiftCompleteData();
            param1.addChild(this);
            addChild(_bgLayer);
            _info.buttonMode = true;
            addChild(_contentLayer);
            _wait(_loc2_);
         }
      }
      
      private var _bgLayer:ClickAreaLayer;
      
      private var _contentLayer:Sprite;
      
      private var _info:MCMissionInfo;
      
      private function _wait(param1:MissionDTO) : void
      {
         _contentLayer.removeChildren();
         _contentLayer.addChild(_info);
         var _loc2_:MissionResultDTO = new MissionResultDTO();
         Tween24.serial(Tween24.waitEvent(this,"click"),Connector.createTween(true,this,new ResultAPI(param1.deckID,_loc2_),PortAPI,UseItemAPI)).onComplete(_showMissionCutin,param1,_loc2_).play();
      }
      
      private function _showMissionCutin(param1:MissionDTO, param2:MissionResultDTO) : void
      {
         _contentLayer.removeChildren();
         var _loc3_:MissionCutin = new MissionCutin();
         _contentLayer.addChild(_loc3_);
         _loc3_.getTween(false,param1.getDeckShipsID()).onComplete(_showMissionResult,param1,param2).play();
      }
      
      private function _showMissionResult(param1:MissionDTO, param2:MissionResultDTO) : void
      {
         _contentLayer.removeChildren();
         var _loc4_:ShutterView = new ShutterView();
         _loc4_.setDark();
         _loc4_.close(0);
         _contentLayer.addChild(_loc4_);
         var _loc3_:MissionResult = new MissionResult(param1,param2);
         _contentLayer.addChild(_loc3_);
         _loc3_.getTween().onComplete(_next).play();
      }
      
      private function _next() : void
      {
         var _loc1_:* = null;
         _contentLayer.removeChildren();
         if(DataFacade.getUserDeckData().missionManager.isMissionComplete())
         {
            _loc1_ = DataFacade.getUserDeckData().missionManager.shiftCompleteData();
            _wait(_loc1_);
         }
         else
         {
            Tween24.removeChild(this).play();
         }
      }
   }
}
