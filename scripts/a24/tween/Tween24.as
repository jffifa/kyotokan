package a24.tween
{
   import flash.events.IEventDispatcher;
   import flash.display.Sprite;
   import flash.display.Stage;
   import a24.tween.plugins.proxy.PluginProxy;
   import a24.util.Align24;
   import flash.utils.Dictionary;
   import a24.tween.core.plugins.*;
   import a24.tween.core.updaters.*;
   import a24.tween.core.updaters.colors.*;
   import a24.tween.core.updaters.display.*;
   import a24.tween.core.updaters.filters.*;
   import a24.tween.events.*;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import a24.util.Util24;
   import flash.events.Event;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import flash.utils.ByteArray;
   import flash.events.EventDispatcher;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ConvolutionFilter;
   import flash.filters.BitmapFilter;
   import flash.display.MovieClip;
   
   public class Tween24 extends Object implements IEventDispatcher
   {
      
      public function Tween24(param1:* = null, param2:Number = 0, param3:Function = null, param4:Object = null)
      {
         var _loc5_:* = undefined;
         var _loc6_:ObjectUpdater = null;
         super();
         if(param1 is Array)
         {
            this._target = param1.concat();
         }
         else
         {
            this._targetSingle = param1;
         }
         this._time = param2;
         this._easing = param3 || _defaultEasing;
         this._delayTime = 0;
         this._totalTime = this._time;
         this._progress = 0;
         this._progressDelay = 0;
         this._timeScale = 1;
         this._totalTimeScale = 1;
         this._uniqueId = _numTotalTween;
         _numTotalTween++;
         if(param4)
         {
            if(this._targetSingle)
            {
               this._objectUpdater = new ObjectUpdater(this._targetSingle);
               this._objectUpdater.setProp(param4);
            }
            else
            {
               this._objectUpdaters = new Dictionary();
               for each(_loc5_ in this._target)
               {
                  _loc6_ = new ObjectUpdater(_loc5_);
                  _loc6_.setProp(param4);
                  this._objectUpdaters[_loc5_] = _loc6_;
               }
            }
         }
         if(param1 is PluginTween24Property)
         {
            this._pluginProperty = param1 as PluginTween24Property;
         }
         if(!_engine)
         {
            _engine = new Sprite();
            _pausingAllTweens = new Dictionary();
            _tweensById = [];
            _tweensByGroup = [];
            _playingTweensByTarget = new Dictionary();
            _pausingTweensByTarget = new Dictionary();
            _globalTimeScale = 1;
         }
      }
      
      public static const VERSION:String = "2.0.1";
      
      private static var _numTotalTween:int;
      
      private static var _numPlayingTween:int;
      
      private static var _numPlayedTween:int;
      
      private static var _engine:Sprite;
      
      private static var _runing:Boolean;
      
      private static var _stage:Stage;
      
      private static var _globalTimeScale:Number;
      
      private static var _debugMode:Boolean;
      
      private static var _ease:Ease24 = new Ease24();
      
      private static var _defaultEasing:Function = Ease24._Linear;
      
      private static var _plugin:PluginProxy = new PluginProxy();
      
      private static var _aligin:Align24 = new Align24();
      
      private static var _nowTime:Number;
      
      private static var _tweensById:Array;
      
      private static var _tweensByGroup:Array;
      
      private static var _playingTweensByTarget:Dictionary;
      
      private static var _pausingTweensByTarget:Dictionary;
      
      private static var _pausingAllTweens:Dictionary;
      
      private static var _firstTween:Tween24;
      
      private static var _endTween:Tween24;
      
      private static const _TYPE_TWEEN:String = "tween";
      
      private static const _TYPE_SERIAL:String = "serial";
      
      private static const _TYPE_PARALLEL:String = "parallel";
      
      private static const _TYPE_LOOP:String = "loop";
      
      private static const _TYPE_LAG:String = "lag";
      
      private static const _TYPE_PROP:String = "prop";
      
      private static const _TYPE_WAIT:String = "wait";
      
      private static const _TYPE_JUMP:String = "jump";
      
      private static const _TYPE_TWEEN_FUNC:String = "tweenFunc";
      
      private static const _TYPE_IF_CASE:String = "ifCase";
      
      private static const _TYPE_TWEEN_COUNT:String = "tweenCount";
      
      private static const _TYPE_WAIT_COUNT:String = "waitCount";
      
      private static const _TYPE_FUNC_COUNT:String = "funcCount";
      
      private static const _TYPE_ACTION:String = "action";
      
      private static const _TYPE_FUNC:String = "func";
      
      private static const _TYPE_FUNC_AND_WAIT:String = "funcAndWait";
      
      private static const _TYPE_WAIT_EVENT:String = "waitEvent";
      
      private static const _TYPE_ALL_PAUSE:String = "pauseAllTweens";
      
      private static const _TYPE_RANDOM:String = "randome";
      
      private static const _TRACE_PLAY:Boolean = false;
      
      private static const _TRACE_PAUSE:Boolean = false;
      
      private static const _TRACE_STOP:Boolean = false;
      
      private static const _TRACE_INIT:Boolean = false;
      
      private static const _TRACE_UPDATE:Boolean = false;
      
      private static const _TRACE_NEXT:Boolean = false;
      
      private static const _TRACE_REMOVE:Boolean = false;
      
      public static function tween(param1:Object, param2:Number, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,param2,param3,param4);
         _loc5_._type = _TYPE_TWEEN;
         _loc5_._actionName = "tween";
         return _loc5_;
      }
      
      public static function prop(param1:Object, param2:Object = null) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(param1,0,null,param2);
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "prop";
         return _loc3_;
      }
      
      public static function tweenFunc(param1:Function, param2:Number, param3:Array, param4:Array, param5:Function = null) : Tween24
      {
         var _loc6_:Tween24 = new Tween24(null,param2,param5);
         _loc6_._type = _TYPE_TWEEN_FUNC;
         _loc6_._actionName = "tweenFunc";
         _loc6_._tweenFunc = param1;
         _loc6_._tweenStartArgs = param3;
         _loc6_._tweenCompArgs = param4;
         _loc6_._tweenDeltaArgs = [];
         var _loc7_:int = param3.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_._tweenDeltaArgs.push(param4[_loc8_] - param3[_loc8_]);
            _loc8_++;
         }
         return _loc6_;
      }
      
      public static function tweenVelocity(param1:Object, param2:Number, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,999,param3,param4);
         _loc5_._type = _TYPE_TWEEN;
         _loc5_._actionName = "tweenVelocity";
         _loc5_._velocity = param2;
         return _loc5_;
      }
      
      public static function tweenCount(param1:Object, param2:int, param3:Function = null, param4:Object = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24(param1,NaN,param3);
         _loc5_._type = _TYPE_TWEEN_COUNT;
         _loc5_._actionName = "tweenCount";
         _loc5_._totalCount = param2;
         return _loc5_;
      }
      
      public static function waitCount(param1:uint) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_WAIT_COUNT;
         _loc2_._actionName = "waitCount";
         _loc2_._totalCount = param1;
         return _loc2_;
      }
      
      public static function funcCount(param1:Function, param2:uint, param3:Array, param4:Array, param5:Function = null) : Tween24
      {
         var _loc6_:Tween24 = new Tween24(null,NaN,param5);
         _loc6_._type = _TYPE_FUNC_COUNT;
         _loc6_._actionName = "funcCount";
         _loc6_._tweenFunc = param1;
         _loc6_._tweenStartArgs = param3;
         _loc6_._tweenCompArgs = param4;
         _loc6_._tweenDeltaArgs = [];
         _loc6_._totalCount = param2;
         var _loc7_:int = param3.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_._tweenDeltaArgs.push(param4[_loc8_] - param3[_loc8_]);
            _loc8_++;
         }
         return _loc6_;
      }
      
      public static function serial(... rest) : Tween24
      {
         var _loc5_:* = false;
         var _loc7_:Tween24 = null;
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_SERIAL;
         _loc2_._actionName = "serial";
         var rest:Array = replacePlugin(rest);
         var _loc3_:* = 0.0;
         var _loc4_:int = rest.length;
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = rest[_loc6_];
            _loc7_._nextTween = rest[_loc6_ + 1];
            _loc7_._parentTween = _loc2_;
            if(_loc7_._isJump)
            {
               _loc3_ = _loc7_._totalTime + _loc7_._delayTime;
               _loc7_._parentTrigger = true;
               _loc5_ = true;
            }
            else if(!_loc5_)
            {
               _loc3_ = _loc3_ + _loc7_._totalTime;
            }
            
            _loc6_++;
         }
         if(!_loc5_)
         {
            _loc7_._parentTrigger = true;
         }
         _loc2_._totalTime = _loc3_;
         _loc2_._serialTween = rest[0];
         _loc2_._numChildren = rest.length;
         return _loc2_;
      }
      
      public static function parallel(... rest) : Tween24
      {
         var _loc4_:Tween24 = null;
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_PARALLEL;
         _loc2_._actionName = "parallel";
         var rest:Array = replacePlugin(rest);
         var _loc3_:* = 0.0;
         for each(_loc4_ in rest)
         {
            _loc4_._parentTween = _loc2_;
            if(_loc4_._isJump)
            {
               _loc3_ = _loc4_._totalTime + _loc4_._delayTime;
               _loc4_._parentTrigger = true;
            }
         }
         _loc2_._totalTime = _loc3_;
         _loc2_._parallelTweens = rest;
         _loc2_._numChildren = rest.length;
         return _loc2_;
      }
      
      public static function lag(param1:Number, ... rest) : Tween24
      {
         var _loc4_:Tween24 = null;
         var _loc5_:Tween24 = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:Object = null;
         var _loc9_:Tween24 = null;
         var _loc10_:BlurFilterUpdater = null;
         var _loc11_:GlowFilterUpdater = null;
         var _loc12_:DropShadowFilterUpdater = null;
         var _loc13_:BrightUpdater = null;
         var _loc14_:ContrastUpdater = null;
         var _loc15_:ColorUpdater = null;
         var _loc16_:SaturationUpdater = null;
         var _loc17_:TimelineUpdater = null;
         var _loc18_:ColorReversalUpdater = null;
         var _loc19_:SharpUpdater = null;
         var rest:Array = replacePlugin(rest);
         var _loc3_:Array = [];
         for each(_loc4_ in rest)
         {
            _loc6_ = _loc4_._target.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc8_ = _loc4_._target[_loc7_];
               _loc9_ = new Tween24(_loc8_,_loc4_._time,_loc4_._easing);
               _loc9_._type = _loc4_._type;
               _loc9_.delay(_loc4_._delayTime + param1 * _loc7_);
               if(_loc4_._displayUpdaters)
               {
                  _loc9_._displayUpdater = _loc4_._displayUpdaters[_loc8_];
               }
               _loc10_ = _loc4_._blurUpdater;
               _loc11_ = _loc4_._glowUpdater;
               _loc12_ = _loc4_._dropShadowUpdater;
               _loc13_ = _loc4_._brightUpdater;
               _loc14_ = _loc4_._contrastUpdater;
               _loc15_ = _loc4_._colorUpdater;
               _loc16_ = _loc4_._saturationUpdater;
               _loc17_ = _loc4_._timelineUpdater;
               _loc18_ = _loc4_._colorReversalUpdater;
               _loc19_ = _loc4_._sharpUpdater;
               if(_loc10_)
               {
                  _loc9_.blur(_loc10_.blurX,_loc10_.blurY,_loc10_.quality);
               }
               if(_loc11_)
               {
                  _loc9_.glow(_loc11_.color,_loc11_.alpha,_loc11_.blurX,_loc11_.blurY,_loc11_.strength,_loc11_.quality);
               }
               if(_loc12_)
               {
                  _loc9_.dropShadow(_loc12_.distance,_loc12_.angle,_loc12_.color,_loc12_.alpha,_loc12_.blurX,_loc12_.blurY,_loc12_.strength,_loc12_.quality);
               }
               if(_loc13_)
               {
                  _loc9_.bright(_loc13_.brightness);
               }
               if(_loc14_)
               {
                  _loc9_.contrast(_loc14_.contrast);
               }
               if(_loc15_)
               {
                  _loc9_.color(_loc15_.color,_loc15_.alpha);
               }
               if(_loc16_)
               {
                  _loc9_.saturation(_loc16_.saturation);
               }
               if(_loc17_)
               {
                  _loc9_.frame(_loc17_.frame);
               }
               if(_loc18_)
               {
                  _loc9_.colorReversal(_loc18_.value);
               }
               if(_loc19_)
               {
                  _loc9_.sharp(_loc19_.sharpness);
               }
               if(_loc4_._onPlay != null)
               {
                  _loc9_.onPlay(_loc4_._onPlay,_loc4_._onPlayArgs);
               }
               if(_loc4_._onDelay != null)
               {
                  _loc9_.onDelay(_loc4_._onDelay,_loc4_._onDelayArgs);
               }
               if(_loc4_._onInit != null)
               {
                  _loc9_.onInit(_loc4_._onInit,_loc4_._onInitArgs);
               }
               if(_loc4_._onUpdate != null)
               {
                  _loc9_.onUpdate(_loc4_._onUpdate,_loc4_._onUpdateArgs);
               }
               if(_loc4_._onPause != null)
               {
                  _loc9_.onPause(_loc4_._onPause,_loc4_._onPauseArgs);
               }
               if(_loc4_._onStop != null)
               {
                  _loc9_.onStop(_loc4_._onStop,_loc4_._onStopArgs);
               }
               if(_loc4_._onSkip != null)
               {
                  _loc9_.onSkip(_loc4_._onSkip,_loc4_._onSkipArgs);
               }
               if(_loc4_._onComp != null)
               {
                  _loc9_.onComplete(_loc4_._onComp,_loc4_._onCompArgs);
               }
               if(_loc4_._isRemoveParent)
               {
                  _loc9_.andRemoveChild();
               }
               _loc3_.push(_loc9_);
               _loc7_++;
            }
         }
         _loc5_ = Tween24.parallel(_loc3_);
         _loc5_._type = _TYPE_LAG;
         _loc5_._actionName = "lag";
         return _loc5_;
      }
      
      public static function loop(param1:int, ... rest) : Tween24
      {
         var _loc6_:* = false;
         var _loc8_:Tween24 = null;
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_LOOP;
         _loc3_._actionName = "loop";
         var rest:Array = replacePlugin(rest);
         var _loc4_:* = 0.0;
         var _loc5_:int = rest.length;
         var _loc7_:* = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = rest[_loc7_];
            _loc8_._nextTween = rest[_loc7_ + 1];
            _loc8_._parentTween = _loc3_;
            _loc4_ = _loc4_ + _loc8_._totalTime;
            _loc7_++;
         }
         _loc3_._totalTime = _loc4_;
         _loc3_._serialTween = rest[0];
         _loc3_._numChildren = rest.length;
         _loc3_._loopCount = param1;
         return _loc3_;
      }
      
      public static function ifCase(param1:*, param2:* = null, param3:* = null) : Tween24
      {
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = _TYPE_IF_CASE;
         _loc4_._actionName = "ifCase";
         _loc4_._useIfCase = true;
         _loc4_._numChildren = 1;
         _loc4_._ifCaseBoolean = Boolean(param1);
         _loc4_._ifCaseTrueTween = param2 is PulginTween24?PulginTween24(param2).getTween24():param2;
         _loc4_._ifCaseFalseTween = param3 is PulginTween24?PulginTween24(param3).getTween24():param3;
         _loc4_._ifCaseTrueTween._parentTween = _loc4_;
         if(param3)
         {
            _loc4_._ifCaseFalseTween._parentTween = _loc4_;
         }
         return _loc4_;
      }
      
      public static function ifCaseByProp(param1:*, param2:String, param3:Tween24 = null, param4:Tween24 = null) : Tween24
      {
         var _loc5_:Tween24 = new Tween24();
         _loc5_._type = _TYPE_IF_CASE;
         _loc5_._actionName = "ifCaseByProp";
         _loc5_._useIfCase = true;
         _loc5_._numChildren = 1;
         _loc5_._ifCaseTarget = param1;
         _loc5_._ifCasePropName = param2;
         _loc5_._ifCaseTrueTween = param3;
         _loc5_._ifCaseFalseTween = param4;
         _loc5_._ifCaseTrueTween._parentTween = _loc5_;
         _loc5_._ifCaseTrueTween._parentTrigger = true;
         if(param4)
         {
            _loc5_._ifCaseFalseTween._parentTween = _loc5_;
            _loc5_._ifCaseFalseTween._parentTrigger = true;
         }
         return _loc5_;
      }
      
      public static function random(... rest) : Tween24
      {
         var _loc3_:Tween24 = null;
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_RANDOM;
         _loc2_._actionName = "random";
         _loc2_._randomTweens = rest;
         _loc2_._numChildren = 1;
         for each(_loc3_ in rest)
         {
            _loc3_._parentTween = _loc2_;
         }
         return _loc2_;
      }
      
      private static function eachFuncInPlayingTweens(param1:String, ... rest) : void
      {
         var _loc3_:Tween24 = null;
         var _loc4_:Tween24 = null;
         if(_firstTween)
         {
            _loc3_ = _firstTween;
            do
            {
               _loc4_ = _loc3_._nextList;
               if(!rest.length)
               {
                  _loc3_[param1]();
               }
               else
               {
                  _loc3_[param1].apply(_loc3_,rest);
               }
            }
            while((_loc3_ = _loc4_) != null);
            
         }
      }
      
      private static function eachFuncInPausingTweens(param1:String, ... rest) : void
      {
         var _loc3_:Tween24 = null;
         for each(_loc3_ in _pausingAllTweens)
         {
            if(!rest.length)
            {
               _loc3_[param1]();
            }
            else
            {
               _loc3_[param1].apply(_loc3_,rest);
            }
         }
      }
      
      private static function getControlTween(param1:String, param2:Array, param3:String, ... rest) : Tween24
      {
         var actionName:String = param1;
         var tweens:Array = param2;
         var funcName:String = param3;
         var args:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = actionName;
         tween._action = function():void
         {
            var _loc1_:Tween24 = null;
            for each(_loc1_ in tweens)
            {
               if(!args.length)
               {
                  _loc1_[funcName]();
               }
               else
               {
                  _loc1_[funcName].apply(_loc1_,args);
               }
            }
         };
         return tween;
      }
      
      private static function getControlTweenBy(param1:String, param2:Function, param3:Array, param4:String, ... rest) : Tween24
      {
         var actionName:String = param1;
         var getFunc:Function = param2;
         var getArgs:Array = param3;
         var funcName:String = param4;
         var args:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = actionName;
         tween._action = function():void
         {
            var _loc1_:Tween24 = null;
            for each(_loc1_ in getFunc.apply(Tween24,getArgs))
            {
               if(!args.length)
               {
                  _loc1_[funcName]();
               }
               else
               {
                  _loc1_[funcName].apply(_loc1_,args);
               }
            }
         };
         return tween;
      }
      
      public static function playById(... rest) : Tween24
      {
         return getControlTweenBy("playById",getTweenArrayById,rest,"play");
      }
      
      public static function pauseById(... rest) : Tween24
      {
         return getControlTweenBy("pauseById",getTweenArrayById,rest,"pause");
      }
      
      public static function skipById(... rest) : Tween24
      {
         return getControlTweenBy("skipById",getTweenArrayById,rest,"skip");
      }
      
      public static function stopById(... rest) : Tween24
      {
         return getControlTweenBy("stopById",getTweenArrayById,rest,"stop");
      }
      
      public static function setGlobalTimeScaleById(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleById",getTweenArrayById,rest,"setTimeScale",param1);
      }
      
      public static function disposeIdTween(... rest) : Tween24
      {
         var id:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "disposeIdTween";
         tween._action = function():void
         {
            var _loc1_:String = null;
            for each(_loc1_ in id)
            {
               delete _tweensById[_loc1_];
               true;
            }
         };
         return tween;
      }
      
      public static function playByGroup(... rest) : Tween24
      {
         return getControlTweenBy("playByGroup",getTweenArrayByGroup,rest,"play");
      }
      
      public static function pauseByGroup(... rest) : Tween24
      {
         return getControlTweenBy("pauseByGroup",getTweenArrayByGroup,rest,"pause");
      }
      
      public static function skipByGroup(... rest) : Tween24
      {
         return getControlTweenBy("skipByGroup",getTweenArrayByGroup,rest,"skip");
      }
      
      public static function stopByGroup(... rest) : Tween24
      {
         return getControlTweenBy("stopByGroup",getTweenArrayByGroup,rest,"stop");
      }
      
      public static function setGlobalTimeScaleByGroup(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleByGroup",getTweenArrayByGroup,rest,"setTimeScale",param1);
      }
      
      public static function disposeGroupTweens(... rest) : Tween24
      {
         var id:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "disposeGroupTweens";
         tween._action = function():void
         {
            var _loc1_:String = null;
            for each(_loc1_ in id)
            {
               delete _tweensByGroup[_loc1_];
               true;
            }
         };
         return tween;
      }
      
      public static function pauseByTarget(... rest) : Tween24
      {
         return getControlTweenBy("pauseByTarget",getPlayingTweenArrayByTarget,rest,"pause");
      }
      
      public static function stopByTarget(... rest) : Tween24
      {
         return getControlTweenBy("stopByTarget",getTweenArrayByTarget,rest,"stop");
      }
      
      public static function setGlobalTimeScaleByTarget(param1:Number, ... rest) : Tween24
      {
         return getControlTweenBy("setGlobalTimeScaleByTarget",getTweenArrayByTarget,rest,"setTimeScale",param1);
      }
      
      public static function pauseChildTweens(... rest) : Tween24
      {
         var container:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "pauseChildTweens";
         tween._action = function():void
         {
            var _loc1_:DisplayObjectContainer = null;
            var _loc2_:Array = null;
            var _loc3_:DisplayObject = null;
            var _loc4_:Array = null;
            var _loc5_:Tween24 = null;
            container = Util24.array.compressAndClean(container);
            for each(_loc1_ in container)
            {
               _loc2_ = Util24.display.getAllChildren(_loc1_);
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = getTweenArrayByTarget(_loc3_);
                  for each(_loc5_ in _loc4_)
                  {
                     _loc5_.pause();
                  }
               }
            }
         };
         return tween;
      }
      
      public static function resumeChildTweens(... rest) : Tween24
      {
         var container:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "resumeChildTweens";
         tween._action = function():void
         {
            var _loc1_:DisplayObjectContainer = null;
            var _loc2_:Array = null;
            var _loc3_:DisplayObject = null;
            var _loc4_:Array = null;
            var _loc5_:Tween24 = null;
            container = Util24.array.compressAndClean(container);
            for each(_loc1_ in container)
            {
               _loc2_ = Util24.display.getAllChildren(_loc1_);
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = getTweenArrayByTarget(_loc3_);
                  for each(_loc5_ in _loc4_)
                  {
                     if(_loc5_.pausing)
                     {
                        _loc5_.play2();
                     }
                  }
               }
            }
         };
         return tween;
      }
      
      public static function skipChildTweens(... rest) : Tween24
      {
         var container:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "skipChildTweens";
         tween._action = function():void
         {
            var _loc1_:Tween24 = null;
            for each(_loc1_ in getAllChildrenTweens(container))
            {
               _loc1_.skip();
            }
         };
         return tween;
      }
      
      public static function stopChildTweens(... rest) : Tween24
      {
         var container:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "stopChildTweens";
         tween._action = function():void
         {
            var _loc1_:DisplayObjectContainer = null;
            var _loc2_:Array = null;
            var _loc3_:DisplayObject = null;
            var _loc4_:Array = null;
            var _loc5_:Tween24 = null;
            container = Util24.array.compressAndClean(container);
            for each(_loc1_ in container)
            {
               _loc2_ = Util24.display.getAllChildren(_loc1_);
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = getTweenArrayByTarget(_loc3_);
                  for each(_loc5_ in _loc4_)
                  {
                     _loc5_.stop();
                  }
               }
            }
         };
         return tween;
      }
      
      private static function getAllChildrenTweens(param1:Array) : Array
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:Array = null;
         var param1:Array = Util24.array.compressAndClean(param1);
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            _loc5_ = getChildrenTween(_loc4_);
            if(_loc5_)
            {
               _loc2_.push(_loc5_);
            }
         }
         _loc3_ = _loc3_.concat.apply(_loc3_,_loc2_);
         return _loc3_.length?_loc3_:null;
      }
      
      private static function getChildrenTween(param1:DisplayObjectContainer) : Array
      {
         var _loc2_:Array = null;
         var _loc6_:DisplayObject = null;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = Util24.display.getAllChildren(param1);
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_ is DisplayObjectContainer)
            {
               _loc2_ = getChildrenTween(_loc6_ as DisplayObjectContainer);
            }
            else
            {
               _loc2_ = getTweenArrayByTarget(_loc6_);
            }
            if(_loc2_)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc2_ = getTweenArrayByTarget(param1);
         if(_loc2_)
         {
            _loc3_.push(_loc2_);
         }
         _loc4_ = _loc4_.concat.apply(_loc4_,_loc3_);
         return _loc4_;
      }
      
      public static function playByArray(... rest) : Tween24
      {
         return getControlTween("playByArray",Util24.array.compressAndClean(rest),"play");
      }
      
      public static function pauseByArray(... rest) : Tween24
      {
         return getControlTween("pauseByArray",Util24.array.compressAndClean(rest),"pause");
      }
      
      public static function skipByArray(... rest) : Tween24
      {
         return getControlTween("skipByArray",Util24.array.compressAndClean(rest),"skip");
      }
      
      public static function stopByArray(... rest) : Tween24
      {
         return getControlTween("stopByArray",Util24.array.compressAndClean(rest),"stop");
      }
      
      public static function setGlobalTimeScaleByArray(param1:Number, ... rest) : Tween24
      {
         return getControlTween("setGlobalTimeScaleByArray",Util24.array.compressAndClean(rest),"setTimeScale",param1);
      }
      
      public static function pauseAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ALL_PAUSE;
         tween._actionName = "pauseAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("pause");
         };
         return tween;
      }
      
      public static function resumeAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "resumeAllTweens";
         tween._action = function():void
         {
            eachFuncInPausingTweens("play2");
         };
         return tween;
      }
      
      public static function skipAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "skipAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("skip");
            eachFuncInPausingTweens("skip");
         };
         return tween;
      }
      
      public static function stopAllTweens() : Tween24
      {
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "stopAllTweens";
         tween._action = function():void
         {
            eachFuncInPlayingTweens("stop");
            eachFuncInPausingTweens("stop");
         };
         return tween;
      }
      
      public static function getTweenById(param1:String) : Tween24
      {
         return _tweensById[param1];
      }
      
      public static function getTweenArrayById(... rest) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for each(_loc3_ in rest)
         {
            _loc2_.push(_tweensById[_loc3_]);
         }
         return Util24.array.clean(_loc2_);
      }
      
      public static function getGroupTween(param1:String) : Tween24
      {
         return parallel.apply(parallel,_tweensByGroup[param1]);
      }
      
      public static function getTweenArrayByGroup(... rest) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for each(_loc3_ in rest)
         {
            _loc2_ = _loc2_.concat(_tweensByGroup[_loc3_]);
         }
         return Util24.array.clean(_loc2_);
      }
      
      public static function getPlayingTweenArrayByTarget(... rest) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:Tween24 = null;
         var _loc2_:Array = [];
         for each(_loc3_ in rest)
         {
            for each(_loc4_ in _playingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      public static function getPausingTweenArrayByTarget(... rest) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:Tween24 = null;
         var _loc2_:Array = [];
         for each(_loc3_ in rest)
         {
            for each(_loc4_ in _pausingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      private static function getTweenArrayByTarget(... rest) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:Tween24 = null;
         var _loc2_:Array = [];
         for each(_loc3_ in rest)
         {
            for each(_loc4_ in _playingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
            for each(_loc4_ in _pausingTweensByTarget[_loc3_])
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_.length?Util24.array.clean(_loc2_):null;
      }
      
      public static function addChild(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_ACTION;
         _loc3_._actionName = "addChild";
         return setSyncAddTween(_loc3_,rest,Util24.display.addChild,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function addChildAt(param1:DisplayObjectContainer, param2:DisplayObject, param3:int) : Tween24
      {
         var _loc4_:Tween24 = new Tween24();
         _loc4_._type = _TYPE_ACTION;
         _loc4_._actionName = "addChildAt";
         return setSyncAddTween(_loc4_,[param2],Util24.display.addChildAt,param1,param2,param3);
      }
      
      public static function addChildAtFront(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_ACTION;
         _loc3_._actionName = "addChildAtFront";
         return setSyncAddTween(_loc3_,[param1],Util24.display.addChildAtFront,param1,param2);
      }
      
      public static function addChildAtBack(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_ACTION;
         _loc3_._actionName = "addChildAtBack";
         return setSyncAddTween(_loc3_,[param1],Util24.display.addChildAtBack,param1,param2);
      }
      
      private static function setSyncAddTween(param1:Tween24, param2:Array, param3:Function, ... rest) : Tween24
      {
         var tween:Tween24 = param1;
         var children:Array = param2;
         var func:Function = param3;
         var args:Array = rest;
         tween.addEventListener(Tween24Event.INIT,function():void
         {
            var eventTween:EventTween24 = null;
            var syncTween:Tween24 = null;
            var syncTweens:Array = null;
            var waitTween:Tween24 = null;
            var child:DisplayObject = null;
            tween.removeEventListener(Tween24Event.INIT,arguments.callee);
            children = Util24.array.compressAndClean(children);
            for each(child in children)
            {
               eventTween = EventTween24.hasInstance(child);
               syncTween = eventTween?eventTween.addChildSyncTween:null;
               if(syncTween)
               {
                  syncTweens = syncTweens || [];
                  syncTweens.push(syncTween);
               }
            }
            if(syncTweens)
            {
               waitTween = parallel.apply(parallel,syncTweens);
               waitTween._dispatchComplete = true;
               tween._dispatcher = waitTween.getDispatcher();
               tween._eventType = Tween24Event.COMPLETE;
            }
            tween._action = function():void
            {
               func.apply(func,args);
               if(waitTween)
               {
                  waitTween.play();
               }
            };
         });
         return tween;
      }
      
      public static function removeChild(... rest) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_ACTION;
         _loc2_._actionName = "removeChild";
         return setSyncRemoveTween(_loc2_,Util24.array.compressAndClean(rest));
      }
      
      public static function removeChildByName(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_ACTION;
         _loc3_._actionName = "removeChildByName";
         return setSyncRemoveTween(_loc3_,null,Util24.display.getChildrenByName,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function removeChildAt(param1:DisplayObjectContainer, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_ACTION;
         _loc3_._actionName = "removeChildAt";
         return setSyncRemoveTween(_loc3_,null,Util24.display.getChildrenAt,param1,Util24.array.compressAndClean(rest));
      }
      
      public static function removeAllChildren(... rest) : Tween24
      {
         var _loc2_:Tween24 = new Tween24();
         _loc2_._type = _TYPE_ACTION;
         _loc2_._actionName = "removeAllChildren";
         return setSyncRemoveTween(_loc2_,null,Util24.display.getAllChildren,rest);
      }
      
      private static function setSyncRemoveTween(param1:Tween24, param2:Array, param3:Function = null, ... rest) : Tween24
      {
         var tween:Tween24 = param1;
         var children:Array = param2;
         var getChildFunc:Function = param3;
         var args:Array = rest;
         tween.addEventListener(Tween24Event.INIT,function():void
         {
            var eventTween:EventTween24 = null;
            var syncTween:Tween24 = null;
            var syncTweens:Array = null;
            var waitTween:Tween24 = null;
            var child:DisplayObject = null;
            tween.removeEventListener(Tween24Event.INIT,arguments.callee);
            if(!children)
            {
               children = getChildFunc.apply(getChildFunc,args);
            }
            children = Util24.array.compressAndClean(children);
            for each(child in children)
            {
               eventTween = EventTween24.hasInstance(child);
               syncTween = eventTween?eventTween.removeChildSyncTween:null;
               if(syncTween)
               {
                  syncTweens = syncTweens || [];
                  syncTweens.push(syncTween);
                  syncTween.addEventListener(Tween24Event.COMPLETE,function():void
                  {
                     Util24.display.removeChild(child);
                     syncTween.removeEventListener(Tween24Event.COMPLETE,arguments.callee);
                  });
               }
            }
            if(syncTweens)
            {
               waitTween = parallel.apply(parallel,syncTweens);
               waitTween._dispatchComplete = true;
               tween._dispatcher = waitTween.getDispatcher();
               tween._eventType = Tween24Event.COMPLETE;
            }
            tween._action = function():void
            {
               if(waitTween)
               {
                  waitTween.play();
               }
               else
               {
                  Util24.display.removeChild(children);
               }
            };
         });
         return tween;
      }
      
      public static function setFrontChild(param1:DisplayObject) : Tween24
      {
         var child:DisplayObject = param1;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "swapFrontChild";
         tween._action = function():void
         {
            Util24.display.setFrontChild(child);
         };
         return tween;
      }
      
      public static function setChildIndex(param1:DisplayObject, param2:int) : Tween24
      {
         var child:DisplayObject = param1;
         var index:int = param2;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "swapChildIndex";
         tween._action = function():void
         {
            Util24.display.setChildIndex(child,index);
         };
         return tween;
      }
      
      public static function removeFilters(... rest) : Tween24
      {
         var target:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "removeFilters";
         tween._action = function():void
         {
            Util24.display.removeFilters(target);
         };
         return tween;
      }
      
      public static function visible(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "visible";
         _loc3_.visible(param1);
         return _loc3_;
      }
      
      public static function gotoAndPlay(param1:*, ... rest) : Tween24
      {
         var frame:* = param1;
         var target:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "gotoAndPlay";
         tween._action = function():void
         {
            Util24.timeline.gotoAndPlay(frame,Util24.array.compress(target));
         };
         return tween;
      }
      
      public static function gotoAndStop(param1:*, ... rest) : Tween24
      {
         var frame:* = param1;
         var target:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "gotoAndStop";
         tween._action = function():void
         {
            Util24.timeline.gotoAndStop(frame,Util24.array.compress(target));
         };
         return tween;
      }
      
      public static function addMask(param1:DisplayObject, param2:DisplayObject) : Tween24
      {
         var target:DisplayObject = param1;
         var masker:DisplayObject = param2;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "addMask";
         tween._action = function():void
         {
            Util24.display.addMask(target,masker);
         };
         return tween;
      }
      
      public static function removeMask(param1:DisplayObject) : Tween24
      {
         var target:DisplayObject = param1;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "removeMask";
         tween._action = function():void
         {
            Util24.display.removeMask(target);
         };
         return tween;
      }
      
      public static function func(param1:Function, ... rest) : Tween24
      {
         var func:Function = param1;
         var args:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_FUNC;
         tween._actionName = "func";
         tween._action = function():void
         {
            func.apply(func,args);
         };
         return tween;
      }
      
      public static function funcAndWaitEvent(param1:IEventDispatcher, param2:String, param3:Function, ... rest) : Tween24
      {
         var dispatcher:IEventDispatcher = param1;
         var eventType:String = param2;
         var func:Function = param3;
         var args:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_FUNC_AND_WAIT;
         tween._actionName = "funcAndWaitEvent";
         tween._action = function():void
         {
            func.apply(func,args);
         };
         tween._dispatcher = dispatcher;
         tween._eventType = eventType;
         return tween;
      }
      
      public static function wait(param1:Number) : Tween24
      {
         var _loc2_:Tween24 = new Tween24(null,param1);
         _loc2_._type = _TYPE_WAIT;
         _loc2_._actionName = "wait";
         return _loc2_;
      }
      
      public static function waitEvent(param1:IEventDispatcher, param2:String) : Tween24
      {
         var _loc3_:Tween24 = new Tween24();
         _loc3_._type = _TYPE_WAIT_EVENT;
         _loc3_._actionName = "waitEvent";
         _loc3_._dispatcher = param1;
         _loc3_._eventType = param2;
         return _loc3_;
      }
      
      public static function mouseEnabled(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "mouseEnabled";
         _loc3_.addParam("mouseEnabled",param1);
         return _loc3_;
      }
      
      public static function mouseChildren(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "mouseChildren";
         _loc3_.addParam("mouseChildren",param1);
         return _loc3_;
      }
      
      public static function buttonEnabled(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "buttonEnabled";
         _loc3_.addParam("mouseEnabled",param1);
         _loc3_.addParam("mouseChildren",param1);
         return _loc3_;
      }
      
      public static function buttonMode(param1:Boolean, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "buttonMode";
         _loc3_.addParam("buttonMode",param1);
         return _loc3_;
      }
      
      public static function blendMode(param1:String, ... rest) : Tween24
      {
         var _loc3_:Tween24 = new Tween24(Util24.array.compressAndClean(rest));
         _loc3_._type = _TYPE_PROP;
         _loc3_._actionName = "blendMode";
         _loc3_.setDisplayObjectUpdater("blendMode",param1);
         return _loc3_;
      }
      
      public static function traceLog(... rest) : Tween24
      {
         var messages:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "traceLog";
         tween._action = function():void
         {
            trace.apply(trace,messages);
         };
         return tween;
      }
      
      public static function traceProp(param1:Object, param2:String, ... rest) : Tween24
      {
         var target:Object = param1;
         var label:String = param2;
         var propNames:Array = rest;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "traceProp";
         tween._action = function():void
         {
            var _loc4_:String = null;
            var _loc1_:String = " [";
            var _loc2_:int = propNames.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = propNames[_loc3_];
               _loc1_ = _loc1_ + (_loc4_ + ":" + target[_loc4_] + ", ");
               _loc3_++;
            }
            trace(label + _loc1_.slice(0,_loc1_.length - 2) + "]");
         };
         return tween;
      }
      
      public static function jump(param1:Number) : Tween24
      {
         var _loc2_:Tween24 = new Tween24(null,param1).jump();
         _loc2_._type = _TYPE_JUMP;
         _loc2_._actionName = "jump";
         return _loc2_;
      }
      
      public static function eventDispatch(param1:IEventDispatcher, param2:Event) : Tween24
      {
         var target:IEventDispatcher = param1;
         var event:Event = param2;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "eventDispatch";
         tween._action = function():void
         {
            target.dispatchEvent(event);
         };
         return tween;
      }
      
      public static function getURL(param1:String, param2:String = "_self") : Tween24
      {
         var url:String = param1;
         var window:String = param2;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "getURL";
         tween._action = function():void
         {
            navigateToURL(new URLRequest(url),window);
         };
         return tween;
      }
      
      public static function setFocus(param1:InteractiveObject) : Tween24
      {
         var target:InteractiveObject = param1;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "setFocus";
         tween._action = function():void
         {
            var _loc1_:TextField = null;
            if(target.stage)
            {
               target.stage.focus = target;
               if(target is TextField)
               {
                  _loc1_ = target as TextField;
                  _loc1_.setSelection(_loc1_.length,_loc1_.length);
               }
            }
         };
         return tween;
      }
      
      public static function stageQuality(param1:Stage, param2:String) : Tween24
      {
         var stage:Stage = param1;
         var quality:String = param2;
         _stage = stage || _stage;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "stageQuality";
         tween._action = function():void
         {
            if(_stage)
            {
               _stage.quality = quality;
            }
         };
         return tween;
      }
      
      public static function changeGlobalTimeScale(param1:Number) : Tween24
      {
         var scale:Number = param1;
         var tween:Tween24 = new Tween24();
         tween._type = _TYPE_ACTION;
         tween._actionName = "changeGlobalTimeScale";
         tween._action = function():void
         {
            globalTimeScale = scale;
         };
         return tween;
      }
      
      private static function startEngine() : void
      {
         _runing = true;
         _engine.addEventListener(Event.ENTER_FRAME,rendering);
      }
      
      private static function stopEngine() : void
      {
         _runing = false;
         _engine.removeEventListener(Event.ENTER_FRAME,rendering);
      }
      
      private static function rendering(param1:Event = null) : void
      {
         var _loc2_:Tween24 = null;
         var _loc3_:Tween24 = null;
         if(!_firstTween)
         {
            _endTween = null;
            stopEngine();
            return;
         }
         _loc2_ = _firstTween;
         _loc3_ = _loc2_._nextList;
         _nowTime = getTimer();
         do
         {
            _loc3_ = _loc2_._nextList;
            _loc2_.update();
         }
         while((_loc2_ = _loc3_) != null);
         
      }
      
      private static function removeFromDictionaryInDictionary(param1:Dictionary, param2:*, param3:*) : void
      {
         var _loc5_:* = false;
         var _loc6_:* = undefined;
         var _loc4_:Dictionary = param1[param2];
         if(_loc4_)
         {
            delete _loc4_[param3];
            true;
         }
         for(_loc6_ in _loc4_)
         {
            _loc5_ = true;
         }
         if(!_loc5_)
         {
            delete param1[param2];
            true;
         }
      }
      
      private static function replacePlugin(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var param1:Array = Util24.array.compressAndClean(param1);
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_ is PulginTween24)
            {
               _loc2_.push(PulginTween24(_loc3_).getTween24());
            }
            else if(_loc3_ is Function)
            {
               _loc2_.push(Tween24.func(_loc3_));
            }
            else
            {
               _loc2_.push(_loc3_);
            }
            
         }
         return _loc2_;
      }
      
      private static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function get ease() : Ease24
      {
         return _ease;
      }
      
      public static function get defaultEasing() : Function
      {
         return _defaultEasing;
      }
      
      public static function set defaultEasing(param1:Function) : void
      {
         _defaultEasing = param1;
      }
      
      public static function get globalTimeScale() : Number
      {
         return _globalTimeScale;
      }
      
      public static function set globalTimeScale(param1:Number) : void
      {
         _globalTimeScale = param1;
         eachFuncInPlayingTweens("updateTime");
      }
      
      public static function get plugin() : PluginProxy
      {
         return _plugin;
      }
      
      public static function get aligin() : Align24
      {
         return _aligin;
      }
      
      public static function get debugMode() : Boolean
      {
         return _debugMode;
      }
      
      public static function set debugMode(param1:Boolean) : void
      {
         _debugMode = param1;
      }
      
      private var _target:Array;
      
      private var _targetSingle:Object;
      
      private var _time:Number;
      
      private var _easing:Function;
      
      private var _totalTime:Number;
      
      private var _delayTime:Number;
      
      private var _startTime:Number;
      
      private var _completeTime:Number;
      
      private var _timeScale:Number;
      
      private var _totalTimeScale:Number;
      
      private var _progress:Number;
      
      private var _progressDelay:Number;
      
      private var _uniqueId:int;
      
      private var _uniquePlayId:int;
      
      private var _type:String;
      
      private var _actionName:String;
      
      private var _loopCount:int;
      
      private var _loopCurrent:int;
      
      private var _serialTween:Tween24;
      
      private var _parallelTweens:Array;
      
      private var _randomTween:Tween24;
      
      private var _randomTweens:Array;
      
      private var _action:Function;
      
      private var _id:String;
      
      private var _group:Array;
      
      private var _level:int;
      
      private var _velocity:Number;
      
      private var _numChildren:int;
      
      private var _numCompleteChildren:int;
      
      private var _prevList:Tween24;
      
      private var _nextList:Tween24;
      
      private var _parentTrigger:Boolean;
      
      private var _playing:Boolean;
      
      private var _delaying:Boolean;
      
      private var _pausing:Boolean;
      
      private var _inited:Boolean;
      
      private var _played:Boolean;
      
      private var _completed:Boolean;
      
      private var _skipped:Boolean;
      
      private var _actioned:Boolean;
      
      private var _nextTweenPlayed:Boolean;
      
      private var _isJump:Boolean;
      
      private var _isFilter:Boolean;
      
      private var _isRemoveParent:Boolean;
      
      private var _isDebug:Boolean;
      
      private var _nextTween:Tween24;
      
      private var _rootTween:Tween24;
      
      private var _parentTween:Tween24;
      
      private var _playingChildTweens:Dictionary;
      
      private var _pausingChildTweens:Dictionary;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _dispatchPlay:Boolean;
      
      private var _dispatchDelay:Boolean;
      
      private var _dispatchInit:Boolean;
      
      private var _dispatchPause:Boolean;
      
      private var _dispatchSkip:Boolean;
      
      private var _dispatchStop:Boolean;
      
      private var _dispatchUpdate:Boolean;
      
      private var _dispatchComplete:Boolean;
      
      private var _onPlay:Function;
      
      private var _onPlayArgs:Array;
      
      private var _onDelay:Function;
      
      private var _onDelayArgs:Array;
      
      private var _onInit:Function;
      
      private var _onInitArgs:Array;
      
      private var _onUpdate:Function;
      
      private var _onUpdateArgs:Array;
      
      private var _onPause:Function;
      
      private var _onPauseArgs:Array;
      
      private var _onSkip:Function;
      
      private var _onSkipArgs:Array;
      
      private var _onStop:Function;
      
      private var _onStopArgs:Array;
      
      private var _onComp:Function;
      
      private var _onCompArgs:Array;
      
      private var _displayUpdater:DisplayObjectUpdater;
      
      private var _displayUpdaters:Dictionary;
      
      private var _objectUpdater:ObjectUpdater;
      
      private var _objectUpdaters:Dictionary;
      
      private var _blurUpdater:BlurFilterUpdater;
      
      private var _blurUpdaters:Dictionary;
      
      private var _glowUpdater:GlowFilterUpdater;
      
      private var _glowUpdaters:Dictionary;
      
      private var _dropShadowUpdater:DropShadowFilterUpdater;
      
      private var _dropShadowUpdaters:Dictionary;
      
      private var _brightUpdater:BrightUpdater;
      
      private var _brightUpdaters:Dictionary;
      
      private var _contrastUpdater:ContrastUpdater;
      
      private var _contrastUpdaters:Dictionary;
      
      private var _colorUpdater:ColorUpdater;
      
      private var _colorUpdaters:Dictionary;
      
      private var _saturationUpdater:SaturationUpdater;
      
      private var _saturationUpdaters:Dictionary;
      
      private var _timelineUpdater:TimelineUpdater;
      
      private var _timelineUpdaters:Dictionary;
      
      private var _colorReversalUpdater:ColorReversalUpdater;
      
      private var _colorReversalUpdaters:Dictionary;
      
      private var _sharpUpdater:SharpUpdater;
      
      private var _sharpUpdaters:Dictionary;
      
      private var _dispatcher:IEventDispatcher;
      
      private var _eventType:String;
      
      private var _tweenFunc:Function;
      
      private var _tweenStartArgs:Array;
      
      private var _tweenDeltaArgs:Array;
      
      private var _tweenCompArgs:Array;
      
      private var _useIfCase:Boolean;
      
      private var _ifCaseChildTween:Tween24;
      
      private var _ifCaseTrueTween:Tween24;
      
      private var _ifCaseFalseTween:Tween24;
      
      private var _ifCaseBoolean:Boolean;
      
      private var _ifCaseTarget:Object;
      
      private var _ifCasePropName:String;
      
      private var _pluginProperty:PluginTween24Property;
      
      private var _isManual:Boolean;
      
      private var _totalCount:int;
      
      private var _currentCount:int;
      
      private var _delayCount:int;
      
      public function play(param1:Boolean = false) : void
      {
         this._isDebug = param1;
         this._rootTween = this;
         this._parentTween = null;
         if(this._pluginProperty)
         {
            this._pluginProperty.atPlay();
         }
         if(!_firstTween)
         {
            _nowTime = getTimer();
         }
         this.play2();
      }
      
      public function manualPlay() : void
      {
         this._isManual = true;
         this.play();
      }
      
      private function play2() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Tween24 = null;
         if(_TRACE_PLAY)
         {
            trace("Tween24.play2",this);
         }
         if(this._playing)
         {
            this.stop2();
         }
         if(!this._pausing)
         {
            this._numCompleteChildren = 0;
         }
         this._playing = true;
         this._skipped = false;
         this._completed = false;
         this._uniquePlayId = _numPlayedTween;
         _numPlayingTween++;
         _numPlayedTween++;
         if(!this._rootTween)
         {
            this._level = 0;
            if(this._parentTween)
            {
               this._rootTween = this._parentTween._rootTween || this._parentTween;
            }
         }
         if(this._targetSingle)
         {
            _playingTweensByTarget[this._targetSingle] = _playingTweensByTarget[this._targetSingle] || new Dictionary();
            _playingTweensByTarget[this._targetSingle][this._uniquePlayId] = this;
         }
         else
         {
            for each(_loc1_ in this._target)
            {
               _playingTweensByTarget[_loc1_] = _playingTweensByTarget[_loc1_] || new Dictionary();
               _playingTweensByTarget[_loc1_][this._uniquePlayId] = this;
            }
         }
         if(this._parentTween)
         {
            this._level = this._parentTween._level + 1;
            this._parentTween._playingChildTweens = this._parentTween._playingChildTweens || new Dictionary();
            this._parentTween._playingChildTweens[this._uniquePlayId] = this;
         }
         if(this._pausing)
         {
            this._pausing = false;
            if(this._pausingChildTweens)
            {
               for each(_loc2_ in this._pausingChildTweens)
               {
                  if(_loc2_ != this)
                  {
                     _loc2_.play2();
                     delete this._pausingChildTweens[_loc2_._uniquePlayId];
                     true;
                  }
               }
            }
         }
         if(!this._rootTween._isManual && this == this._rootTween)
         {
            _firstTween = _firstTween || this;
            this._prevList = _endTween;
            if((_endTween) && !(_endTween == this))
            {
               _endTween._nextList = this;
            }
            _endTween = this;
         }
         this.updateTime();
         this.updateEventTrigger();
         if((debugMode) || (this._rootTween._isDebug))
         {
            this.debugTrace("play");
         }
         if(this._onPlay != null)
         {
            if(this._onPlayArgs)
            {
               this._onPlay.apply(this._onPlay,this._onPlayArgs);
            }
            else
            {
               this._onPlay();
            }
         }
         if(this._dispatchPlay)
         {
            this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.PLAY));
         }
         if(this._rootTween._isManual)
         {
            if(!(this._type == _TYPE_TWEEN) && !(this._type == _TYPE_TWEEN_FUNC) && !(this._type == _TYPE_TWEEN_COUNT) && !(this._type == _TYPE_WAIT) && !(this._type == _TYPE_WAIT_COUNT))
            {
               this.update();
            }
         }
         else if(!(this._type == _TYPE_TWEEN_COUNT) && !(this._type == _TYPE_FUNC_COUNT) && !(this._type == _TYPE_WAIT_COUNT))
         {
            this.update();
         }
         
         if(!_runing)
         {
            startEngine();
         }
      }
      
      private function updateTime() : void
      {
         var _loc3_:Tween24 = null;
         this._totalTimeScale = this._timeScale;
         if(this._parentTween)
         {
            this._totalTimeScale = this._totalTimeScale * this._parentTween._totalTimeScale;
         }
         var _loc1_:Number = this._totalTimeScale * _globalTimeScale;
         var _loc2_:Number = this._delayTime * (1 - this._progressDelay) * 1000 * _loc1_;
         switch(this._type)
         {
            case _TYPE_TWEEN:
            case _TYPE_PROP:
            case _TYPE_TWEEN_FUNC:
            case _TYPE_WAIT:
            case _TYPE_JUMP:
               this._completeTime = this._time * 1000 * _loc1_;
               this._startTime = _nowTime + _loc2_ - this._completeTime * this._progress;
               break;
            case _TYPE_SERIAL:
            case _TYPE_LOOP:
            case _TYPE_PARALLEL:
            case _TYPE_RANDOM:
               this._startTime = _nowTime + _loc2_;
               this._completeTime = 0;
               break;
            default:
               this._startTime = _nowTime + _loc2_;
               this._completeTime = 0;
         }
         if(this._playingChildTweens)
         {
            for each(_loc3_ in this._playingChildTweens)
            {
               _loc3_.updateTime();
            }
         }
      }
      
      public function pause() : void
      {
         if(!this._playing)
         {
            return;
         }
         if(this._rootTween == this)
         {
            this.removeFromLinkedList();
         }
         this.pause2();
      }
      
      private function pause2() : void
      {
         var _loc1_:Tween24 = null;
         var _loc2_:Object = null;
         if(this._type == _TYPE_ALL_PAUSE)
         {
            return;
         }
         _numPlayingTween--;
         this._playing = false;
         this._pausing = true;
         if(this._rootTween != this)
         {
            delete this._parentTween._playingChildTweens[this._uniquePlayId];
            true;
            this._parentTween._pausingChildTweens = this._parentTween._pausingChildTweens || new Dictionary();
            this._parentTween._pausingChildTweens[this._uniquePlayId] = this;
         }
         if(this._playingChildTweens)
         {
            for each(_loc1_ in this._playingChildTweens)
            {
               _loc1_.pause2();
            }
         }
         if(this._target)
         {
            for each(_loc2_ in this._target)
            {
               removeFromDictionaryInDictionary(_playingTweensByTarget,_loc2_,this._uniquePlayId);
               _pausingTweensByTarget[_loc2_] = _pausingTweensByTarget[_loc2_] || new Dictionary();
               _pausingTweensByTarget[_loc2_][this._uniquePlayId] = this;
            }
         }
         _pausingAllTweens[this] = this;
         if(this._pluginProperty)
         {
            this._pluginProperty.atPause();
         }
         if(this._onPause != null)
         {
            if(this._onPauseArgs)
            {
               this._onPause.apply(this._onPause,this._onPauseArgs);
            }
            else
            {
               this._onPause();
            }
         }
         if(this._dispatchPause)
         {
            this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.PAUSE));
         }
      }
      
      public function stop() : void
      {
         this.stop2();
         if(this._pluginProperty)
         {
            this._pluginProperty.atStop();
         }
         if(this._onStop != null)
         {
            if(this._onStopArgs)
            {
               this._onStop.apply(this._onStop,this._onStopArgs);
            }
            else
            {
               this._onStop();
            }
         }
         if(this._dispatchStop)
         {
            this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.STOP));
         }
      }
      
      private function stop2() : void
      {
         if(_TRACE_STOP)
         {
            trace("Tween24.stop2",this);
         }
         this.removeTweens();
         if(this == this._rootTween)
         {
            this.stopByDictionary(this._playingChildTweens);
            this.stopByDictionary(this._pausingChildTweens);
         }
      }
      
      private function stopByDictionary(param1:Dictionary) : void
      {
         var _loc2_:Tween24 = null;
         for each(_loc2_ in param1)
         {
            _loc2_.stop2();
         }
      }
      
      public function skip() : void
      {
         this._skipped = true;
         this.update();
      }
      
      public function setTimeScale(param1:Number) : void
      {
         this._timeScale = param1;
         this.updateTime();
      }
      
      private function removeTweens() : void
      {
         var _loc1_:* = undefined;
         if(_TRACE_REMOVE)
         {
            trace("Tween24.removeTweens",this);
         }
         _numPlayingTween--;
         this._played = this._playing = this._inited = this._pausing = this._actioned = this._nextTweenPlayed = false;
         this._progress = this._progressDelay = 0;
         this._currentCount = 0;
         if(this._dispatcher)
         {
            this._dispatcher.removeEventListener(this._eventType,this.funcComplete);
         }
         if(this._targetSingle)
         {
            removeFromDictionaryInDictionary(_playingTweensByTarget,this._targetSingle,this._uniquePlayId);
            removeFromDictionaryInDictionary(_pausingTweensByTarget,this._targetSingle,this._uniquePlayId);
         }
         else
         {
            for each(_loc1_ in this._target)
            {
               removeFromDictionaryInDictionary(_playingTweensByTarget,_loc1_,this._uniquePlayId);
               removeFromDictionaryInDictionary(_pausingTweensByTarget,_loc1_,this._uniquePlayId);
            }
         }
         if(this._rootTween == this)
         {
            this.removeFromLinkedList();
         }
         else if(this._parentTween)
         {
            delete this._parentTween._playingChildTweens[this._uniquePlayId];
            true;
         }
         
      }
      
      private function removeFromLinkedList() : void
      {
         if(this._prevList)
         {
            this._prevList._nextList = this._nextList;
         }
         if(this._nextList)
         {
            this._nextList._prevList = this._prevList;
         }
         if(_firstTween == this)
         {
            _firstTween = this._nextList;
         }
         if(_endTween == this)
         {
            _endTween = this._prevList;
         }
         this._prevList = this._nextList = null;
      }
      
      private function initParams() : void
      {
         var t:Object = null;
         var initParams2:Function = function(param1:Object):void
         {
            var _loc2_:Array = null;
            var _loc3_:BlurFilter = null;
            var _loc4_:GlowFilter = null;
            var _loc5_:DropShadowFilter = null;
            var _loc6_:ColorMatrixFilter = null;
            var _loc7_:ConvolutionFilter = null;
            var _loc8_:BitmapFilter = null;
            if(_displayUpdater)
            {
               _displayUpdater.init();
            }
            else if(_displayUpdaters)
            {
               _displayUpdaters[param1].init();
            }
            
            if(_objectUpdater)
            {
               _objectUpdater.init();
            }
            else if(_objectUpdaters)
            {
               _objectUpdaters[param1].init();
            }
            
            if(_isFilter)
            {
               if(param1 is DisplayObject)
               {
                  _loc2_ = param1.filters;
                  if(_loc2_)
                  {
                     for each(_loc8_ in _loc2_)
                     {
                        if(_loc8_ is BlurFilter)
                        {
                           _loc3_ = _loc8_ as BlurFilter;
                        }
                        else if(_loc8_ is GlowFilter)
                        {
                           _loc4_ = _loc8_ as GlowFilter;
                        }
                        else if(_loc8_ is DropShadowFilter)
                        {
                           _loc5_ = _loc8_ as DropShadowFilter;
                        }
                        else if(_loc8_ is ColorMatrixFilter)
                        {
                           _loc6_ = _loc8_ as ColorMatrixFilter;
                        }
                        else if(_loc8_ is ConvolutionFilter)
                        {
                           _loc7_ = _loc8_ as ConvolutionFilter;
                        }
                        
                        
                        
                        
                     }
                  }
                  if(_targetSingle)
                  {
                     if(_blurUpdater)
                     {
                        _blurUpdater.init(_targetSingle,_loc3_ || new BlurFilter(0,0,1));
                     }
                     if(_glowUpdater)
                     {
                        _glowUpdater.init(_targetSingle,_loc4_ || new GlowFilter(0));
                     }
                     if(_dropShadowUpdater)
                     {
                        _dropShadowUpdater.init(_targetSingle,_loc5_ || new DropShadowFilter());
                     }
                     if(_sharpUpdater)
                     {
                        _sharpUpdater.init(_targetSingle,_loc7_ || new ConvolutionFilter());
                     }
                     if(_saturationUpdater)
                     {
                        _saturationUpdater.init(_targetSingle,_loc6_ || new ColorMatrixFilter());
                     }
                  }
                  else
                  {
                     if(_blurUpdater)
                     {
                        _blurUpdaters = _blurUpdaters || new Dictionary();
                        _blurUpdaters[param1] = _blurUpdater.clone().init(param1,_loc3_ || new BlurFilter(0,0,1));
                     }
                     if(_glowUpdater)
                     {
                        _glowUpdaters = _glowUpdaters || new Dictionary();
                        _glowUpdaters[param1] = _glowUpdater.clone().init(param1,_loc4_ || new GlowFilter(0));
                     }
                     if(_dropShadowUpdater)
                     {
                        _dropShadowUpdaters = _dropShadowUpdaters || new Dictionary();
                        _dropShadowUpdaters[param1] = _dropShadowUpdater.clone().init(param1,_loc5_ || new DropShadowFilter());
                     }
                     if(_saturationUpdater)
                     {
                        _saturationUpdaters = _saturationUpdaters || new Dictionary();
                        _saturationUpdaters[param1] = _saturationUpdater.clone().init(param1,_loc6_ || new ColorMatrixFilter());
                     }
                     if(_sharpUpdater)
                     {
                        _sharpUpdaters = _sharpUpdaters || new Dictionary();
                        _sharpUpdaters[param1] = _sharpUpdater.clone().init(param1,_loc7_ || new ConvolutionFilter());
                     }
                  }
               }
               if(param1 is DisplayObject)
               {
                  if(_targetSingle)
                  {
                     if(_brightUpdater)
                     {
                        _brightUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_contrastUpdater)
                     {
                        _contrastUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_colorUpdater)
                     {
                        _colorUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_colorReversalUpdater)
                     {
                        _colorReversalUpdater.init(_targetSingle as DisplayObject);
                     }
                     if(_timelineUpdater)
                     {
                        _timelineUpdater.init(_targetSingle as MovieClip);
                     }
                  }
                  else
                  {
                     if(_brightUpdater)
                     {
                        _brightUpdaters = _brightUpdaters || new Dictionary();
                        _brightUpdaters[param1] = _brightUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_contrastUpdater)
                     {
                        _contrastUpdaters = _contrastUpdaters || new Dictionary();
                        _contrastUpdaters[param1] = _contrastUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_colorUpdater)
                     {
                        _colorUpdaters = _colorUpdaters || new Dictionary();
                        _colorUpdaters[param1] = _colorUpdater.clone().init(param1 as DisplayObject);
                     }
                     if(_colorReversalUpdater)
                     {
                        _colorReversalUpdaters = _colorReversalUpdaters || new Dictionary();
                        _colorReversalUpdaters[param1] = _colorReversalUpdater.clone().init(param1 as DisplayObject);
                     }
                     if((_timelineUpdater) && param1 is MovieClip)
                     {
                        _timelineUpdaters = _timelineUpdaters || new Dictionary();
                        _timelineUpdaters[param1] = _timelineUpdater.clone().init(param1 as MovieClip);
                     }
                  }
               }
            }
         };
         if(_TRACE_INIT)
         {
            trace("Tween24.initParams",this);
         }
         this._inited = true;
         if(this._targetSingle)
         {
            initParams2(this._targetSingle);
         }
         else
         {
            for each(t in this._target)
            {
               initParams2(t);
            }
         }
         this.overwrite();
      }
      
      private function overwrite() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:Tween24 = null;
         var _loc3_:Object = null;
         if(this._targetSingle)
         {
            _loc1_ = _playingTweensByTarget[this._targetSingle];
            for each(_loc2_ in _loc1_)
            {
               if(_loc2_ != this)
               {
                  if((this._displayUpdater) && (_loc2_._displayUpdater))
                  {
                     _loc2_._displayUpdater.overwrite(this._displayUpdater);
                  }
                  if((this._blurUpdater) && (_loc2_._blurUpdater))
                  {
                     _loc2_._blurUpdater.overwrite(this._blurUpdater);
                  }
                  if((this._glowUpdater) && (_loc2_._glowUpdater))
                  {
                     _loc2_._glowUpdater.overwrite(this._glowUpdater);
                  }
                  if((this._dropShadowUpdater) && (_loc2_._dropShadowUpdater))
                  {
                     _loc2_._dropShadowUpdater.overwrite(this._dropShadowUpdater);
                  }
                  if((this._sharpUpdater) && (_loc2_._sharpUpdater))
                  {
                     _loc2_._sharpUpdater.overwrite(this._sharpUpdater);
                  }
                  if((this._saturationUpdater) && (_loc2_._saturationUpdater))
                  {
                     _loc2_._saturationUpdater.overwrite(this._saturationUpdater);
                  }
                  if((this._brightUpdater) && (_loc2_._brightUpdater))
                  {
                     _loc2_._brightUpdater.overwrite(this._brightUpdater);
                  }
                  if((this._contrastUpdater) && (_loc2_._contrastUpdater))
                  {
                     _loc2_._contrastUpdater.overwrite(this._contrastUpdater);
                  }
                  if((this._colorUpdater) && (_loc2_._colorUpdater))
                  {
                     _loc2_._colorUpdater.overwrite(this._colorUpdater);
                  }
                  if((this._colorReversalUpdater) && (_loc2_._colorReversalUpdater))
                  {
                     _loc2_._colorReversalUpdater.overwrite(this._colorReversalUpdater);
                  }
                  if((this._timelineUpdater) && (_loc2_._timelineUpdater))
                  {
                     _loc2_._timelineUpdater.overwrite(this._timelineUpdater);
                  }
                  if((this._objectUpdater) && (_loc2_._objectUpdater))
                  {
                     _loc2_._objectUpdater.overwrite(this._objectUpdater);
                  }
               }
            }
            return;
         }
         for each(_loc3_ in this._target)
         {
            _loc1_ = _playingTweensByTarget[_loc3_];
            for each(_loc2_ in _loc1_)
            {
               if(_loc2_ != this)
               {
                  if((this._displayUpdaters) && (_loc2_._displayUpdaters) && (this._displayUpdaters[_loc3_]))
                  {
                     _loc2_._displayUpdaters[_loc3_].overwrite(this._displayUpdaters[_loc3_]);
                  }
                  if((this._objectUpdaters) && (_loc2_._objectUpdaters) && (this._objectUpdaters[_loc3_]))
                  {
                     _loc2_._objectUpdaters[_loc3_].overwrite(this._objectUpdaters[_loc3_]);
                  }
                  if(this._isFilter)
                  {
                     if((this._blurUpdaters) && (_loc2_._blurUpdaters) && (this._blurUpdaters[_loc3_]))
                     {
                        _loc2_._blurUpdaters[_loc3_] = null;
                     }
                     if((this._glowUpdaters) && (_loc2_._glowUpdaters) && (this._glowUpdaters[_loc3_]))
                     {
                        _loc2_._glowUpdaters[_loc3_] = null;
                     }
                     if((this._dropShadowUpdaters) && (_loc2_._dropShadowUpdaters) && (this._dropShadowUpdaters[_loc3_]))
                     {
                        _loc2_._dropShadowUpdaters[_loc3_] = null;
                     }
                     if((this._sharpUpdaters) && (_loc2_._sharpUpdaters) && (this._sharpUpdaters[_loc3_]))
                     {
                        _loc2_._sharpUpdaters[_loc3_] = null;
                     }
                     if((this._brightUpdaters) && (_loc2_._brightUpdaters) && (this._brightUpdaters[_loc3_]))
                     {
                        _loc2_._brightUpdaters[_loc3_] = null;
                     }
                     if((this._contrastUpdaters) && (_loc2_._contrastUpdaters) && (this._contrastUpdaters[_loc3_]))
                     {
                        _loc2_._contrastUpdaters[_loc3_] = null;
                     }
                     if((this._colorUpdaters) && (_loc2_._colorUpdaters) && (this._colorUpdaters[_loc3_]))
                     {
                        _loc2_._colorUpdaters[_loc3_] = null;
                     }
                     if((this._saturationUpdaters) && (_loc2_._saturationUpdaters) && (this._saturationUpdaters[_loc3_]))
                     {
                        _loc2_._saturationUpdaters[_loc3_] = null;
                     }
                     if((this._colorReversalUpdaters) && (_loc2_._colorReversalUpdaters) && (this._colorReversalUpdaters[_loc3_]))
                     {
                        _loc2_._colorReversalUpdaters[_loc3_] = null;
                     }
                     if((this._timelineUpdaters) && (_loc2_._timelineUpdaters) && (this._timelineUpdaters[_loc3_]))
                     {
                        _loc2_._timelineUpdaters[_loc3_] = null;
                     }
                  }
               }
            }
         }
      }
      
      public function manualUpdate(param1:int = 1) : void
      {
         if((this._isManual) && (this._playing))
         {
            _nowTime = getTimer();
            this.update();
         }
      }
      
      private function update() : void
      {
         var _loc2_:Object = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:* = NaN;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Tween24 = null;
         var _loc10_:Tween24 = null;
         var _loc11_:* = 0;
         var _loc12_:Array = null;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         if(_TRACE_UPDATE)
         {
            trace("Tween24.update",this);
         }
         var _loc1_:Number = _nowTime - this._startTime;
         if((this._skipped) || (this._parentTween && this._parentTween._skipped) || (this._rootTween) && (this._rootTween._skipped))
         {
            this._progressDelay = 1;
            this._progress = 1;
            this._skipped = true;
            if(this._onSkip != null)
            {
               if(this._onSkipArgs)
               {
                  this._onSkip.apply(this._onSkip,this._onSkipArgs);
               }
               else
               {
                  this._onSkip();
               }
            }
            if(this._dispatchSkip)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.SKIP));
            }
         }
         else if(this._type == _TYPE_TWEEN_COUNT || this._type == _TYPE_WAIT_COUNT || this._type == _TYPE_FUNC_COUNT)
         {
            if(!this._delayTime)
            {
               this._progressDelay = 1;
            }
            else if(this._progressDelay < 1)
            {
               this._progress = 0;
               this._progressDelay = int(this._delayTime) / this._delayCount;
               if(this._progressDelay > 1)
               {
                  this._progressDelay = 1;
               }
               else if(this._progressDelay < 0)
               {
                  this._progressDelay = 0;
               }
               
            }
            
            if(this._progressDelay == 1)
            {
               this._currentCount++;
               if(this._totalCount == 0)
               {
                  this._progress = 1;
               }
               else
               {
                  this._progress = this._currentCount / this._totalCount;
                  if(this._progress > 1)
                  {
                     this._progress = 1;
                  }
                  else if(this._progress < 0)
                  {
                     this._progress = 0;
                  }
                  
               }
            }
         }
         else
         {
            if(!this._delayTime || this._type == _TYPE_LOOP && this._loopCurrent > 0)
            {
               this._progressDelay = 1;
            }
            else if(this._progressDelay < 1)
            {
               this._progress = 0;
               this._progressDelay = this._delayTime?1 + _loc1_ / (this._delayTime * 1000):1.0;
               if(this._progressDelay > 1)
               {
                  this._progressDelay = 1;
               }
               else if(this._progressDelay < 0)
               {
                  this._progressDelay = 0;
               }
               
            }
            
            if(this._progressDelay == 1)
            {
               if(this._completeTime == 0)
               {
                  this._progress = 1;
               }
               else
               {
                  this._progress = _loc1_ / this._completeTime;
                  if(this._progress > 1)
                  {
                     this._progress = 1;
                  }
                  else if(this._progress < 0)
                  {
                     this._progress = 0;
                  }
                  
               }
            }
         }
         
         if(this._progressDelay < 1)
         {
            this._delaying = true;
            if(this._pluginProperty)
            {
               this._pluginProperty.atDelay();
            }
            if(this._onDelay != null)
            {
               if(this._onDelayArgs)
               {
                  this._onDelay.apply(this._onDelay,this._onDelayArgs);
               }
               else
               {
                  this._onDelay();
               }
            }
            if(this._dispatchDelay)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.DELAY));
            }
            return;
         }
         this._delaying = false;
         if(!this._inited)
         {
            if(this._pluginProperty)
            {
               this._pluginProperty.atInit();
            }
            this.initParams();
            if(this._onInit != null)
            {
               if(this._onInitArgs)
               {
                  this._onInit.apply(this._onInit,this._onInitArgs);
               }
               else
               {
                  this._onInit();
               }
            }
            if(!isNaN(this._velocity))
            {
               this._time = this._displayUpdater.getDistance() / this._velocity;
               this.updateTime();
               this.update();
               return;
            }
            if(this._dispatchInit)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.INIT));
            }
         }
         if(this._targetSingle)
         {
            if(this._progress < 1)
            {
               _loc4_ = this._easing(this._progress,0,1,1);
               if(this._objectUpdater)
               {
                  this._objectUpdater.update(_loc4_);
               }
               if(this._displayUpdater)
               {
                  this._displayUpdater.update(_loc4_);
               }
               if(this._isFilter)
               {
                  if(this._blurUpdater)
                  {
                     this._blurUpdater.update(_loc4_);
                  }
                  if(this._glowUpdater)
                  {
                     this._glowUpdater.update(_loc4_);
                  }
                  if(this._dropShadowUpdater)
                  {
                     this._dropShadowUpdater.update(_loc4_);
                  }
                  if(this._sharpUpdater)
                  {
                     this._sharpUpdater.update(_loc4_);
                  }
                  if(this._brightUpdater)
                  {
                     this._brightUpdater.update(_loc4_);
                  }
                  if(this._contrastUpdater)
                  {
                     this._contrastUpdater.update(_loc4_);
                  }
                  if(this._colorUpdater)
                  {
                     this._colorUpdater.update(_loc4_);
                  }
                  if(this._saturationUpdater)
                  {
                     this._saturationUpdater.update(_loc4_);
                  }
                  if(this._colorReversalUpdater)
                  {
                     this._colorReversalUpdater.update(_loc4_);
                  }
                  if(this._timelineUpdater)
                  {
                     this._timelineUpdater.update(_loc4_);
                  }
               }
               if(this._pluginProperty)
               {
                  this._pluginProperty.atUpdate();
               }
               if(this._onUpdate != null)
               {
                  if(this._onUpdateArgs)
                  {
                     this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
                  }
                  else
                  {
                     this._onUpdate();
                  }
               }
               if(this._dispatchUpdate)
               {
                  this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
               }
            }
            else if(this._type == _TYPE_TWEEN || this._type == _TYPE_PROP || this._type == _TYPE_TWEEN_COUNT)
            {
               this.tweenComplete();
            }
            
         }
         else if(this._target)
         {
            if(this._progress < 1)
            {
               for each(_loc2_ in this._target)
               {
                  _loc4_ = this._easing(this._progress,0,1,1);
                  if((this._objectUpdaters) && (this._objectUpdaters[_loc2_]))
                  {
                     this._objectUpdaters[_loc2_].update();
                  }
                  if((this._displayUpdaters) && (this._displayUpdaters[_loc2_]))
                  {
                     this._displayUpdaters[_loc2_].update(_loc4_);
                  }
                  if(this._isFilter)
                  {
                     if((this._blurUpdaters) && (this._blurUpdaters[_loc2_]))
                     {
                        this._blurUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._glowUpdaters) && (this._glowUpdaters[_loc2_]))
                     {
                        this._glowUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._dropShadowUpdaters) && (this._dropShadowUpdaters[_loc2_]))
                     {
                        this._dropShadowUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._sharpUpdaters) && (this._sharpUpdaters[_loc2_]))
                     {
                        this._sharpUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._brightUpdaters) && (this._brightUpdaters[_loc2_]))
                     {
                        this._brightUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._contrastUpdaters) && (this._contrastUpdaters[_loc2_]))
                     {
                        this._contrastUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._colorUpdaters) && (this._colorUpdaters[_loc2_]))
                     {
                        this._colorUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._saturationUpdaters) && (this._saturationUpdaters[_loc2_]))
                     {
                        this._saturationUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._colorReversalUpdaters) && (this._colorReversalUpdaters[_loc2_]))
                     {
                        this._colorReversalUpdaters[_loc2_].update(_loc4_);
                     }
                     if((this._timelineUpdaters) && (this._timelineUpdaters[_loc2_]))
                     {
                        this._timelineUpdaters[_loc2_].update(_loc4_);
                     }
                  }
                  if(this._onUpdate != null)
                  {
                     if(this._onUpdateArgs)
                     {
                        this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
                     }
                     else
                     {
                        this._onUpdate();
                     }
                  }
                  if(this._dispatchUpdate)
                  {
                     this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
                  }
               }
            }
            else if(this._type == _TYPE_TWEEN)
            {
               this.tweenComplete();
            }
            else if(this._type == _TYPE_PROP)
            {
               this.tweenComplete();
            }
            
            
         }
         else if(this._type == _TYPE_SERIAL || this._type == _TYPE_LOOP)
         {
            if(!this._played)
            {
               this._played = true;
               this._serialTween.play2();
            }
            else
            {
               for each(_loc9_ in this._playingChildTweens)
               {
                  _loc9_.update();
               }
            }
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._numChildren == this._numCompleteChildren)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_PARALLEL || this._type == _TYPE_LAG)
         {
            if(!this._played)
            {
               this._played = true;
               for each(_loc10_ in this._parallelTweens)
               {
                  _loc10_.play2();
               }
            }
            else
            {
               for each(_loc10_ in this._playingChildTweens)
               {
                  _loc10_.update();
               }
            }
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._numChildren == this._numCompleteChildren)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_IF_CASE)
         {
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(!this._played)
            {
               this._played = true;
               if(this._ifCaseTarget)
               {
                  this._ifCaseBoolean = this._ifCaseTarget[this._ifCasePropName];
               }
               if(this._ifCaseBoolean)
               {
                  if(this._ifCaseTrueTween)
                  {
                     this._ifCaseTrueTween.play2();
                  }
                  else
                  {
                     this.actionComplete();
                  }
               }
               else if(this._ifCaseFalseTween)
               {
                  this._ifCaseFalseTween.play2();
               }
               else
               {
                  this.actionComplete();
               }
               
            }
            else if(this._ifCaseBoolean)
            {
               if(this._ifCaseTrueTween)
               {
                  this._ifCaseTrueTween.update();
               }
            }
            else if(this._ifCaseFalseTween)
            {
               this._ifCaseFalseTween.update();
            }
            
            
            if(this._numChildren == this._numCompleteChildren)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_RANDOM)
         {
            if(!this._played)
            {
               this._played = true;
               _loc11_ = int(this._randomTweens.length * Math.random());
               this._randomTween = this._randomTweens[_loc11_];
               this._randomTween.play2();
            }
            else
            {
               this._randomTween.update();
            }
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._numChildren == this._numCompleteChildren)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_WAIT || this._type == _TYPE_JUMP || this._type == _TYPE_WAIT_COUNT)
         {
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._progress == 1)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_TWEEN_FUNC || this._type == _TYPE_FUNC_COUNT)
         {
            _loc12_ = [];
            _loc13_ = this._tweenStartArgs.length;
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc12_.push(this._tweenStartArgs[_loc14_] + this._tweenDeltaArgs[_loc14_] * this._progress);
               _loc14_++;
            }
            this._tweenFunc.apply(this._tweenFunc,_loc12_);
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._progress == 1)
            {
               this.tweenComplete();
            }
         }
         else if(!this._actioned)
         {
            this._actioned = true;
            if(this._onUpdate != null)
            {
               if(this._onUpdateArgs)
               {
                  this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
               }
               else
               {
                  this._onUpdate();
               }
            }
            if(this._dispatchUpdate)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
            }
            if(this._progress == 1)
            {
               this.actionComplete();
            }
         }
         else if(this._type == _TYPE_FUNC_AND_WAIT || this._type == _TYPE_WAIT_EVENT)
         {
            if((this._parentTween) && (this._parentTween._skipped) || (this._rootTween) && (this._rootTween._skipped))
            {
               this.funcComplete(null);
            }
         }
         
         
         
         
         
         
         
         
         
      }
      
      private function tweenComplete() : void
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         if(this._targetSingle)
         {
            if(this._displayUpdater)
            {
               this._displayUpdater.complete();
            }
            if(this._objectUpdater)
            {
               this._objectUpdater.complete();
            }
            if(this._isFilter)
            {
               if(this._blurUpdater)
               {
                  this._blurUpdater.complete();
               }
               if(this._glowUpdater)
               {
                  this._glowUpdater.complete();
               }
               if(this._dropShadowUpdater)
               {
                  this._dropShadowUpdater.complete();
               }
               if(this._sharpUpdater)
               {
                  this._sharpUpdater.complete();
               }
               if(this._brightUpdater)
               {
                  this._brightUpdater.complete();
               }
               if(this._contrastUpdater)
               {
                  this._contrastUpdater.complete();
               }
               if(this._colorUpdater)
               {
                  this._colorUpdater.complete();
               }
               if(this._saturationUpdater)
               {
                  this._saturationUpdater.complete();
               }
               if(this._timelineUpdater)
               {
                  this._timelineUpdater.complete();
               }
               if(this._colorReversalUpdater)
               {
                  this._colorReversalUpdater.complete();
               }
            }
         }
         else
         {
            for each(_loc5_ in this._target)
            {
               if((this._displayUpdaters) && (this._displayUpdaters[_loc5_]))
               {
                  this._displayUpdaters[_loc5_].complete();
               }
               if((this._objectUpdaters) && (this._objectUpdaters[_loc5_]))
               {
                  this._objectUpdaters[_loc5_].complete();
               }
               if(this._isFilter)
               {
                  if((this._blurUpdaters) && (this._blurUpdaters[_loc5_]))
                  {
                     this._blurUpdaters[_loc5_].complete();
                  }
                  if((this._glowUpdaters) && (this._glowUpdaters[_loc5_]))
                  {
                     this._glowUpdaters[_loc5_].complete();
                  }
                  if((this._dropShadowUpdaters) && (this._dropShadowUpdaters[_loc5_]))
                  {
                     this._dropShadowUpdaters[_loc5_].complete();
                  }
                  if((this._sharpUpdaters) && (this._sharpUpdaters[_loc5_]))
                  {
                     this._sharpUpdaters[_loc5_].complete();
                  }
                  if((this._brightUpdaters) && (this._brightUpdaters[_loc5_]))
                  {
                     this._brightUpdaters[_loc5_].complete();
                  }
                  if((this._contrastUpdaters) && (this._contrastUpdaters[_loc5_]))
                  {
                     this._contrastUpdaters[_loc5_].complete();
                  }
                  if((this._colorUpdaters) && (this._colorUpdaters[_loc5_]))
                  {
                     this._colorUpdaters[_loc5_].complete();
                  }
                  if((this._saturationUpdaters) && (this._saturationUpdaters[_loc5_]))
                  {
                     this._saturationUpdaters[_loc5_].complete();
                  }
                  if((this._timelineUpdaters) && (this._timelineUpdaters[_loc5_]))
                  {
                     this._timelineUpdaters[_loc5_].complete();
                  }
                  if((this._colorReversalUpdaters) && (this._colorReversalUpdaters[_loc5_]))
                  {
                     this._colorReversalUpdaters[_loc5_].complete();
                  }
               }
            }
         }
         if(this._action != null)
         {
            this._action();
         }
         if(this._pluginProperty)
         {
            this._pluginProperty.atComplete();
         }
         if(this._onUpdate != null)
         {
            if(this._onUpdateArgs)
            {
               this._onUpdate.apply(this._onUpdate,this._onUpdateArgs);
            }
            else
            {
               this._onUpdate();
            }
         }
         if(this._dispatchUpdate)
         {
            this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.UPDATE));
         }
         this.playNextTween();
      }
      
      private function actionComplete() : void
      {
         if(this._dispatcher)
         {
            this._dispatcher.addEventListener(this._eventType,this.funcComplete);
         }
         if(this._action != null)
         {
            this._action();
         }
         if(!this._dispatcher)
         {
            this.playNextTween();
         }
      }
      
      private function funcComplete(param1:*) : void
      {
         this._dispatcher.removeEventListener(this._eventType,this.funcComplete);
         this.playNextTween();
      }
      
      private function playNextTween() : void
      {
         var _loc1_:* = false;
         var _loc2_:Tween24 = null;
         var _loc3_:Tween24 = null;
         if(_TRACE_NEXT)
         {
            trace("Tween24.playNextTween",this);
         }
         if(this._type == _TYPE_LOOP)
         {
            this._loopCurrent++;
            if(!this._loopCount || !(this._loopCount == this._loopCurrent))
            {
               this._played = this._actioned = this._nextTweenPlayed = false;
               this._progress = 0;
               this.play2();
            }
            else
            {
               if((debugMode) || (this._rootTween._isDebug))
               {
                  trace("[comp] " + this);
               }
               this._completed = true;
               if((this._parentTween) && this._parentTween._numChildren > this._parentTween._numCompleteChildren)
               {
                  this._parentTween._numCompleteChildren++;
               }
               this.stop2();
               this._loopCurrent = 0;
               if((this._onCompArgs) && (this._onCompArgs.length))
               {
                  this._onComp.apply(this._onComp,this._onCompArgs);
               }
               else if(this._onComp != null)
               {
                  this._onComp();
               }
               
               if(this._dispatchComplete)
               {
                  this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.COMPLETE));
               }
               if(this._nextTween)
               {
                  this._nextTweenPlayed = true;
                  this._nextTween.play2();
               }
            }
         }
         else
         {
            if((debugMode) || (this._rootTween._isDebug))
            {
               this.debugTrace("comp");
            }
            this._completed = true;
            if((this._parentTween) && this._parentTween._numChildren > this._parentTween._numCompleteChildren)
            {
               this._parentTween._numCompleteChildren++;
            }
            if((this._onCompArgs) && (this._onCompArgs.length))
            {
               this._onComp.apply(this._onComp,this._onCompArgs);
            }
            else if(this._onComp != null)
            {
               this._onComp();
            }
            
            if(this._dispatchComplete)
            {
               this._eventDispatcher.dispatchEvent(new Tween24Event(this,Tween24Event.COMPLETE));
            }
            _loc2_ = !this._nextTweenPlayed && (this._nextTween)?this._nextTween:null;
            this.removeTweens();
            if(_loc2_)
            {
               _loc2_.play2();
            }
            if(this._parentTrigger)
            {
               _loc3_ = this._parentTween?this._parentTween._nextTween:null;
               if((_loc3_) && !this._parentTween._completed)
               {
                  this._parentTween._nextTweenPlayed = true;
                  if(_loc3_._type != _TYPE_LOOP)
                  {
                     _loc3_.play2();
                  }
               }
            }
         }
      }
      
      public function getDispatcher() : EventDispatcher
      {
         return this._eventDispatcher || (this._eventDispatcher = new EventDispatcher());
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.getDispatcher().addEventListener(param1,param2,param3,param4,param5);
         this.updateEventTrigger();
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.getDispatcher().removeEventListener(param1,param2,param3);
         this.updateEventTrigger();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.getDispatcher().hasEventListener(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.getDispatcher().dispatchEvent(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.getDispatcher().willTrigger(param1);
      }
      
      private function updateEventTrigger() : void
      {
         if(!this._eventDispatcher)
         {
            return;
         }
         this._dispatchPlay = this._eventDispatcher.willTrigger(Tween24Event.PLAY);
         this._dispatchDelay = this._eventDispatcher.willTrigger(Tween24Event.DELAY);
         this._dispatchInit = this._eventDispatcher.willTrigger(Tween24Event.INIT);
         this._dispatchUpdate = this._eventDispatcher.willTrigger(Tween24Event.UPDATE);
         this._dispatchPause = this._eventDispatcher.willTrigger(Tween24Event.PAUSE);
         this._dispatchSkip = this._eventDispatcher.willTrigger(Tween24Event.SKIP);
         this._dispatchStop = this._eventDispatcher.willTrigger(Tween24Event.STOP);
         this._dispatchComplete = this._eventDispatcher.willTrigger(Tween24Event.COMPLETE);
      }
      
      private function setDisplayObjectUpdater2(param1:String, param2:String, param3:*, param4:*) : Tween24
      {
         return this.setDisplayObjectUpdater(param1,param3).setDisplayObjectUpdater(param2,param4);
      }
      
      private function setDisplayObjectUpdater3(param1:String, param2:String, param3:String, param4:*, param5:*, param6:*) : Tween24
      {
         return this.setDisplayObjectUpdater(param1,param4).setDisplayObjectUpdater(param2,param5).setDisplayObjectUpdater(param3,param6);
      }
      
      private function setDisplayObjectUpdater(param1:String, param2:*) : Tween24
      {
         var tar:Object = null;
         var updater:DisplayObjectUpdater = null;
         var propName:String = param1;
         var value:* = param2;
         var setValue:Function = function(param1:DisplayObjectUpdater, param2:Object):void
         {
            switch(propName)
            {
               case "x":
                  param1.x = value;
                  break;
               case "y":
                  param1.y = value;
                  break;
               case "z":
                  param1.z = value;
                  break;
               case "$x":
                  param1.set$x(value);
                  break;
               case "$y":
                  param1.set$y(value);
                  break;
               case "$y":
                  param1.z = param2.z + value;
                  break;
               case "$$x":
                  param1.$$x = value;
                  break;
               case "$$y":
                  param1.$$y = value;
                  break;
               case "$$z":
                  param1.$$z = value;
                  break;
               case "alpha":
                  param1.alpha = value;
                  break;
               case "$alpha":
                  param1.alpha = param2.alpha + value;
                  break;
               case "$$alpha":
                  param1.$$alpha = value;
                  break;
               case "rotation":
                  param1.rotation = value;
                  break;
               case "rotationX":
                  param1.rotationX = value;
                  break;
               case "rotationY":
                  param1.rotationY = value;
                  break;
               case "rotationZ":
                  param1.rotationZ = value;
                  break;
               case "$rotation":
                  param1.rotation = param2.rotation + value;
                  param1.$rotation = value;
                  break;
               case "$rotationX":
                  param1.rotationX = param2.rotationX + value;
                  param1.$rotationX = value;
                  break;
               case "$rotationY":
                  param1.rotationY = param2.rotationY + value;
                  param1.$rotationY = value;
                  break;
               case "$rotationZ":
                  param1.rotationZ = param2.rotationZ + value;
                  param1.$rotationZ = value;
                  break;
               case "$$rotation":
                  param1.$$rotation = value;
                  break;
               case "$$rotationX":
                  param1.$$rotationX = value;
                  break;
               case "$$rotationY":
                  param1.$$rotationY = value;
                  break;
               case "$$rotationZ":
                  param1.$$rotationZ = value;
                  break;
               case "width":
                  param1.width = value;
                  break;
               case "height":
                  param1.height = value;
                  break;
               case "$width":
                  param1.width = param2.width + value;
                  break;
               case "$height":
                  param1.height = param2.height + value;
                  break;
               case "$$width":
                  param1.$$width = value;
                  break;
               case "$$height":
                  param1.$$height = value;
                  break;
               case "scaleX":
                  param1.scaleX = value;
                  break;
               case "scaleY":
                  param1.scaleY = value;
                  break;
               case "scaleZ":
                  param1.scaleZ = value;
                  break;
               case "$scaleX":
                  param1.scaleX = param2.scaleX + value;
                  break;
               case "$scaleY":
                  param1.scaleY = param2.scaleY + value;
                  break;
               case "$scaleZ":
                  param1.scaleZ = param2.scaleZ + value;
                  break;
               case "$$scaleX":
                  param1.$$scaleX = value;
                  break;
               case "$$scaleY":
                  param1.$$scaleY = value;
                  break;
               case "$$scaleZ":
                  param1.$$scaleZ = value;
                  break;
               case "globalX":
                  param1.globalX = value;
                  break;
               case "globalY":
                  param1.globalY = value;
                  break;
               case "fadeIn":
                  param1.fadeIn = value;
                  break;
               case "fadeOut":
                  param1.fadeOut = value;
                  break;
               case "align":
                  param1.align = value;
                  param1.update$xy();
                  break;
               case "alignX":
                  param1.alignX = value;
                  param1.update$xy();
                  break;
               case "alignY":
                  param1.alignY = value;
                  param1.update$xy();
                  break;
               case "alignScaleX":
                  param1.alignScaleX = value;
                  param1.update$xy();
                  break;
               case "alignScaleY":
                  param1.alignScaleY = value;
                  param1.update$xy();
                  break;
               case "localX":
                  param1.localX = value;
                  break;
               case "localY":
                  param1.localY = value;
                  break;
               case "localXTarget":
                  param1.localXTarget = value;
                  break;
               case "localYTarget":
                  param1.localYTarget = value;
                  break;
               case "localTarget":
                  param1.localXTarget = param1.localYTarget = value;
                  break;
               case "randomMinX":
                  param1.randomMinX = value;
                  break;
               case "randomMaxX":
                  param1.randomMaxX = value;
                  break;
               case "randomMinY":
                  param1.randomMinY = value;
                  break;
               case "randomMaxY":
                  param1.randomMaxY = value;
                  break;
               case "randomMinZ":
                  param1.randomMinZ = value;
                  break;
               case "randomMaxZ":
                  param1.randomMaxZ = value;
                  break;
               case "randomMinXY":
                  param1.randomMinX = param1.randomMinY = value;
                  break;
               case "randomMaxXY":
                  param1.randomMaxX = param1.randomMaxY = value;
                  break;
               case "randomMinXYZ":
                  param1.randomMinX = param1.randomMinY = param1.randomMinZ = value;
                  break;
               case "randomMaxXYZ":
                  param1.randomMaxX = param1.randomMaxY = param1.randomMaxZ = value;
                  break;
               case "randomRound":
                  param1.randomRound = value;
                  break;
               case "blendMode":
                  param1.blendMode = value;
                  break;
               case "useLayerBlend":
                  param1.useLayerBlend = value;
                  break;
               case "mouseEnabled":
                  param1.mouseEnabled = value;
                  break;
               case "mouseChildren":
                  param1.mouseChildren = value;
                  break;
               case "buttonEnabled":
                  param1.mouseEnabled = param1.mouseChildren = value;
                  break;
            }
         };
         if(this._targetSingle)
         {
            if(!this._displayUpdater)
            {
               this._displayUpdater = new DisplayObjectUpdater(this._targetSingle);
            }
            setValue(this._displayUpdater,this._targetSingle);
         }
         else
         {
            if(!this._displayUpdaters)
            {
               this._displayUpdaters = new Dictionary();
            }
            for each(tar in this._target)
            {
               updater = this._displayUpdaters[tar] || (this._displayUpdaters[tar] = new DisplayObjectUpdater(tar));
               setValue(updater,tar);
            }
         }
         return this;
      }
      
      private function setDisplayObjectUpdaterBezier(param1:String, param2:Number, param3:Number) : Tween24
      {
         var tar:Object = null;
         var updater:DisplayObjectUpdater = null;
         var propName:String = param1;
         var x:Number = param2;
         var y:Number = param3;
         var setBezier:Function = function(param1:DisplayObjectUpdater, param2:Object):void
         {
            switch(propName)
            {
               case "bezier":
                  param1.bezier(x,y);
                  break;
               case "$bezier":
                  param1.bezier(param2.x + x,param2.y + y);
                  break;
               case "$$bezier":
                  param1.$$bezier(x,y);
                  break;
            }
         };
         if(this._targetSingle)
         {
            if(!this._displayUpdater)
            {
               this._displayUpdater = new DisplayObjectUpdater(this._targetSingle);
            }
            setBezier(this._displayUpdater,this._targetSingle);
         }
         else
         {
            if(!this._displayUpdaters)
            {
               this._displayUpdaters = new Dictionary();
            }
            for each(tar in this._target)
            {
               updater = this._displayUpdaters[tar] || (this._displayUpdaters[tar] = new DisplayObjectUpdater(tar));
               setBezier(updater,tar);
            }
         }
         return this;
      }
      
      public function x(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("x",param1);
      }
      
      public function $x(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$x",param1);
      }
      
      public function $$x(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$x",param1);
      }
      
      public function y(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("y",param1);
      }
      
      public function $y(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$y",param1);
      }
      
      public function $$y(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$y",param1);
      }
      
      public function z(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("z",param1);
      }
      
      public function $z(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$z",param1);
      }
      
      public function $$z(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$z",param1);
      }
      
      public function xy(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("x","y",param1,param2);
      }
      
      public function $xy(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$x","$y",param1,param2);
      }
      
      public function $$xy(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$$x","$$y",param1,param2);
      }
      
      public function xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("x","y","z",param1,param2,param3);
      }
      
      public function $xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$x","$y","$z",param1,param2,param3);
      }
      
      public function $$xyz(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$$x","$$y","$$z",param1,param2,param3);
      }
      
      public function alpha(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("alpha",param1);
      }
      
      public function $alpha(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$alpha",param1);
      }
      
      public function $$alpha(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$alpha",param1);
      }
      
      public function rotation(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("rotation",param1);
      }
      
      public function $rotation(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$rotation",param1);
      }
      
      public function $$rotation(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$rotation",param1);
      }
      
      public function rotationX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("rotationX",param1);
      }
      
      public function $rotationX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$rotationX",param1);
      }
      
      public function $$rotationX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$rotationX",param1);
      }
      
      public function rotationY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("rotationY",param1);
      }
      
      public function $rotationY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$rotationY",param1);
      }
      
      public function $$rotationY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$rotationY",param1);
      }
      
      public function rotationZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("rotationZ",param1);
      }
      
      public function $rotationZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$rotationZ",param1);
      }
      
      public function $$rotationZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$rotationZ",param1);
      }
      
      public function rotationXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("rotationX","rotationY",param1,param2);
      }
      
      public function $rotationXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$rotationX","$rotationY",param1,param2);
      }
      
      public function $$rotationXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$$rotationX","$$rotationY",param1,param2);
      }
      
      public function rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("rotationX","rotationY","rotationZ",param1,param2,param3);
      }
      
      public function $rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$rotationX","$rotationY","$rotationZ",param1,param2,param3);
      }
      
      public function $$rotationXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$$rotationX","$$rotationY","$$rotationZ",param1,param2,param3);
      }
      
      public function width(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("width",param1);
      }
      
      public function $width(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$width",param1);
      }
      
      public function $$width(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$width",param1);
      }
      
      public function height(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("height",param1);
      }
      
      public function $height(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$height",param1);
      }
      
      public function $$height(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$height",param1);
      }
      
      public function scaleX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("scaleX",param1);
      }
      
      public function $scaleX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$scaleX",param1);
      }
      
      public function $$scaleX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$scaleX",param1);
      }
      
      public function scaleY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("scaleY",param1);
      }
      
      public function $scaleY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$scaleY",param1);
      }
      
      public function $$scaleY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$scaleY",param1);
      }
      
      public function scaleZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("scaleZ",param1);
      }
      
      public function $scaleZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$scaleZ",param1);
      }
      
      public function $$scaleZ(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("$$scaleZ",param1);
      }
      
      public function scaleXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("scaleX","scaleY",param1,param2);
      }
      
      public function $scaleXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$scaleX","$scaleY",param1,param2);
      }
      
      public function $$scaleXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("$$scaleX","$$scaleY",param1,param2);
      }
      
      public function scale(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("scaleX","scaleY",param1,param1);
      }
      
      public function scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("scaleX","scaleY","scaleZ",param1,param2,param3);
      }
      
      public function $scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$scaleX","$scaleY","$scaleZ",param1,param2,param3);
      }
      
      public function $$scaleXYZ(param1:Number, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("$$scaleX","$$scaleY","$$scaleZ",param1,param2,param3);
      }
      
      public function globalX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("globalX",param1);
      }
      
      public function globalY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("globalY",param1);
      }
      
      public function globalXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("globalX","globalY",param1,param2);
      }
      
      public function localX(param1:DisplayObject, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("localXTarget","localX",param1,param2);
      }
      
      public function localY(param1:DisplayObject, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("localYTarget","localY",param1,param2);
      }
      
      public function localXY(param1:DisplayObject, param2:Number, param3:Number) : Tween24
      {
         return this.setDisplayObjectUpdater3("localTarget","localX","localY",param1,param2,param3);
      }
      
      public function fadeIn(param1:Boolean = false) : Tween24
      {
         return this.setDisplayObjectUpdater3("alpha","fadeIn","useLayerBlend",1,true,param1);
      }
      
      public function fadeOut(param1:Boolean = false) : Tween24
      {
         return this.setDisplayObjectUpdater3("alpha","fadeOut","useLayerBlend",0,true,param1);
      }
      
      public function visible(param1:Boolean) : Tween24
      {
         if(param1)
         {
            this.setDisplayObjectUpdater("fadeIn",true);
         }
         else
         {
            this.setDisplayObjectUpdater("fadeOut",true);
         }
         return this;
      }
      
      public function mouseEnabled(param1:Boolean) : Tween24
      {
         return this.setDisplayObjectUpdater("mouseEnabled",param1);
      }
      
      public function mouseChildren(param1:Boolean) : Tween24
      {
         return this.setDisplayObjectUpdater("mouseChildren",param1);
      }
      
      public function buttonEnabled(param1:Boolean) : Tween24
      {
         return this.setDisplayObjectUpdater("buttonEnabled",param1);
      }
      
      public function align(param1:uint) : Tween24
      {
         return this.setDisplayObjectUpdater("align",param1);
      }
      
      public function alignX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("alignX",param1);
      }
      
      public function alignY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("alignY",param1);
      }
      
      public function alignXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("alignX","alignY",param1,param2);
      }
      
      public function alignByScaleX(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("alignScaleX",param1);
      }
      
      public function alignByScaleY(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater("alignScaleY",param1);
      }
      
      public function alignByScaleXY(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("alignScaleX","alignScaleY",param1,param2);
      }
      
      public function alignByScale(param1:Number) : Tween24
      {
         return this.setDisplayObjectUpdater2("alignScaleX","alignScaleY",param1,param1);
      }
      
      public function bezier(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdaterBezier("bezier",param1,param2);
      }
      
      public function $bezier(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdaterBezier("$bezier",param1,param2);
      }
      
      public function $$bezier(param1:Number, param2:Number) : Tween24
      {
         return this.setDisplayObjectUpdaterBezier("$$bezier",param1,param2);
      }
      
      public function randomX(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return this.setDisplayObjectUpdater3("randomMinX","randomMaxX","randomRound",param1,param2,param3);
      }
      
      public function randomY(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return this.setDisplayObjectUpdater3("randomMinY","randomMaxY","randomRound",param1,param2,param3);
      }
      
      public function randomZ(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return this.setDisplayObjectUpdater3("randomMinZ","randomMaxZ","randomRound",param1,param2,param3);
      }
      
      public function randomXY(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return this.setDisplayObjectUpdater3("randomMinXY","randomMaxXY","randomRound",param1,param2,param3);
      }
      
      public function randomXYZ(param1:Number, param2:Number, param3:Boolean = true) : Tween24
      {
         return this.setDisplayObjectUpdater3("randomMinXYZ","randomMaxXYZ","randomRound",param1,param2,param3);
      }
      
      public function frame(param1:int) : Tween24
      {
         this._isFilter = true;
         this._timelineUpdaters = this._timelineUpdaters || new Dictionary();
         this._timelineUpdater = this._timelineUpdater || new TimelineUpdater();
         this._timelineUpdater.setProp(param1);
         return this;
      }
      
      public function blur(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN) : Tween24
      {
         this._isFilter = true;
         this._blurUpdater = this._blurUpdater || new BlurFilterUpdater();
         this._blurUpdater.setProp(param1,param2,param3);
         return this;
      }
      
      public function blurX(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._blurUpdater = this._blurUpdater || new BlurFilterUpdater();
         this._blurUpdater.blurX = param1;
         return this;
      }
      
      public function blurY(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._blurUpdater = this._blurUpdater || new BlurFilterUpdater();
         this._blurUpdater.blurY = param1;
         return this;
      }
      
      public function blurXY(param1:Number, param2:Number) : Tween24
      {
         this._isFilter = true;
         this._blurUpdater = this._blurUpdater || new BlurFilterUpdater();
         this._blurUpdater.blurX = param1;
         this._blurUpdater.blurY = param2;
         return this;
      }
      
      public function blurQuality(param1:int) : Tween24
      {
         this._isFilter = true;
         this._blurUpdater = this._blurUpdater || new BlurFilterUpdater();
         this._blurUpdater.quality = param1;
         return this;
      }
      
      public function glow(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.setProp(param1,param2,param3,param4,param5,param6);
         return this;
      }
      
      public function glowColor(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.color = param1;
         return this;
      }
      
      public function glowAlpha(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.alpha = param1;
         return this;
      }
      
      public function glowBlurX(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.blurX = param1;
         return this;
      }
      
      public function glowBlurY(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.blurY = param1;
         return this;
      }
      
      public function glowBlurXY(param1:Number, param2:Number) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.blurX = param1;
         this._glowUpdater.blurY = param2;
         return this;
      }
      
      public function glowStrength(param1:int) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.strength = param1;
         return this;
      }
      
      public function glowQuality(param1:int) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.quality = param1;
         return this;
      }
      
      public function glowInner(param1:Boolean) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.inner = param1;
         return this;
      }
      
      public function glowKnockout(param1:Boolean) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.knockout = param1;
         return this;
      }
      
      public function dropShadow(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN, param7:Number = NaN, param8:Number = NaN) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.setProp(param1,param2,param3,param4,param5,param6,param7,param8);
         return this;
      }
      
      public function dropShadowDistance(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.distance = param1;
         return this;
      }
      
      public function dropShadowAngle(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.angle = param1;
         return this;
      }
      
      public function dropShadowColor(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.color = param1;
         return this;
      }
      
      public function dropShadowAlpha(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.alpha = param1;
         return this;
      }
      
      public function dropShadowBlurX(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.blurX = param1;
         return this;
      }
      
      public function dropShadowBlurY(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.blurY = param1;
         return this;
      }
      
      public function dropShadowBlurXY(param1:Number, param2:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.blurX = param1;
         this._dropShadowUpdater.blurY = param2;
         return this;
      }
      
      public function dropShadowStrength(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.strength = param1;
         return this;
      }
      
      public function dropShadowQuality(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._dropShadowUpdater = this._dropShadowUpdater || new DropShadowFilterUpdater();
         this._dropShadowUpdater.quality = param1;
         return this;
      }
      
      public function dropShadowInner(param1:Boolean) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.inner = param1;
         return this;
      }
      
      public function dropShadowKnockout(param1:Boolean) : Tween24
      {
         this._isFilter = true;
         this._glowUpdater = this._glowUpdater || new GlowFilterUpdater();
         this._glowUpdater.knockout = param1;
         return this;
      }
      
      public function bright(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._brightUpdater = this._brightUpdater || new BrightUpdater();
         this._brightUpdater.setProp(param1);
         return this;
      }
      
      public function contrast(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._contrastUpdater = this._contrastUpdater || new ContrastUpdater();
         this._contrastUpdater.setProp(param1);
         return this;
      }
      
      public function saturation(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._saturationUpdater = this._saturationUpdater || new SaturationUpdater();
         this._saturationUpdater.setProp(param1);
         return this;
      }
      
      public function sharp(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._sharpUpdater = this._sharpUpdater || new SharpUpdater();
         this._sharpUpdater.setProp(param1);
         return this;
      }
      
      public function color(param1:Number = NaN, param2:Number = 1) : Tween24
      {
         this._isFilter = true;
         if(isNaN(param1))
         {
            var param2:* = 0.0;
         }
         this._colorUpdater = this._colorUpdater || new ColorUpdater();
         this._colorUpdater.setProp(param1,param2);
         return this;
      }
      
      public function colorAlpha(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._colorUpdater = this._colorUpdater || new ColorUpdater();
         this._colorUpdater.alpha = param1;
         return this;
      }
      
      public function colorReversal(param1:Number) : Tween24
      {
         this._isFilter = true;
         this._colorReversalUpdater = this._colorReversalUpdater || new ColorReversalUpdater();
         this._colorReversalUpdater.setProp(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : Tween24
      {
         this._onPlay = param1;
         this._onPlayArgs = rest;
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : Tween24
      {
         this._onDelay = param1;
         this._onDelayArgs = rest;
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : Tween24
      {
         this._onInit = param1;
         this._onInitArgs = rest;
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : Tween24
      {
         this._onUpdate = param1;
         this._onUpdateArgs = rest;
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : Tween24
      {
         this._onPause = param1;
         this._onPauseArgs = rest;
         return this;
      }
      
      public function onSkip(param1:Function, ... rest) : Tween24
      {
         this._onSkip = param1;
         this._onSkipArgs = rest;
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : Tween24
      {
         this._onStop = param1;
         this._onStopArgs = rest;
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : Tween24
      {
         this._onComp = param1;
         this._onCompArgs = rest;
         return this;
      }
      
      public function delay(param1:Number) : Tween24
      {
         this._delayTime = this._delayTime + param1;
         this._totalTime = this._totalTime + this._delayTime;
         return this;
      }
      
      public function jump() : Tween24
      {
         this._isJump = true;
         return this;
      }
      
      public function id(param1:String) : Tween24
      {
         this._id = param1;
         _tweensById[this._id] = this;
         return this;
      }
      
      public function group(... rest) : Tween24
      {
         var _loc2_:String = null;
         this._group = this._group || [];
         this._group = this._group.concat(rest);
         for each(_loc2_ in rest)
         {
            _tweensByGroup[_loc2_] = _tweensByGroup[_loc2_] || [];
            _tweensByGroup[_loc2_].push(this);
         }
         return this;
      }
      
      public function andRemoveChild() : Tween24
      {
         this._isRemoveParent = true;
         this._action = function():void
         {
            Util24.display.removeChild(_targetSingle || _target);
         };
         return this;
      }
      
      public function timeScale(param1:Number) : Tween24
      {
         this._timeScale = param1;
         return this;
      }
      
      public function addParam(param1:String, param2:*) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:ObjectUpdater = null;
         if(this._targetSingle)
         {
            this._objectUpdater = this._objectUpdater || new ObjectUpdater(this._targetSingle);
            this._objectUpdater.addProp(param1,param2);
         }
         else
         {
            this._objectUpdaters = this._objectUpdaters || new Dictionary();
            for each(_loc3_ in this._target)
            {
               _loc4_ = this._objectUpdaters[_loc3_] || new ObjectUpdater(_loc3_);
               _loc4_.addProp(param1,param2);
               this._objectUpdaters[_loc3_] = _loc4_;
            }
         }
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ = _loc1_ + this.formatToString("type",this._actionName || this._type);
         if(this._targetSingle)
         {
            _loc1_ = _loc1_ + " target:";
            if(this._targetSingle is DisplayObject)
            {
               _loc1_ = _loc1_ + ("\"" + this._targetSingle.name + "\"");
            }
            else
            {
               _loc1_ = _loc1_ + this._targetSingle;
            }
         }
         else if(this._target)
         {
            _loc1_ = _loc1_ + this.formatToString("target",this._target,"name");
         }
         
         if(this._time)
         {
            _loc1_ = _loc1_ + this.formatToString("time",this._time);
         }
         if(this._blurUpdater)
         {
            _loc1_ = _loc1_ + this._blurUpdater.toString();
         }
         if(this._glowUpdater)
         {
            _loc1_ = _loc1_ + this._glowUpdater.toString();
         }
         if(this._dropShadowUpdater)
         {
            _loc1_ = _loc1_ + this._dropShadowUpdater.toString();
         }
         if(this._saturationUpdater)
         {
            _loc1_ = _loc1_ + this._saturationUpdater.toString();
         }
         if(this._brightUpdater)
         {
            _loc1_ = _loc1_ + this._brightUpdater.toString();
         }
         if(this._colorUpdater)
         {
            _loc1_ = _loc1_ + this._colorUpdater.toString();
         }
         if(this._contrastUpdater)
         {
            _loc1_ = _loc1_ + this._contrastUpdater.toString();
         }
         if(this._timelineUpdater)
         {
            _loc1_ = _loc1_ + this._timelineUpdater.toString();
         }
         if(this._id)
         {
            _loc1_ = _loc1_ + this.formatToString("id",this._id);
         }
         if(this._group)
         {
            _loc1_ = _loc1_ + this.formatToString("group",this._group);
         }
         return "[Tween24" + _loc1_ + "]";
      }
      
      private function formatToString(param1:String, param2:*, param3:String = null) : String
      {
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         if(param2 is String)
         {
            var param2:* = "\"" + param2 + "\"";
         }
         else if(param2 is Array)
         {
            if(param3)
            {
               _loc4_ = [];
               for each(_loc5_ in param2)
               {
                  _loc4_.push(_loc5_[param3]);
               }
               if(_loc4_[0] is String)
               {
                  param2 = "[\"" + _loc4_.join("\", \"") + "\"]";
               }
               else
               {
                  param2 = "[" + _loc4_ + "]";
               }
            }
            else if(param2[0] is String)
            {
               param2 = "[\"" + param2.join("\", \"") + "\"]";
            }
            
         }
         
         return " " + param1 + ":" + param2;
      }
      
      private function debugTrace(param1:String) : void
      {
         var _loc2_:String = "";
         var _loc3_:* = 0;
         while(_loc3_ < this._level)
         {
            _loc2_ = _loc2_ + "    ";
            _loc3_++;
         }
         trace(_loc2_ + "[" + param1 + "]" + this.toString());
      }
      
      public function get playing() : Boolean
      {
         return this._playing;
      }
      
      public function get pausing() : Boolean
      {
         return this._pausing;
      }
   }
}
