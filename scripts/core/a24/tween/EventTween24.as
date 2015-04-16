package a24.tween
{
   import flash.utils.Dictionary;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import a24.util.Util24;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import a24.tween.events.Tween24Event;
   
   public class EventTween24 extends Object
   {
      
      public function EventTween24(param1:*)
      {
         super();
         _eventTween24ByTarget = _eventTween24ByTarget || new Dictionary();
         this._target = param1;
         _eventTween24ByTarget[this._target] = this;
         this._enabled = true;
         this._mouseEventTweenType = TYPE_NORMAL;
         this._duplicateMouseTween = true;
         if(this._target is DisplayObject)
         {
            if(!this._target.stage)
            {
               this._target.addEventListener(Event.ADDED_TO_STAGE,this._onAdded);
            }
            else
            {
               this._target.addEventListener(Event.REMOVED_FROM_STAGE,this._onRemoved);
            }
         }
      }
      
      public static const TYPE_NORMAL:String = "normal";
      
      public static const TYPE_STOP:String = "stop";
      
      public static const TYPE_SERIAL:String = "serial";
      
      public static const TYPE_JUMP:String = "jump";
      
      private static var _eventTween24ByTarget:Dictionary;
      
      public static function onRollOver(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.ROLL_OVER);
         return _loc3_;
      }
      
      public static function onRollOut(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.ROLL_OUT);
         return _loc3_;
      }
      
      public static function onMouseOver(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.MOUSE_OVER);
         return _loc3_;
      }
      
      public static function onMouseOut(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.MOUSE_OUT);
         return _loc3_;
      }
      
      public static function onMouseDown(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.MOUSE_DOWN);
         return _loc3_;
      }
      
      public static function onMouseUp(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.MOUSE_UP);
         return _loc3_;
      }
      
      public static function onClick(param1:InteractiveObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setMouseEvent(_loc3_,MouseEvent.CLICK);
         return _loc3_;
      }
      
      public static function onClickAndGetURL(param1:InteractiveObject, param2:String, param3:String = "_self") : Tween24
      {
         var _loc4_:Tween24 = Tween24.getURL(param2,param3);
         getInstance(param1).setMouseEvent(_loc4_,MouseEvent.CLICK);
         return _loc4_;
      }
      
      public static function onAddedToStage(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._addedToStageTween = _loc3_;
         return _loc3_;
      }
      
      public static function onRemoveFromStage(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._removeFromStageTween = _loc3_;
         return _loc3_;
      }
      
      public static function syncAddChild(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._syncAddChildTween = _loc3_;
         return _loc3_;
      }
      
      public static function syncRemoveChild(param1:DisplayObject, ... rest) : Tween24
      {
         var _loc3_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1)._syncRemoveChildTween = _loc3_;
         return _loc3_;
      }
      
      public static function onEvent(param1:Object, param2:String, ... rest) : Tween24
      {
         var _loc4_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setEvent(param2,_loc4_);
         return _loc4_;
      }
      
      public static function onEventOnce(param1:Object, param2:String, ... rest) : Tween24
      {
         var _loc4_:Tween24 = Tween24.serial.apply(Tween24.serial,rest);
         getInstance(param1).setEvent(param2,_loc4_,true);
         return _loc4_;
      }
      
      public static function removeRollOverTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.ROLL_OVER);
      }
      
      public static function removeRollOutTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.ROLL_OUT);
      }
      
      public static function removeMouseOverTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.MOUSE_OVER);
      }
      
      public static function removeMouseOutTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.MOUSE_OUT);
      }
      
      public static function removeMouseDownTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.MOUSE_DOWN);
      }
      
      public static function removeMouseUpTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.MOUSE_UP);
      }
      
      public static function removeClickTween(param1:Object) : void
      {
         getInstance(param1).removeMouseEvent(MouseEvent.CLICK);
      }
      
      public static function removeEventTween(param1:Object, param2:String) : void
      {
         getInstance(param1).setEvent(param2);
      }
      
      public static function enabled(param1:Boolean, ... rest) : void
      {
         var _loc3_:EventTween24 = null;
         var _loc4_:Object = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc4_ in rest)
         {
            _loc3_ = getInstance(_loc4_) || new EventTween24(_loc4_);
            _loc3_.enabled = param1;
            _loc4_.buttonMode = param1;
         }
      }
      
      public static function setMouseEventTweenType(param1:String, ... rest) : void
      {
         var _loc3_:EventTween24 = null;
         var _loc4_:Object = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc4_ in rest)
         {
            _loc3_ = getInstance(_loc4_) || new EventTween24(_loc4_);
            _loc3_._mouseEventTweenType = param1;
         }
      }
      
      public static function dispose(... rest) : void
      {
         var _loc2_:Object = null;
         var _loc3_:EventTween24 = null;
         if(!_eventTween24ByTarget)
         {
            return;
         }
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc3_ = _eventTween24ByTarget[_loc2_];
            if(_loc3_)
            {
               _loc3_.dispose();
            }
         }
      }
      
      public static function disposeFullChildren(... rest) : void
      {
         var _loc2_:EventTween24 = null;
         var _loc3_:Object = null;
         var _loc4_:DisplayObjectContainer = null;
         if(!_eventTween24ByTarget)
         {
            return;
         }
         var rest:Array = Util24.array.compressAndClean(rest);
         for(_loc3_ in _eventTween24ByTarget)
         {
            for each(_loc4_ in rest)
            {
               if(_loc3_ is DisplayObject)
               {
                  if(_loc4_.contains(DisplayObject(_loc3_)))
                  {
                     _loc2_ = _eventTween24ByTarget[_loc3_];
                     if(_loc2_)
                     {
                        _loc2_.dispose();
                     }
                  }
               }
               _loc2_ = _eventTween24ByTarget[_loc4_];
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
            }
         }
      }
      
      public static function getInstance(param1:Object) : EventTween24
      {
         return _eventTween24ByTarget?_eventTween24ByTarget[param1] || new EventTween24(param1):new EventTween24(param1);
      }
      
      public static function hasInstance(param1:Object) : EventTween24
      {
         return _eventTween24ByTarget?_eventTween24ByTarget[param1]:null;
      }
      
      private var _target;
      
      private var _rollOverTween:Tween24;
      
      private var _rollOutTween:Tween24;
      
      private var _mouseOverTween:Tween24;
      
      private var _mouseOutTween:Tween24;
      
      private var _mouseDownTween:Tween24;
      
      private var _mouseUpTween:Tween24;
      
      private var _clickTween:Tween24;
      
      private var _addedToStageTween:Tween24;
      
      private var _removeFromStageTween:Tween24;
      
      private var _syncAddChildTween:Tween24;
      
      private var _syncRemoveChildTween:Tween24;
      
      private var _eventTweens:Array;
      
      private var _isRollOver:Boolean;
      
      private var _isMouseOver:Boolean;
      
      private var _isMouseDown:Boolean;
      
      private var _enabled:Boolean;
      
      private var _mouseEventTweenType:String;
      
      private var _duplicateMouseTween:Boolean;
      
      private function _onAdded(param1:Event) : void
      {
         this._target.removeEventListener(Event.ADDED_TO_STAGE,this._onAdded);
         this._target.addEventListener(Event.REMOVED_FROM_STAGE,this._onRemoved);
         if(this._rollOverTween)
         {
            this._target.addEventListener(MouseEvent.ROLL_OVER,this.onInMouseEvent);
         }
         if(this._rollOutTween)
         {
            this._target.addEventListener(MouseEvent.ROLL_OUT,this.onOutMouseEvent);
         }
         if(this._mouseOverTween)
         {
            this._target.addEventListener(MouseEvent.MOUSE_OVER,this.onInMouseEvent);
         }
         if(this._mouseOutTween)
         {
            this._target.addEventListener(MouseEvent.MOUSE_OUT,this.onOutMouseEvent);
         }
         if(this._mouseDownTween)
         {
            this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.onInMouseEvent);
         }
         if(this._mouseUpTween)
         {
            this._target.addEventListener(MouseEvent.MOUSE_UP,this.onOutMouseEvent);
         }
         if(this._clickTween)
         {
            this._target.addEventListener(MouseEvent.CLICK,this._onClick);
         }
         if((this._addedToStageTween) && (this._enabled))
         {
            this._addedToStageTween.play();
         }
      }
      
      private function _onRemoved(param1:Event) : void
      {
         this._target.addEventListener(Event.ADDED_TO_STAGE,this._onAdded);
         this._target.removeEventListener(Event.REMOVED_FROM_STAGE,this._onRemoved);
         this._target.removeEventListener(MouseEvent.ROLL_OVER,this.onInMouseEvent);
         this._target.removeEventListener(MouseEvent.ROLL_OUT,this.onOutMouseEvent);
         this._target.removeEventListener(MouseEvent.MOUSE_OVER,this.onInMouseEvent);
         this._target.removeEventListener(MouseEvent.MOUSE_OUT,this.onOutMouseEvent);
         this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onInMouseEvent);
         this._target.removeEventListener(MouseEvent.MOUSE_UP,this.onOutMouseEvent);
         this._target.removeEventListener(MouseEvent.CLICK,this._onClick);
         if((this._addedToStageTween) && (this._enabled))
         {
            this._removeFromStageTween.play();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._eventTweens)
         {
            this._target.removeEventListener(_loc1_,this._onEvent);
            this._target.removeEventListener(_loc1_,this._onEventOnce);
            delete this._eventTweens[_loc1_];
            true;
         }
         delete _eventTween24ByTarget[this._target];
         true;
         if(this._target is DisplayObject)
         {
            this._target.removeEventListener(Event.ADDED_TO_STAGE,this._onAdded);
            this._target.removeEventListener(Event.REMOVED_FROM_STAGE,this._onRemoved);
            this._target.removeEventListener(MouseEvent.ROLL_OVER,this.onInMouseEvent);
            this._target.removeEventListener(MouseEvent.ROLL_OUT,this.onOutMouseEvent);
            this._target.removeEventListener(MouseEvent.MOUSE_OVER,this.onInMouseEvent);
            this._target.removeEventListener(MouseEvent.MOUSE_OUT,this.onOutMouseEvent);
            this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onInMouseEvent);
            this._target.removeEventListener(MouseEvent.MOUSE_UP,this.onOutMouseEvent);
            this._target.removeEventListener(MouseEvent.CLICK,this._onClick);
            this._target.buttonMode = false;
         }
         this._enabled = false;
         this._isRollOver = false;
         this._isMouseOver = false;
         this._isMouseDown = false;
         this._addedToStageTween = null;
         this._removeFromStageTween = null;
         this._rollOverTween = null;
         this._rollOutTween = null;
         this._mouseOverTween = null;
         this._mouseOutTween = null;
         this._mouseDownTween = null;
         this._mouseUpTween = null;
         this._clickTween = null;
         this._eventTweens = null;
         this._mouseEventTweenType = null;
         this._target = null;
      }
      
      public function setMouseEvent(param1:Tween24, param2:String) : void
      {
         var _loc3_:Function = null;
         this._target.buttonMode = this._enabled;
         switch(param2)
         {
            case MouseEvent.ROLL_OVER:
               this._rollOverTween = param1;
               _loc3_ = this.onInMouseEvent;
               break;
            case MouseEvent.ROLL_OUT:
               this._rollOutTween = param1;
               _loc3_ = this.onOutMouseEvent;
               break;
            case MouseEvent.MOUSE_OVER:
               this._mouseOverTween = param1;
               _loc3_ = this.onInMouseEvent;
               break;
            case MouseEvent.MOUSE_OUT:
               this._mouseOutTween = param1;
               _loc3_ = this.onOutMouseEvent;
               break;
            case MouseEvent.MOUSE_DOWN:
               this._mouseDownTween = param1;
               _loc3_ = this.onInMouseEvent;
               break;
            case MouseEvent.MOUSE_UP:
               this._mouseUpTween = param1;
               _loc3_ = this.onOutMouseEvent;
               break;
            case MouseEvent.CLICK:
               this._clickTween = param1;
               _loc3_ = this._onClick;
               break;
         }
         if(this._target.stage)
         {
            this._target.addEventListener(param2,_loc3_);
         }
      }
      
      public function removeMouseEvent(param1:String) : void
      {
         var _loc2_:Function = null;
         switch(param1)
         {
            case MouseEvent.ROLL_OVER:
               this._rollOverTween = null;
               _loc2_ = this.onInMouseEvent;
               break;
            case MouseEvent.ROLL_OUT:
               this._rollOutTween = null;
               _loc2_ = this.onOutMouseEvent;
               break;
            case MouseEvent.MOUSE_OVER:
               this._mouseOverTween = null;
               _loc2_ = this.onInMouseEvent;
               break;
            case MouseEvent.MOUSE_OUT:
               this._mouseOutTween = null;
               _loc2_ = this.onOutMouseEvent;
               break;
            case MouseEvent.MOUSE_DOWN:
               this._mouseDownTween = null;
               _loc2_ = this.onInMouseEvent;
               break;
            case MouseEvent.MOUSE_UP:
               this._mouseUpTween = null;
               _loc2_ = this.onOutMouseEvent;
               break;
            case MouseEvent.CLICK:
               this._clickTween = null;
               _loc2_ = this._onClick;
               break;
         }
         if(!this._rollOverTween && !this._rollOutTween && !this._mouseOverTween && !this._mouseOutTween && !this._mouseDownTween && !this._mouseUpTween && !this._clickTween)
         {
            this._target.buttonMode = false;
         }
         if(this._target.stage)
         {
            this._target.removeEventListener(param1,_loc2_);
         }
      }
      
      private function onInMouseEvent(param1:MouseEvent) : void
      {
         var _loc2_:Tween24 = null;
         var _loc3_:Tween24 = null;
         if(!this._enabled)
         {
            return;
         }
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               _loc2_ = this._rollOverTween;
               _loc3_ = this._rollOutTween;
               this._isRollOver = true;
               break;
            case MouseEvent.MOUSE_OVER:
               _loc2_ = this._mouseOverTween;
               _loc3_ = this._mouseOutTween;
               this._isMouseOver = true;
               break;
            case MouseEvent.MOUSE_DOWN:
               _loc2_ = this._mouseDownTween;
               _loc3_ = this._mouseUpTween;
               this._isMouseDown = true;
               break;
         }
         if(!this._duplicateMouseTween && (_loc2_.playing))
         {
            return;
         }
         if((this._mouseEventTweenType == TYPE_STOP || this._mouseEventTweenType == TYPE_SERIAL) && (_loc3_))
         {
            _loc3_.stop();
         }
         if(_loc2_.playing)
         {
            _loc2_.stop();
            _loc2_.removeEventListener(Tween24Event.COMPLETE,this.onInTweenComplete);
         }
         _loc2_.play();
      }
      
      private function onOutMouseEvent(param1:MouseEvent) : void
      {
         var _loc2_:Tween24 = null;
         var _loc3_:Tween24 = null;
         if(!this._enabled)
         {
            return;
         }
         switch(param1.type)
         {
            case MouseEvent.ROLL_OUT:
               _loc2_ = this._rollOverTween;
               _loc3_ = this._rollOutTween;
               this._isRollOver = false;
               break;
            case MouseEvent.MOUSE_OUT:
               _loc2_ = this._mouseOverTween;
               _loc3_ = this._mouseOutTween;
               this._isMouseOver = false;
               break;
            case MouseEvent.MOUSE_UP:
               _loc2_ = this._mouseDownTween;
               _loc3_ = this._mouseUpTween;
               this._isMouseDown = false;
               break;
         }
         if(this._mouseEventTweenType == TYPE_STOP && (_loc2_))
         {
            _loc2_.stop();
            _loc3_.play();
         }
         else if((this._mouseEventTweenType == TYPE_SERIAL) && (_loc2_) && (_loc2_.playing))
         {
            _loc2_.addEventListener(Tween24Event.COMPLETE,this.onInTweenComplete);
         }
         else if((this._mouseEventTweenType == TYPE_JUMP) && (_loc2_) && (_loc2_.playing))
         {
            _loc2_.addEventListener(Tween24Event.COMPLETE,this.onInTweenComplete);
            _loc2_.skip();
         }
         else
         {
            if(_loc3_.playing)
            {
               _loc3_.stop();
            }
            _loc3_.play();
         }
         
         
      }
      
      private function onInTweenComplete(param1:Tween24Event) : void
      {
         var _loc2_:Tween24 = null;
         var _loc3_:Tween24 = null;
         switch(param1.tween)
         {
            case this._rollOverTween:
               _loc2_ = this._rollOverTween;
               _loc3_ = this._rollOutTween;
               break;
            case this._mouseOverTween:
               _loc2_ = this._mouseOverTween;
               _loc3_ = this._mouseOutTween;
               break;
            case this._mouseDownTween:
               _loc2_ = this._mouseDownTween;
               _loc3_ = this._mouseUpTween;
               break;
         }
         if(_loc2_)
         {
            _loc2_.removeEventListener(Event.COMPLETE,this.onInTweenComplete);
         }
         if(_loc3_)
         {
            if(_loc3_.playing)
            {
               _loc3_.stop();
            }
            _loc3_.play();
         }
      }
      
      private function _onClick(param1:MouseEvent) : void
      {
         if(!this._enabled)
         {
            return;
         }
         if(this._clickTween.playing)
         {
            this._clickTween.stop();
         }
         this._clickTween.play();
      }
      
      public function setEvent(param1:String, param2:Tween24 = null, param3:Boolean = false) : void
      {
         this._eventTweens = this._eventTweens || [];
         this._eventTweens[param1] = param2;
         if(param2)
         {
            this._target.addEventListener(param1,param3?this._onEventOnce:this._onEvent);
         }
         else
         {
            this._target.removeEventListener(param1,param3?this._onEventOnce:this._onEvent);
         }
      }
      
      private function _onEvent(param1:*) : void
      {
         if(!this._enabled)
         {
            return;
         }
         var _loc2_:Tween24 = this._eventTweens[param1.type];
         if(_loc2_.playing)
         {
            _loc2_.stop();
         }
         _loc2_.play();
      }
      
      private function _onEventOnce(param1:*) : void
      {
         if(!this._enabled)
         {
            return;
         }
         this._target.removeEventListener(param1.type,this._onEventOnce);
         var _loc2_:Tween24 = this._eventTweens[param1.type];
         if(_loc2_.playing)
         {
            _loc2_.stop();
         }
         _loc2_.play();
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function get rollOverTween() : Tween24
      {
         return this._rollOverTween;
      }
      
      public function get rollOutTween() : Tween24
      {
         return this._rollOutTween;
      }
      
      public function get mouseOverTween() : Tween24
      {
         return this._mouseOverTween;
      }
      
      public function get mouseOutTween() : Tween24
      {
         return this._mouseOutTween;
      }
      
      public function get mouseDownTween() : Tween24
      {
         return this._mouseDownTween;
      }
      
      public function get mouseUpTween() : Tween24
      {
         return this._mouseUpTween;
      }
      
      public function get clickTween() : Tween24
      {
         return this._clickTween;
      }
      
      public function get addedToStageTween() : Tween24
      {
         return this._addedToStageTween;
      }
      
      public function get removeFromStageTween() : Tween24
      {
         return this._removeFromStageTween;
      }
      
      public function get addChildSyncTween() : Tween24
      {
         return this._syncAddChildTween;
      }
      
      public function get removeChildSyncTween() : Tween24
      {
         return this._syncRemoveChildTween;
      }
      
      public function get isRollOver() : Boolean
      {
         return this._isRollOver;
      }
      
      public function get isMouseOver() : Boolean
      {
         return this._isMouseOver;
      }
      
      public function get isMouseDown() : Boolean
      {
         return this._isMouseDown;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get mouseEventTweenType() : String
      {
         return this._mouseEventTweenType;
      }
      
      public function set mouseEventTweenType(param1:String) : void
      {
         this._mouseEventTweenType = param1;
      }
      
      public function get duplicateMouseTween() : Boolean
      {
         return this._duplicateMouseTween;
      }
      
      public function set duplicateMouseTween(param1:Boolean) : void
      {
         this._duplicateMouseTween = param1;
      }
   }
}
