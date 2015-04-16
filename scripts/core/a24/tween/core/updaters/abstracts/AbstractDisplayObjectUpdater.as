package a24.tween.core.updaters.abstracts
{
   import flash.display.DisplayObject;
   
   public class AbstractDisplayObjectUpdater extends AbstractUpdater
   {
      
      public function AbstractDisplayObjectUpdater()
      {
         super();
      }
      
      protected var _target:DisplayObject;
      
      public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         initFlag();
         this._target = param1;
         return this;
      }
      
      public function clone() : AbstractDisplayObjectUpdater
      {
         return null;
      }
   }
}
