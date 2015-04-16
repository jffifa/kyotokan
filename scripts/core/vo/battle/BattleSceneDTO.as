package vo.battle
{
   import scene.ISceneDTO;
   import common.util.Util;
   
   public class BattleSceneDTO extends Object implements ISceneDTO
   {
      
      public function BattleSceneDTO(param1:Object = null)
      {
         _obj = {};
         super();
         _obj = param1?param1:{};
      }
      
      private var _obj:Object;
      
      public function get deckID() : int
      {
         return Util.getInt(_obj,"deckID");
      }
      
      public function get formationID() : int
      {
         return Util.getInt(_obj,"formationID");
      }
      
      public function get enemyID() : int
      {
         return Util.getInt(_obj,"enemyID",-1);
      }
      
      public function get medalNum() : int
      {
         return Util.getInt(_obj,"medalNum");
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_obj,"areaID");
      }
      
      public function get mapNo() : int
      {
         return Util.getInt(_obj,"mapNo");
      }
      
      public function get mapID() : int
      {
         return Util.getInt(_obj,"mapID");
      }
      
      private function get _cellColor() : int
      {
         return Util.getInt(_obj,"cellColor");
      }
      
      private function get _cellEventFlg() : int
      {
         return Util.getInt(_obj,"cellEventFlg",-1);
      }
      
      private function get _cellEventKind() : int
      {
         return Util.getInt(_obj,"cellEventKind",-1);
      }
      
      public function hasNext() : Boolean
      {
         return Util.getObject(_obj,"hasNext") as Boolean;
      }
      
      public function get marchingType() : int
      {
         return Util.getInt(_obj,"marchingType");
      }
      
      public function isPractice() : Boolean
      {
         return !(enemyID == -1);
      }
      
      public function isNightOnlyBattle() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventKind == 2;
         }
         return _cellColor == 6;
      }
      
      public function isNightDayBattle() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventKind == 3;
         }
         return _cellColor == 7 || _cellColor == 8;
      }
      
      public function isAerialWarfare() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         return _cellEventKind == 4;
      }
      
      public function isBossMap() : Boolean
      {
         if(isPractice())
         {
            return false;
         }
         if(_cellEventFlg > 0)
         {
            return _cellEventFlg == 5;
         }
         return _cellColor == 5 || _cellColor == 8;
      }
      
      public function isCombinedBattle() : Boolean
      {
         return !(shipsF2 == null) && shipsF2 is Array && shipsF2.length == 6;
      }
      
      public function getCombinedType() : int
      {
         return DataFacade.getUserDeckData().getCombinedType(deckID);
      }
      
      public function get exBossDefeat() : int
      {
         return Util.getInt(exBossObj,"api_defeat_count",exBossDefeatRequest);
      }
      
      public function get exBossDefeatRequest() : int
      {
         return Util.getInt(exBossObj,"api_required_defeat_count",0);
      }
      
      private function get exBossObj() : Object
      {
         return Util.getObject(_obj,"exboss",{});
      }
      
      public function get eventMapHPMax() : int
      {
         return Util.getInt(eventMapObj,"api_max_maphp",0);
      }
      
      public function get mapHPNow() : int
      {
         return Util.getInt(eventMapObj,"api_now_maphp",0);
      }
      
      public function get mapHPDmg() : int
      {
         return Util.getInt(eventMapObj,"api_dmg",0);
      }
      
      private function get eventMapObj() : Object
      {
         return Util.getObject(_obj,"eventmap",{});
      }
      
      public function set shipsF(param1:Array) : void
      {
         _obj["ships_f"] = param1;
      }
      
      public function get shipsF() : Array
      {
         return Util.getArray(_obj,"ships_f",[]);
      }
      
      public function set shipsE(param1:Array) : void
      {
         _obj["ships_e"] = param1;
      }
      
      public function get shipsE() : Array
      {
         return Util.getArray(_obj,"ships_e",[]);
      }
      
      public function set shipsF2(param1:Array) : void
      {
         _obj["ships_f_2"] = param1;
      }
      
      public function get shipsF2() : Array
      {
         return Util.getArray(_obj,"ships_f_2",[]);
      }
      
      public function setEscapeCandidate(param1:Array, param2:Array) : void
      {
         _obj["escape_idx"] = param1;
         _obj["tow_idx"] = param2;
      }
      
      public function hasEscapeCandidate() : Boolean
      {
         return escape_cadidate.length > 0 && tow_cadidate.length > 0;
      }
      
      public function get escape_cadidate() : Array
      {
         return Util.getArray(_obj,"escape_idx",[]);
      }
      
      public function get tow_cadidate() : Array
      {
         return Util.getArray(_obj,"tow_idx",[]);
      }
      
      public function createObject() : Object
      {
         return _obj;
      }
      
      public function setDataForBattle(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Boolean, param10:int, param11:Object, param12:Object) : void
      {
         _obj = {
            "deckID":param1,
            "formationID":param2,
            "areaID":param3,
            "mapNo":param4,
            "mapID":param5,
            "cellColor":param6,
            "cellEventFlg":param7,
            "cellEventKind":param8,
            "hasNext":param9,
            "marchingType":param10,
            "eventmap":param11,
            "exboss":param12
         };
      }
      
      public function setDataForPractice(param1:int, param2:int, param3:int, param4:int) : void
      {
         _obj = {
            "deckID":param1,
            "formationID":param2,
            "enemyID":param3,
            "medalNum":param4
         };
      }
      
      public function setEmulateData(param1:String, param2:Object) : void
      {
         var _loc3_:Object = Util.getObject(_obj,"emulate_data",{});
         _loc3_[param1] = param2;
         _obj["emulate_data"] = _loc3_;
      }
      
      public function getEmulateData(param1:String) : Object
      {
         var _loc2_:Object = _getDebugAPIData();
         return Util.getObject(_loc2_,param1,null);
      }
      
      private function _getDebugAPIData() : Object
      {
         return Util.getObject(_obj,"emulate_data",{});
      }
   }
}
