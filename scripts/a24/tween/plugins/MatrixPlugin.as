package a24.tween.plugins
{
   import a24.tween.core.plugins.PulginTween24;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   
   public class MatrixPlugin extends PulginTween24
   {
      
      public function MatrixPlugin(param1:MatrixTween24Property)
      {
         super();
         this._property = param1;
      }
      
      private static var _properties:Dictionary;
      
      public static function tween(param1:DisplayObject, param2:Number, param3:Function = null) : MatrixPlugin
      {
         _properties = _properties || new Dictionary();
         _properties[param1] = _properties[param1] || new MatrixTween24Property(param1);
         var _loc4_:* = new MatrixPlugin(_properties[param1]);
         _loc4_.setTween(_loc4_._property,param2,param3);
         return _loc4_;
      }
      
      public static function prop(param1:DisplayObject) : MatrixPlugin
      {
         _properties = _properties || new Dictionary();
         _properties[param1] = _properties[param1] || new MatrixTween24Property(param1);
         var _loc2_:MatrixPlugin = new MatrixPlugin(_properties[param1]);
         _loc2_.setProp(_loc2_._property);
         return _loc2_;
      }
      
      private var _property:MatrixTween24Property;
      
      public function a(param1:Number) : MatrixPlugin
      {
         addParam("a",param1);
         return this;
      }
      
      public function b(param1:Number) : MatrixPlugin
      {
         addParam("b",param1);
         return this;
      }
      
      public function c(param1:Number) : MatrixPlugin
      {
         addParam("c",param1);
         return this;
      }
      
      public function d(param1:Number) : MatrixPlugin
      {
         addParam("d",param1);
         return this;
      }
      
      public function tx(param1:Number) : MatrixPlugin
      {
         addParam("tx",param1);
         return this;
      }
      
      public function ty(param1:Number) : MatrixPlugin
      {
         addParam("ty",param1);
         return this;
      }
      
      public function skewX(param1:Number) : MatrixPlugin
      {
         addParam("c",param1);
         return this;
      }
      
      public function skewY(param1:Number) : MatrixPlugin
      {
         addParam("b",param1);
         return this;
      }
      
      public function scaleX(param1:Number) : MatrixPlugin
      {
         addParam("a",param1);
         return this;
      }
      
      public function scaleY(param1:Number) : MatrixPlugin
      {
         addParam("d",param1);
         return this;
      }
      
      public function $a(param1:Number) : MatrixPlugin
      {
         addParam("$a",param1);
         return this;
      }
      
      public function $b(param1:Number) : MatrixPlugin
      {
         addParam("$b",param1);
         return this;
      }
      
      public function $c(param1:Number) : MatrixPlugin
      {
         addParam("$c",param1);
         return this;
      }
      
      public function $d(param1:Number) : MatrixPlugin
      {
         addParam("$d",param1);
         return this;
      }
      
      public function $tx(param1:Number) : MatrixPlugin
      {
         addParam("$tx",param1);
         return this;
      }
      
      public function $ty(param1:Number) : MatrixPlugin
      {
         addParam("$ty",param1);
         return this;
      }
      
      public function $skewX(param1:Number) : MatrixPlugin
      {
         addParam("$c",param1);
         return this;
      }
      
      public function $skewY(param1:Number) : MatrixPlugin
      {
         addParam("$b",param1);
         return this;
      }
      
      public function $scaleX(param1:Number) : MatrixPlugin
      {
         addParam("$a",param1);
         return this;
      }
      
      public function $scaleY(param1:Number) : MatrixPlugin
      {
         addParam("$d",param1);
         return this;
      }
      
      public function $$a(param1:Number) : MatrixPlugin
      {
         addParam("$$a",param1);
         return this;
      }
      
      public function $$b(param1:Number) : MatrixPlugin
      {
         addParam("$$b",param1);
         return this;
      }
      
      public function $$c(param1:Number) : MatrixPlugin
      {
         addParam("$$c",param1);
         return this;
      }
      
      public function $$d(param1:Number) : MatrixPlugin
      {
         addParam("$$d",param1);
         return this;
      }
      
      public function $$tx(param1:Number) : MatrixPlugin
      {
         addParam("$$tx",param1);
         return this;
      }
      
      public function $$ty(param1:Number) : MatrixPlugin
      {
         addParam("$$ty",param1);
         return this;
      }
      
      public function $$skewX(param1:Number) : MatrixPlugin
      {
         addParam("$$c",param1);
         return this;
      }
      
      public function $$skewY(param1:Number) : MatrixPlugin
      {
         addParam("$$b",param1);
         return this;
      }
      
      public function $$scaleX(param1:Number) : MatrixPlugin
      {
         addParam("$$a",param1);
         return this;
      }
      
      public function $$scaleY(param1:Number) : MatrixPlugin
      {
         addParam("$$d",param1);
         return this;
      }
      
      public function delay(param1:Number) : MatrixPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : MatrixPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}
import a24.tween.core.plugins.PluginTween24Property;
import flash.display.DisplayObject;
import flash.geom.Matrix;

class MatrixTween24Property extends PluginTween24Property
{
   
   function MatrixTween24Property(param1:DisplayObject)
   {
      super();
      this._target = param1;
      _name = this._target.name;
   }
   
   private var _target:DisplayObject;
   
   private var _matrix:Matrix;
   
   private var _a:Number;
   
   private var _b:Number;
   
   private var _c:Number;
   
   private var _d:Number;
   
   private var _tx:Number;
   
   private var _ty:Number;
   
   override public function atInit() : void
   {
      this._matrix = this._target.transform.matrix;
      this._a = this._matrix.a;
      this._b = this._matrix.b;
      this._c = this._matrix.c;
      this._d = this._matrix.d;
      this._tx = this._matrix.tx;
      this._ty = this._matrix.ty;
   }
   
   override public function atUpdate() : void
   {
      this._target.transform.matrix = this._matrix;
   }
   
   override public function atComplete() : void
   {
      this.atUpdate();
   }
   
   public function get a() : Number
   {
      return this._a;
   }
   
   public function set a(param1:Number) : void
   {
      this._a = this._matrix.a = param1;
   }
   
   public function get b() : Number
   {
      return this._b;
   }
   
   public function set b(param1:Number) : void
   {
      this._b = this._matrix.b = param1;
   }
   
   public function get c() : Number
   {
      return this._c;
   }
   
   public function set c(param1:Number) : void
   {
      this._c = this._matrix.c = param1;
   }
   
   public function get d() : Number
   {
      return this._d;
   }
   
   public function set d(param1:Number) : void
   {
      this._d = this._matrix.d = param1;
   }
   
   public function get tx() : Number
   {
      return this._tx;
   }
   
   public function set tx(param1:Number) : void
   {
      this._tx = this._matrix.tx = param1;
   }
   
   public function get ty() : Number
   {
      return this._ty;
   }
   
   public function set ty(param1:Number) : void
   {
      this._ty = this._matrix.ty = param1;
   }
}
