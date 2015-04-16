package a24.tween.core.updaters.display
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.MovieClip;
   
   public final class TimelineUpdater extends AbstractUpdater
   {
      
      public function TimelineUpdater()
      {
         super();
      }
      
      private var _target:MovieClip;
      
      private var _frame:int;
      
      private var _startFrame:int;
      
      private var _deltaFrame:int;
      
      public function setProp(param1:int) : void
      {
         if(!isNaN(param1))
         {
            this.frame = param1;
         }
      }
      
      public function init(param1:MovieClip) : AbstractUpdater
      {
         initFlag();
         this._target = param1;
         this._startFrame = this._target.currentFrame;
         this._deltaFrame = this._frame - this._startFrame;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         if(_tweenFlag & 1 << 0)
         {
            this._target.gotoAndStop(int(this._startFrame + this._deltaFrame * param1));
         }
         return this;
      }
      
      public function clone() : TimelineUpdater
      {
         var _loc1_:TimelineUpdater = new TimelineUpdater();
         _loc1_.setProp(this._frame);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " frame:" + this._frame;
      }
      
      public function get frame() : int
      {
         return this._frame;
      }
      
      public function set frame(param1:int) : void
      {
         this._frame = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
