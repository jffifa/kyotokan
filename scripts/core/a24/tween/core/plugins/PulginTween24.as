package a24.tween.core.plugins
{
   import a24.tween.Tween24;
   import a24.util.Util24;
   
   public class PulginTween24 extends Object
   {
      
      public function PulginTween24()
      {
         super();
         this._tween = new Tween24();
      }
      
      protected var _tween:Tween24;
      
      private var _target:Object;
      
      private var _time:Number;
      
      private var _easing:Function;
      
      protected function setTween(param1:Object, param2:Number, param3:Function = null) : PulginTween24
      {
         this._tween = Tween24.tween(param1,param2,param3);
         return this;
      }
      
      protected function setProp(param1:Object) : PulginTween24
      {
         this._tween = Tween24.prop(param1);
         return this;
      }
      
      protected function setFunc(param1:Function, ... rest) : PulginTween24
      {
         rest.unshift(param1);
         this._tween = Tween24.func.apply(this._tween,rest);
         return this;
      }
      
      protected function add(param1:String, ... rest) : PulginTween24
      {
         var rest:Array = Util24.array.compress(rest);
         this._tween[param1].apply(this._tween,rest);
         return this;
      }
      
      protected function addParam(param1:String, param2:*) : void
      {
         this._tween.addParam(param1,param2);
      }
      
      public function getTween24() : Tween24
      {
         return this._tween;
      }
      
      public function play() : void
      {
         this._tween.play();
      }
      
      public function pause() : void
      {
         this._tween.pause();
      }
      
      public function skip() : void
      {
         this._tween.skip();
      }
      
      public function stop() : void
      {
         this._tween.stop();
      }
      
      public function setTimeScale(param1:Number) : void
      {
         this._tween.setTimeScale(param1);
      }
   }
}
