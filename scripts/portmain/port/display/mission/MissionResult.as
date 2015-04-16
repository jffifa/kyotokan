package port.display.mission
{
   import res.port.MCMissionResult;
   import dto.MissionDTO;
   import port.models.dto.MissionResultDTO;
   import a24.tween.Tween24;
   import common.display.ClickAreaLayer;
   import common.btns.NextGearButton;
   import common.util.MCUtil;
   import vo.UserShipData;
   import manager.resource.IShipAttacher;
   import flash.events.IEventDispatcher;
   import common.util.Util;
   import flash.geom.Point;
   import manager.resource.IUseitemAttacher;
   import vo.UserData;
   
   public class MissionResult extends MCMissionResult
   {
      
      public function MissionResult(param1:MissionDTO, param2:MissionResultDTO)
      {
         super();
         _mDTO = param1;
         _mResultDTO = param2;
         stop();
         missionNameText.visible = false;
         missionNameText.text = param2.missionName;
         var _loc3_:UserData = DataFacade.getUserData();
         deckInfoMC.userNameText.text = _loc3_.getNickName();
         deckInfoMC.levelText.text = param2.level;
         deckInfoMC.rankText.text = "[" + _loc3_.getRankName() + "]";
         deckInfoMC.fleetNameText.text = param1.deckName;
         _deckInfo = new DeckInfo(deckInfoMC);
         resultLabelMC.stop();
         resultLabelMC.visible = false;
         if(_mResultDTO.resultFlg == 2)
         {
            resultLabelMC.removeChild(resultLabelMC.successLabelMC);
            resultLabelMC.removeChild(resultLabelMC.failedLabelMC);
         }
         else if(_mResultDTO.resultFlg == 1)
         {
            resultLabelMC.removeChild(resultLabelMC.failedLabelMC);
            resultLabelMC.removeChild(resultLabelMC.success2LabelMC);
         }
         else
         {
            resultLabelMC.removeChild(resultLabelMC.successLabelMC);
            resultLabelMC.removeChild(resultLabelMC.success2LabelMC);
         }
         
      }
      
      private var _mDTO:MissionDTO;
      
      private var _mResultDTO:MissionResultDTO;
      
      private var _deckInfo:DeckInfo;
      
      public function getTween() : Tween24
      {
         var clickArea:ClickAreaLayer = new ClickAreaLayer();
         clickArea.buttonMode = true;
         var nextBtn:NextGearButton = new NextGearButton(763,444);
         return Tween24.serial(_deckInfo.getTweenInitialize(_mResultDTO),MCUtil.frameTween(this,1,13),Tween24.func(function():void
         {
            missionNameText.visible = true;
         }),_deckInfo.getTween(),MCUtil.frameTween(this,13,20),Tween24.visible(true,resultLabelMC),MCUtil.frameTween(resultLabelMC,1,resultLabelMC.totalFrames),Tween24.addChild(this,nextBtn,clickArea),Tween24.waitEvent(clickArea,"click"),Tween24.removeChild(clickArea,nextBtn),MCUtil.frameTween(this,20,21),Tween24.func(_createEndView),Tween24.addChild(this,clickArea),Tween24.waitEvent(clickArea,"click"),Tween24.tween(this,0.3).alpha(0));
      }
      
      private function _createEndView() : void
      {
         var nextBtn:NextGearButton = new NextGearButton(763,444);
         addChild(nextBtn);
         _showBonusItem();
         resultBox.totalExpText.text = _mResultDTO.totalExp;
         resultBox.fuelText.text = _mResultDTO.rewardFuel;
         resultBox.ammoText.text = _mResultDTO.rewardAmmo;
         resultBox.steelText.text = _mResultDTO.rewardSteel;
         resultBox.bauxText.text = _mResultDTO.rewardBaux;
         var flagShip_shipID:int = _mResultDTO.shipIDs[0];
         var shipData:UserShipData = DataFacade.getUserDeckData().getShipData(flagShip_shipID);
         var charaID:int = shipData.getCharaID();
         var condition:int = shipData.getCondition();
         var attacher:IShipAttacher = AppFacade.createShipAttacher();
         attacher.stackFull(charaID,shipFull,condition);
         Tween24.serial(Tween24.funcAndWaitEvent(attacher as IEventDispatcher,"complete",attacher.load),Tween24.func(function():void
         {
            Util;
            var _loc1_:Point = DataFacade.getStartData().getOffsetAtCenterShip(charaID,Util.isDamaged(condition));
            shipFull.x = shipFull.x + (-256 + _loc1_.x);
            shipFull.y = shipFull.y + (-256 + _loc1_.y);
         })).play();
      }
      
      private function _showBonusItem() : void
      {
         var _loc1_:IUseitemAttacher = AppFacade.createUseitemAttacher();
         resultBox.getsItem1.removeChildren();
         if(_mResultDTO.hasRewardItem1())
         {
            resultBox.getsName1.text = _mResultDTO.item1Name;
            resultBox.getsNum1.text = "x" + _mResultDTO.item1Count;
            _loc1_.stackIcon(_mResultDTO.item1ID,resultBox.getsItem1);
         }
         resultBox.getsItem2.removeChildren();
         if(_mResultDTO.hasRewardItem2())
         {
            resultBox.getsName2.text = _mResultDTO.item2Name;
            resultBox.getsNum2.text = "x" + _mResultDTO.item2Count;
            _loc1_.stackIcon(_mResultDTO.item2ID,resultBox.getsItem2);
         }
         _loc1_.load();
      }
   }
}
