package a24.tween.core.updaters
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class ObjectUpdater extends AbstractUpdater
   {
      
      public function ObjectUpdater(param1:*)
      {
         super();
         this._target = param1;
         this._param = {};
         this._startParam = {};
         this._deltaParam = {};
         this._key = [];
      }
      
      private var _target;
      
      private var _param:Object;
      
      private var _$param:Object;
      
      private var _$$param:Object;
      
      private var _startParam:Object;
      
      private var _deltaParam:Object;
      
      private var _key:Array;
      
      private var _tweenKey:Array;
      
      public function setProp(param1:Object) : void
      {
         var _loc2_:String = null;
         this._param = param1;
         for(_loc2_ in param1)
         {
            if(_loc2_.slice(0,2) == "$$")
            {
               _loc2_ = _loc2_.substr(2,_loc2_.length);
               this._$$param = this._$$param || {};
               this._$$param[_loc2_] = this._param["$$" + _loc2_];
               delete this._param["$$" + _loc2_];
               true;
            }
            else if(_loc2_.slice(0,1) == "$")
            {
               _loc2_ = _loc2_.substr(1,_loc2_.length);
               this._$param = this._$param || {};
               this._param[_loc2_] = this._target[_loc2_] + param1["$" + _loc2_];
               this._$param[_loc2_] = this._param["$" + _loc2_];
               delete this._param["$" + _loc2_];
               true;
            }
            else
            {
               this._param[_loc2_] = param1[_loc2_];
            }
            
            this._key.push(_loc2_);
         }
      }
      
      public function addProp(param1:String, param2:*) : void
      {
         var _loc3_:String = param1;
         if(_loc3_.slice(0,2) == "$$")
         {
            _loc3_ = _loc3_.substr(2,_loc3_.length);
            this._$$param = this._$$param || {};
            this._$$param[_loc3_] = param2;
         }
         else if(_loc3_.slice(0,1) == "$")
         {
            _loc3_ = _loc3_.substr(1,_loc3_.length);
            this._$param = this._$param || {};
            this._param[_loc3_] = this._target[_loc3_] + param2;
            this._$param[_loc3_] = param2;
         }
         else
         {
            this._param[_loc3_] = param2;
         }
         
         this._key.push(_loc3_);
      }
      
      public function init() : AbstractUpdater
      {
         var _loc1_:String = null;
         this._tweenKey = this._key.concat();
         if(this._$$param)
         {
            for(_loc1_ in this._$$param)
            {
               this._param[_loc1_] = this._target[_loc1_] + this._$$param[_loc1_];
            }
         }
         for each(_loc1_ in this._key)
         {
            this._startParam[_loc1_] = this._target[_loc1_];
            this._deltaParam[_loc1_] = this._param[_loc1_] - this._target[_loc1_];
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:String = null;
         for each(_loc2_ in this._tweenKey)
         {
            this._target[_loc2_] = this._startParam[_loc2_] + this._deltaParam[_loc2_] * param1;
         }
         return this;
      }
      
      override public function complete() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in this._tweenKey)
         {
            this._target[_loc1_] = this._param[_loc1_];
         }
      }
      
      override public function overwrite(param1:AbstractUpdater) : void
      {
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc2_:ObjectUpdater = param1 as ObjectUpdater;
         var _loc3_:Array = _loc2_._tweenKey;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this._tweenKey.indexOf(_loc4_);
            if(_loc5_ > -1)
            {
               this._tweenKey.splice(_loc5_,1);
            }
         }
      }
      
      public function clone() : ObjectUpdater
      {
         var _loc1_:ObjectUpdater = new ObjectUpdater(this._target);
         _loc1_.setProp(this._param);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " param:" + this._param;
      }
   }
}
