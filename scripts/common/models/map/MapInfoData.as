package common.models.map
{
   import flash.utils.Dictionary;
   import common.util.Util;
   
   public class MapInfoData extends Object
   {
      
      public function MapInfoData(param1:Object)
      {
         super();
         _o = param1;
      }
      
      public static const OPERATION_NOSELECT:int = 0;
      
      public static const OPERATION_HEI:int = 1;
      
      public static const OPERATION_OTSU:int = 2;
      
      public static const OPERATION_KOU:int = 3;
      
      private var _o:Object;
      
      private var _cellDic:Dictionary;
      
      private var _cellDicByNo:Dictionary;
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_maparea_id",-1);
      }
      
      public function get infoID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get infoNo() : int
      {
         return Util.getInt(_o,"api_no",-1);
      }
      
      public function get mapName() : String
      {
         return Util.getString(_o,"api_name");
      }
      
      public function get operationName() : String
      {
         return Util.getString(_o,"api_opetext");
      }
      
      public function get detailText() : String
      {
         return Util.formatNewLine(Util.getString(_o,"api_infotext"));
      }
      
      public function get gettableItems() : Array
      {
         return Util.getArray(_o,"api_item",[0,0,0,0]);
      }
      
      public function setMasterData(param1:Array) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _cellDic = new Dictionary();
         _cellDicByNo = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new MapCellData(param1[_loc3_]);
            if(_loc2_.areaID == areaID && _loc2_.infoNo == infoNo)
            {
               _cellDic[_loc2_.cellID] = _loc2_;
               _cellDicByNo[_loc2_.cellNo] = _loc2_;
            }
            _loc3_++;
         }
      }
      
      public function setMemberData(param1:Object) : void
      {
         _o["member_data"] = param1;
      }
      
      public function getCellDataByNo(param1:int) : MapCellData
      {
         if(_cellDicByNo.hasOwnProperty(param1))
         {
            return _cellDicByNo[param1];
         }
         return null;
      }
      
      public function getCellData(param1:int) : MapCellData
      {
         if(_cellDic.hasOwnProperty(param1))
         {
            return _cellDic[param1];
         }
         return null;
      }
      
      public function hasCellData(param1:int) : Boolean
      {
         return _cellDic.hasOwnProperty(param1);
      }
      
      public function getExBossData() : Object
      {
         if(isExBoss())
         {
            return Util.getObject(_o,"api_exboss",{
               "api_required_defeat_count":getExBossDefeatCountRequired(),
               "api_defeat_count":getExBossDefeatCount()
            });
         }
         return {};
      }
      
      public function getExBossDefeatCountRequired() : int
      {
         var _loc1_:int = Util.getInt(_o,"api_required_defeat_count");
         return isNaN(_loc1_)?0:_loc1_;
      }
      
      public function approveDeckType() : int
      {
         var _loc1_:Array = Util.getArray(_o,"api_sally_flag",[0,0]);
         if(_loc1_[0] == 0 && _loc1_[1] == 1)
         {
            return 1;
         }
         if(_loc1_[0] == 0 && _loc1_[1] == 2)
         {
            return 2;
         }
         if(_loc1_[0] == 0 && _loc1_[1] == 3)
         {
            return 3;
         }
         return 0;
      }
      
      public function isExBoss() : Boolean
      {
         return Util.getInt(_userData,"api_exboss_flag",0) == 1;
      }
      
      public function getExBossDefeatCount() : int
      {
         return Util.getInt(_userData,"api_defeat_count");
      }
      
      public function isClear() : Boolean
      {
         return Util.getInt(_userData,"api_cleared") == 1;
      }
      
      public function isActive() : Boolean
      {
         return !(Util.getObject(_o,"member_data",null) == null);
      }
      
      private function get _eventmapState() : int
      {
         return Util.getInt(_eventmapObj,"api_state",0);
      }
      
      public function isEventMap() : Boolean
      {
         return _eventmapState == 1;
      }
      
      public function getEventMapHPMax() : int
      {
         return Util.getInt(_eventmapObj,"api_max_maphp",0);
      }
      
      public function getEventMapHPNow() : int
      {
         return Util.getInt(_eventmapObj,"api_now_maphp",0);
      }
      
      public function getEventMapSelectedOperation() : int
      {
         return Util.getInt(_eventmapObj,"api_selected_rank",0);
      }
      
      private function get _userData() : Object
      {
         return Util.getObject(_o,"member_data",{});
      }
      
      private function get _eventmapObj() : Object
      {
         return Util.getObject(_userData,"api_eventmap",{});
      }
      
      public function __updateEventMapHp__(param1:int, param2:int) : void
      {
         if(isEventMap())
         {
            _userData["api_eventmap"]["api_now_maphp"] = param1;
            _userData["api_eventmap"]["api_max_maphp"] = param2;
         }
      }
      
      public function __updateEventMapOperation__(param1:int) : void
      {
         if(isEventMap())
         {
            if(param1 != getEventMapSelectedOperation())
            {
               __updateEventMapHp__(getEventMapHPMax(),getEventMapHPMax());
            }
            _userData["api_eventmap"]["api_selected_rank"] = param1;
         }
      }
   }
}
