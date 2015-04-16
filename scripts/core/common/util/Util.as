package common.util
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import common.display.LayoutUtil;
   
   public class Util extends Object
   {
      
      public function Util()
      {
         super();
      }
      
      public static function getInt(param1:Object, param2:String, param3:int = 0) : int
      {
         return _getProp(param1,param2,param3);
      }
      
      public static function getNumber(param1:Object, param2:String, param3:Number = 0.0) : Number
      {
         return _getProp(param1,param2,param3);
      }
      
      public static function getString(param1:Object, param2:String, param3:String = "") : String
      {
         var _loc4_:String = _getProp(param1,param2,param3);
         if(_loc4_ == null && !(param3 == null))
         {
            _loc4_ = param3;
         }
         return _loc4_;
      }
      
      public static function getBooleanFromInt(param1:Object, param2:String, param3:Boolean = false) : Boolean
      {
         return getInt(param1,param2,param3?1:0.0) == 1;
      }
      
      public static function getArray(param1:Object, param2:String, param3:Array = null) : Array
      {
         var _loc4_:Array = _getProp(param1,param2,param3);
         return _loc4_?_loc4_:param3;
      }
      
      public static function getObject(param1:Object, param2:String, param3:Object = null) : Object
      {
         var _loc4_:Object = _getProp(param1,param2,param3);
         if(_loc4_ == null && !(param3 == null))
         {
            _loc4_ = param3;
         }
         return _loc4_;
      }
      
      private static function _getProp(param1:Object, param2:String, param3:*) : *
      {
         if(param1 && param1.hasOwnProperty(param2))
         {
            return param1[param2];
         }
         return param3;
      }
      
      public static function overWrite(param1:Object, param2:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = 0;
         var _loc7_:* = 0;
         var _loc6_:* = param2;
         for(var _loc3_ in param2)
         {
            _loc5_++;
            _loc4_ = param2[_loc3_];
            if(_loc4_ is Boolean || _loc4_ is int || _loc4_ is Number || _loc4_ is String || _loc4_ is uint)
            {
               param1[_loc3_] = _loc4_;
            }
            else if(_loc4_ is Array)
            {
               param1[_loc3_] = _loc4_;
            }
            else if(_loc4_.constructor == Object)
            {
               if(param1[_loc3_] == null)
               {
                  param1[_loc3_] = {};
               }
               Util.overWrite(param1[_loc3_],param2[_loc3_]);
            }
            else
            {
               param1[_loc3_] = _loc4_;
            }
            
            
         }
      }
      
      public static function toArrayFromVector(param1:*) : Array
      {
         var _loc3_:* = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function createImageAsset(param1:Class) : Sprite
      {
         var _loc3_:Bitmap = new param1();
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      public static function createImageAssetWithCentering(param1:Class) : Sprite
      {
         var _loc2_:Sprite = createImageAsset(param1);
         LayoutUtil.middleCenter(_loc2_.getChildAt(0));
         return _loc2_;
      }
      
      public static function createImageResource(param1:Class) : Sprite
      {
         var _loc3_:Bitmap = new Bitmap(new param1());
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      public static function createImageResourceWithCentering(param1:Class) : Sprite
      {
         var _loc2_:Sprite = createImageResource(param1);
         LayoutUtil.middleCenter(_loc2_.getChildAt(0));
         return _loc2_;
      }
      
      public static function getWorldID(param1:String) : String
      {
         var _loc3_:* = 0;
         var param1:String = param1.replace(new RegExp(".*\\/(.+?)\\/.*"),"$1");
         var _loc2_:Array = param1.split(".");
         if(_loc2_ is Array)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(!isNaN(_loc2_[_loc3_]))
               {
                  _loc2_[_loc3_] = MathUtil.digit3(parseInt(_loc2_[_loc3_]));
               }
               _loc3_++;
            }
            return _loc2_.join("_");
         }
         return param1;
      }
      
      public static function getCondition(param1:int, param2:int) : int
      {
         var _loc3_:Number = param1 * 100 / param2;
         if(_loc3_ <= 0)
         {
            return 0;
         }
         if(_loc3_ <= 25)
         {
            return 25;
         }
         if(_loc3_ <= 50)
         {
            return 50;
         }
         if(_loc3_ <= 75)
         {
            return 75;
         }
         return 100;
      }
      
      public static function isTaiha(param1:int, param2:int) : Boolean
      {
         return getCondition(param1,param2) == 25;
      }
      
      public static function isDamaged(param1:int) : Boolean
      {
         return param1 <= 50;
      }
      
      public static function msecToTimeString(param1:Number) : String
      {
         var _loc5_:Number = param1 / 1000;
         var _loc3_:Number = _loc5_ % 60;
         _loc5_ = Math.floor(_loc5_ / 60);
         var _loc2_:Number = _loc5_ % 60;
         var _loc4_:Number = Math.floor(_loc5_ / 60);
         if(_loc4_ > 99)
         {
            return "100:00:00 >";
         }
         return MathUtil.digit2(_loc4_) + ":" + MathUtil.digit2(_loc2_) + ":" + MathUtil.digit2(_loc3_);
      }
      
      public static function getSpeedLevel(param1:int) : int
      {
         var _loc2_:* = 1;
         if(param1 >= 10)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      public static function isMarriaged(param1:int) : Boolean
      {
         return param1 > 99;
      }
      
      public static function formatNewLine(param1:String) : String
      {
         var _loc2_:Array = param1.split("<br>");
         return _loc2_.join("\n");
      }
      
      public static function getDeckFrame(param1:int) : int
      {
         var _loc2_:* = 1;
      }
      
      public static function f(param1:int, param2:int = 0) : String
      {
         var _loc5_:Object = cO(0);
         var _loc4_:* = arguments;
         _loc5_[{}] = 1;
         _loc5_[_loc4_] = _loc5_[_loc5_[_loc5_]][_loc5_[_loc5_[_loc5_] >> _loc5_[_loc5_]][_loc5_[_loc5_] >> _loc5_[_loc5_]](_loc5_[_loc5_],_loc5_[_loc5_])];
         return _loc5_[_loc5_[_loc5_]][_loc5_[_loc4_]([])](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])](_loc4_[_loc5_[_loc4_]([])]),_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc5_]][_loc5_[_loc4_]([])](_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](!{})[_loc5_[_loc4_]([])],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](!!{})[_loc5_[_loc5_]],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_)[_loc5_[_loc5_]],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc4_]([])])[_loc5_[_loc4_]([][{}])],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]))])[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc4_](!{}),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]))],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_]])[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])](_loc5_[_loc4_](!{}),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]))],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](!{})[_loc5_[_loc5_]],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](!!{})[_loc5_[_loc5_]],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]))])[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc4_](!!{}),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_](!!{})](_loc5_[_loc4_](_loc5_),_loc5_[_loc4_](!!{})))],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_]](_loc5_)[_loc5_[_loc5_]],_loc5_[_loc5_[_loc5_]][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]))](_loc5_[_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])]([][{}]),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_]),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])))](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_](!!{})](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])](_loc4_[_loc5_[_loc4_]([])],_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](s(_loc4_[_loc5_[_loc4_]([])]),_loc5_[_loc5_])),_loc4_[_loc5_[_loc5_]]?_loc4_[_loc5_[_loc5_]]:_loc5_[_loc4_]([])),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc4_](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])]),_loc5_[_loc4_](!!{}))),_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])](_loc5_[_loc5_],_loc5_[_loc5_])](_loc5_[_loc4_](_loc5_[_loc5_[_loc4_]([])][_loc5_[_loc4_]([])]),_loc5_[_loc4_](!!{})),_loc5_[_loc4_]([][{}])))));
      }
      
      public static function s(param1:int) : int
      {
         var _loc4_:Object = cO(0);
         var _loc3_:* = arguments;
         _loc4_[{}] = 1;
         _loc4_[_loc3_] = _loc4_[_loc4_[_loc4_]][_loc4_[_loc4_[_loc4_] >> _loc4_[_loc4_]][_loc4_[_loc4_] >> _loc4_[_loc4_]](_loc4_[_loc4_],_loc4_[_loc4_])];
         _loc4_[{}] = _loc4_[_loc4_[_loc3_]([])][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc4_],_loc4_[_loc4_])](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc4_],_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc4_],_loc4_[_loc4_]))][_loc4_[_loc3_]([])](_loc4_[_loc4_[_loc4_]][_loc4_[_loc4_]](_loc3_[_loc4_[_loc3_]([])])),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc4_],_loc4_[_loc4_]));
         return _loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_],_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))) < _loc4_[_loc4_[_loc3_]([])][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc3_](!{}))?_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_],_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))):_loc3_[_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc3_]([])](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))],_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))],_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))],_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))],_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc3_]([][{}]),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))],_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))][_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))](_loc4_[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))][_loc4_[_loc3_]([])])[_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])](_loc4_[_loc3_]([][{}]),_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{})))])](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!{})](_loc4_[_loc4_],_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_](!!{})](_loc4_[_loc3_](_loc4_[_loc4_[_loc3_]([])][_loc4_[_loc3_]([])]),_loc4_[_loc3_](!{}))));
      }
      
      public static function cO(param1:int = 0) : Object
      {
         k = param1;
         if(!(k))
         {
            return {
               0:[function(param1:int, param2:int):int
               {
                  return param1 + param2;
               },function(param1:int, param2:int):int
               {
                  return param1 - param2;
               },function(param1:int, param2:int):int
               {
                  return param1 * param2;
               },function(param1:int, param2:int):int
               {
                  return Math.round(param1 / param2);
               },function(param1:int, param2:int):int
               {
                  return param1 % param2;
               },function(param1:int, param2:int):int
               {
                  return Math.floor(param1 / param2);
               }],
               1:[function(... rest):String
               {
                  return rest.join("");
               },function(param1:String):Array
               {
                  return param1.split("");
               },function(param1:*):int
               {
                  return (param1).length;
               },function(param1:String, param2:int, param3:int):String
               {
                  return param1.substr(param2,param3);
               }],
               2:[Number,Math,String,Class,RegExp,Array,int],
               3:[function(param1:Array):int
               {
                  var _loc3_:* = 0;
                  var _loc2_:* = 0;
                  _loc3_ = 0;
                  while(_loc3_ < param1.length)
                  {
                     _loc2_ = _loc2_ + (param1[_loc3_]);
                     _loc3_++;
                  }
                  return _loc2_;
               }]
            };
         }
         return {};
      }
   }
}
