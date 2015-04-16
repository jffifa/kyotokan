package a24.tween.core.updaters.display
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import a24.util.Align24;
   import a24.util.Util24;
   
   public final class DisplayObjectUpdater extends AbstractUpdater
   {
      
      public function DisplayObjectUpdater(param1:Object)
      {
         super();
         this._target = param1;
         if(param1 is DisplayObject)
         {
            this._targetDisplayObject = param1 as DisplayObject;
         }
      }
      
      private var _target:Object;
      
      private var _targetDisplayObject:DisplayObject;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _z:Number;
      
      private var _alpha:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _scaleZ:Number;
      
      private var _rotation:Number;
      
      private var _rotationX:Number;
      
      private var _rotationY:Number;
      
      private var _rotationZ:Number;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _startZ:Number;
      
      private var _startAlpha:Number;
      
      private var _startWidth:Number;
      
      private var _startHeight:Number;
      
      private var _startScaleX:Number;
      
      private var _startScaleY:Number;
      
      private var _startScaleZ:Number;
      
      private var _startRotation:Number;
      
      private var _startRotationX:Number;
      
      private var _startRotationY:Number;
      
      private var _startRotationZ:Number;
      
      private var _deltaX:Number;
      
      private var _deltaY:Number;
      
      private var _deltaZ:Number;
      
      private var _deltaAlpha:Number;
      
      private var _deltaWidth:Number;
      
      private var _deltaHeight:Number;
      
      private var _deltaScaleX:Number;
      
      private var _deltaScaleY:Number;
      
      private var _deltaScaleZ:Number;
      
      private var _deltaRotation:Number;
      
      private var _deltaRotationX:Number;
      
      private var _deltaRotationY:Number;
      
      private var _deltaRotationZ:Number;
      
      private var _$x:Number;
      
      private var _$y:Number;
      
      private var _$z:Number;
      
      private var _$alpha:Number;
      
      private var _$width:Number;
      
      private var _$height:Number;
      
      private var _$scaleX:Number;
      
      private var _$scaleY:Number;
      
      private var _$scaleZ:Number;
      
      private var _$rotation:Number;
      
      private var _$rotationX:Number;
      
      private var _$rotationY:Number;
      
      private var _$rotationZ:Number;
      
      private var _$$x:Number;
      
      private var _$$y:Number;
      
      private var _$$z:Number;
      
      private var _$$alpha:Number;
      
      private var _$$width:Number;
      
      private var _$$height:Number;
      
      private var _$$scaleX:Number;
      
      private var _$$scaleY:Number;
      
      private var _$$scaleZ:Number;
      
      private var _$$rotation:Number;
      
      private var _$$rotationX:Number;
      
      private var _$$rotationY:Number;
      
      private var _$$rotationZ:Number;
      
      private var _globalX:Number;
      
      private var _globalY:Number;
      
      private var _bezierX:Array;
      
      private var _bezierY:Array;
      
      private var _$$bezierX:Array;
      
      private var _$$bezierY:Array;
      
      private var _localX:Number;
      
      private var _localY:Number;
      
      private var _localXTarget:DisplayObject;
      
      private var _localYTarget:DisplayObject;
      
      private var _align:uint;
      
      private var _alignX:Number;
      
      private var _alignY:Number;
      
      private var _alignScaleX:Number;
      
      private var _alignScaleY:Number;
      
      private var _alignOffsetByScaleX:Number;
      
      private var _alignOffsetByScaleY:Number;
      
      private var _startRect:Rectangle;
      
      private var _rotX:Number;
      
      private var _rotY:Number;
      
      private var _fadeIn:Boolean;
      
      private var _fadeOut:Boolean;
      
      private var _useLayerBlend:Boolean;
      
      private var _mouseEnabled:Boolean;
      
      private var _mouseChildren:Boolean;
      
      private var _beforeBlend:String;
      
      private var _blendMode:String;
      
      private var _randomMinX:Number;
      
      private var _randomMaxX:Number;
      
      private var _randomMinY:Number;
      
      private var _randomMaxY:Number;
      
      private var _randomMinZ:Number;
      
      private var _randomMaxZ:Number;
      
      private var _randomRound:Boolean;
      
      private var _useSize:Boolean;
      
      private var _useScale:Boolean;
      
      private var _useRotation:Boolean;
      
      private var _useRandom:Boolean;
      
      private var _useGlobalLocal:Boolean;
      
      public function bezier(param1:Number, param2:Number) : void
      {
         this._bezierX = this._bezierX || [];
         this._bezierY = this._bezierY || [];
         this._bezierX.push(param1);
         this._bezierY.push(param2);
      }
      
      public function $$bezier(param1:Number, param2:Number) : void
      {
         this._$$bezierX = this._$$bezierX || [];
         this._$$bezierY = this._$$bezierY || [];
         this._$$bezierX.push(param1);
         this._$$bezierY.push(param2);
      }
      
      public function set$x(param1:Number) : void
      {
         this.$x = param1;
         this.initAlign();
         this.init$XY(true,false);
      }
      
      public function set$y(param1:Number) : void
      {
         this.$y = param1;
         this.initAlign();
         this.init$XY(false,true);
      }
      
      public function update$xy() : void
      {
         this.initAlign();
         if(!isNaN(this.$x))
         {
            this.init$XY(true,false);
         }
         if(!isNaN(this.$y))
         {
            this.init$XY(false,true);
         }
      }
      
      private function initAlign() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Point = null;
         if((this._align) && (this._targetDisplayObject))
         {
            if(this._align == Align24.SELECTED)
            {
               _loc1_ = this._target.getBounds(this._targetDisplayObject);
               if(!isNaN(this._alignScaleX))
               {
                  this._alignX = (_loc1_.left + _loc1_.width) * this._alignScaleX;
               }
               if(!isNaN(this._alignScaleY))
               {
                  this._alignY = (_loc1_.top + _loc1_.height) * this._alignScaleY;
               }
            }
            else
            {
               _loc2_ = Align24.getAlignPoint(this._targetDisplayObject as DisplayObject,this._align);
               this._alignX = _loc2_.x;
               this._alignY = _loc2_.y;
            }
         }
         else
         {
            this._alignX = this._alignY = 0;
            this._alignOffsetByScaleX = this._alignOffsetByScaleY = 0;
         }
      }
      
      private function init$XY(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         if((this._align) && (this._targetDisplayObject))
         {
            _loc3_ = this._targetDisplayObject.localToGlobal(new Point(0,0));
            _loc4_ = this._targetDisplayObject.localToGlobal(new Point(this._alignX,this._alignY));
            if(param1)
            {
               this.x = this._targetDisplayObject.x + this.$x + (_loc4_.x - _loc3_.x);
            }
            if(param2)
            {
               this.y = this._targetDisplayObject.y + this.$y + (_loc4_.y - _loc3_.y);
            }
         }
         else
         {
            if(param1)
            {
               this.x = this._target.x + this.$x;
            }
            if(param2)
            {
               this.y = this._target.y + this.$y;
            }
         }
      }
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number) : void
      {
         this._x = param1;
         this._y = param2;
         this._z = param3;
         this._alpha = param4;
         this._width = param5;
         this._height = param6;
         this._scaleX = param7;
         this._scaleY = param8;
         this._scaleZ = param9;
         this._rotation = param10;
         this._rotationX = param11;
         this._rotationY = param12;
         this._rotationZ = param13;
      }
      
      public function init() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:Point = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         _tweenFlag = _updateFlag | _$$updateFlag;
         var _loc3_:* = 0.0;
         var _loc4_:* = 0.0;
         var _loc5_:* = 0.0;
         if(this._useRandom)
         {
            if(!isNaN(this._randomMinX))
            {
               if(isNaN(this._x))
               {
                  this._x = this._target.x;
               }
               _loc3_ = Util24.math.randomInRange(this._randomMinX,this._randomMaxX,NaN,NaN,this._randomRound);
            }
            if(!isNaN(this._randomMinY))
            {
               if(isNaN(this._y))
               {
                  this._y = this._target.y;
               }
               _loc4_ = Util24.math.randomInRange(this._randomMinY,this._randomMaxY,NaN,NaN,this._randomRound);
            }
            if(!isNaN(this._randomMinZ))
            {
               if(isNaN(this._z))
               {
                  this._z = this._target.z;
               }
               _loc5_ = Util24.math.randomInRange(this._randomMinZ,this._randomMaxZ,NaN,NaN,this._randomRound);
            }
         }
         if(this._targetDisplayObject)
         {
            if(this._align)
            {
               _loc6_ = this._targetDisplayObject.localToGlobal(new Point(this._alignX,this._alignY));
            }
            else
            {
               _loc6_ = new Point(this._targetDisplayObject.x,this._targetDisplayObject.y);
            }
            if(this._useGlobalLocal)
            {
               if(!isNaN(this._globalX))
               {
                  this._x = Util24.display.getLocalX(this._targetDisplayObject,this._globalX);
               }
               if(!isNaN(this._globalY))
               {
                  this._y = Util24.display.getLocalY(this._targetDisplayObject,this._globalY);
               }
               if(!isNaN(this._localX))
               {
                  _loc7_ = Util24.display.getGlobalX(this._targetDisplayObject,this._targetDisplayObject.x);
                  _loc8_ = Util24.display.getGlobalX(this._localXTarget,this._localXTarget.x + this._localX);
                  this._x = this._targetDisplayObject.x + (_loc8_ - _loc7_);
               }
               if(!isNaN(this._localY))
               {
                  _loc9_ = Util24.display.getGlobalY(this._targetDisplayObject,this._targetDisplayObject.y);
                  _loc10_ = Util24.display.getGlobalY(this._localYTarget,this._localYTarget.y + this._localY);
                  this._y = this._targetDisplayObject.y + (_loc10_ - _loc9_);
               }
            }
            if(_$$updateFlag)
            {
               if(_$$updateFlag & 1 << 0)
               {
                  this._x = _loc6_.x + this._$$x;
               }
               if(_$$updateFlag & 1 << 1)
               {
                  this._y = _loc6_.y + this._$$y;
               }
               if(_$$updateFlag & 1 << 2)
               {
                  this._z = this._target.z + this._$$z;
               }
               if(_$$updateFlag & 1 << 3)
               {
                  this._alpha = this._targetDisplayObject.alpha + this._$$alpha;
               }
               if(_$$updateFlag & 1 << 4)
               {
                  this._width = this._targetDisplayObject.width + this._$$width;
               }
               if(_$$updateFlag & 1 << 5)
               {
                  this._height = this._targetDisplayObject.height + this._$$height;
               }
               if(_$$updateFlag & 1 << 6)
               {
                  this._scaleX = this._targetDisplayObject.scaleX + this._$$scaleX;
               }
               if(_$$updateFlag & 1 << 7)
               {
                  this._scaleY = this._targetDisplayObject.scaleY + this._$$scaleY;
               }
               if(_$$updateFlag & 1 << 8)
               {
                  this._scaleZ = this._target.scaleZ + this._$$scaleZ;
               }
               if(_$$updateFlag & 1 << 9)
               {
                  this._rotation = this._targetDisplayObject.rotation + this._$$rotation;
               }
               if(_$$updateFlag & 1 << 10)
               {
                  this._rotationX = this._target.rotationX + this._$$rotationX;
               }
               if(_$$updateFlag & 1 << 11)
               {
                  this._rotationY = this._target.rotationY + this._$$rotationY;
               }
               if(_$$updateFlag & 1 << 12)
               {
                  this._rotationZ = this._target.rotationZ + this._$$rotationZ;
               }
            }
            if(this._align)
            {
               this.initByAlign();
               if(_tweenFlag & 1 << 0)
               {
                  this._deltaX = this._x + (this._align?this._alignOffsetByScaleX - _loc6_.x:-this._startX) + _loc3_;
               }
               if(_tweenFlag & 1 << 1)
               {
                  this._deltaY = this._y + (this._align?this._alignOffsetByScaleY - _loc6_.y:-this._startY) + _loc4_;
               }
            }
            else
            {
               if(_tweenFlag & 1 << 0)
               {
                  this._startX = this._targetDisplayObject.x;
                  this._deltaX = this._x - this._startX + _loc3_;
               }
               if(_tweenFlag & 1 << 1)
               {
                  this._startY = this._targetDisplayObject.y;
                  this._deltaY = this._y - this._startY + _loc4_;
               }
            }
            if(_tweenFlag & 1 << 2)
            {
               this._startZ = this._target.z;
               this._deltaZ = this._z - this._startZ + _loc5_;
            }
            if(_tweenFlag & 1 << 3)
            {
               this._startAlpha = this._targetDisplayObject.alpha;
               this._deltaAlpha = this._alpha - this._startAlpha;
            }
            if(this._useSize)
            {
               if(_tweenFlag & 1 << 4)
               {
                  this._startWidth = this._targetDisplayObject.width;
                  this._deltaWidth = this._width - this._startWidth;
               }
               if(_tweenFlag & 1 << 5)
               {
                  this._startHeight = this._targetDisplayObject.height;
                  this._deltaHeight = this._height - this._startHeight;
               }
            }
            if(this._useScale)
            {
               if(_tweenFlag & 1 << 6)
               {
                  this._startScaleX = this._targetDisplayObject.scaleX;
                  this._deltaScaleX = this._scaleX - this._startScaleX;
               }
               if(_tweenFlag & 1 << 7)
               {
                  this._startScaleY = this._targetDisplayObject.scaleY;
                  this._deltaScaleY = this._scaleY - this._startScaleY;
               }
               if(_tweenFlag & 1 << 8)
               {
                  this._startScaleZ = this._target.scaleZ;
                  this._deltaScaleZ = this._scaleZ - this._startScaleZ;
               }
            }
            if(this._useRotation)
            {
               if(_tweenFlag & 1 << 9)
               {
                  this._startRotation = this._targetDisplayObject.rotation;
                  this._deltaRotation = this._rotation - this._startRotation;
               }
               if(_tweenFlag & 1 << 10)
               {
                  this._startRotationX = this._target.rotationX;
                  this._deltaRotationX = this._rotationX - this._startRotationX;
               }
               if(_tweenFlag & 1 << 11)
               {
                  this._startRotationY = this._target.rotationY;
                  this._deltaRotationY = this._rotationY - this._startRotationY;
               }
               if(_tweenFlag & 1 << 12)
               {
                  this._startRotationZ = this._target.rotationZ;
                  this._deltaRotationZ = this._rotationZ - this._startRotationZ;
               }
            }
            if(this._$$bezierX)
            {
               this._bezierX = [];
               this._bezierY = [];
               _loc2_ = this._$$bezierX.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this._bezierX[_loc1_] = _loc6_.x + this._$$bezierX[_loc1_];
                  this._bezierY[_loc1_] = _loc6_.y + this._$$bezierY[_loc1_];
                  _loc1_++;
               }
            }
            if((this._bezierX) || (this._bezierY))
            {
               if(isNaN(this._x))
               {
                  this._x = this._startX = _loc6_.x;
                  this._deltaX = 0 + _loc3_;
               }
               if(isNaN(this._y))
               {
                  this._y = this._startY = _loc6_.y;
                  this._deltaY = 0 + _loc4_;
               }
            }
         }
         else
         {
            if(_$$updateFlag)
            {
               if(_$$updateFlag & 1 << 0)
               {
                  this._x = this._target.x + this._$$x;
               }
               if(_$$updateFlag & 1 << 1)
               {
                  this._y = this._target.y + this._$$y;
               }
               if(_$$updateFlag & 1 << 2)
               {
                  this._z = this._target.z + this._$$z;
               }
               if(_$$updateFlag & 1 << 3)
               {
                  this._alpha = this._target.alpha + this._$$alpha;
               }
               if(_$$updateFlag & 1 << 4)
               {
                  this._width = this._target.width + this._$$width;
               }
               if(_$$updateFlag & 1 << 5)
               {
                  this._height = this._target.height + this._$$height;
               }
               if(_$$updateFlag & 1 << 6)
               {
                  this._scaleX = this._target.scaleX + this._$$scaleX;
               }
               if(_$$updateFlag & 1 << 7)
               {
                  this._scaleY = this._target.scaleY + this._$$scaleY;
               }
               if(_$$updateFlag & 1 << 8)
               {
                  this._scaleZ = this._target.scaleZ + this._$$scaleZ;
               }
               if(_$$updateFlag & 1 << 9)
               {
                  this._rotation = this._target.rotation + this._$$rotation;
               }
               if(_$$updateFlag & 1 << 10)
               {
                  this._rotationX = this._target.rotationX + this._$$rotationX;
               }
               if(_$$updateFlag & 1 << 11)
               {
                  this._rotationY = this._target.rotationY + this._$$rotationY;
               }
               if(_$$updateFlag & 1 << 12)
               {
                  this._rotationZ = this._target.rotationZ + this._$$rotationZ;
               }
            }
            if(_tweenFlag & 1 << 0)
            {
               this._startX = this._target.x;
               this._deltaX = this._x - this._startX + _loc3_;
            }
            if(_tweenFlag & 1 << 1)
            {
               this._startY = this._target.y;
               this._deltaY = this._y - this._startY + _loc4_;
            }
            if(_tweenFlag & 1 << 2)
            {
               this._startZ = this._target.z;
               this._deltaZ = this._z - this._startZ + _loc5_;
            }
            if(_tweenFlag & 1 << 3)
            {
               this._startAlpha = this._target.alpha;
               this._deltaAlpha = this._alpha - this._startAlpha;
            }
            if(this._useSize)
            {
               if(_tweenFlag & 1 << 4)
               {
                  this._startWidth = this._target.width;
                  this._deltaWidth = this._width - this._startWidth;
               }
               if(_tweenFlag & 1 << 5)
               {
                  this._startHeight = this._target.height;
                  this._deltaHeight = this._height - this._startHeight;
               }
            }
            if(this._useScale)
            {
               if(_tweenFlag & 1 << 6)
               {
                  this._startScaleX = this._target.scaleX;
                  this._deltaScaleX = this._scaleX - this._startScaleX;
               }
               if(_tweenFlag & 1 << 7)
               {
                  this._startScaleY = this._target.scaleY;
                  this._deltaScaleY = this._scaleY - this._startScaleY;
               }
               if(_tweenFlag & 1 << 8)
               {
                  this._startScaleZ = this._target.scaleZ;
                  this._deltaScaleZ = this._scaleZ - this._startScaleZ;
               }
            }
            if(this._useRotation)
            {
               if(_tweenFlag & 1 << 9)
               {
                  this._startRotation = this._target.rotation;
                  this._deltaRotation = this._rotation - this._startRotation;
               }
               if(_tweenFlag & 1 << 10)
               {
                  this._startRotationX = this._target.rotationX;
                  this._deltaRotationX = this._rotationX - this._startRotationX;
               }
               if(_tweenFlag & 1 << 11)
               {
                  this._startRotationY = this._target.rotationY;
                  this._deltaRotationY = this._rotationY - this._startRotationY;
               }
               if(_tweenFlag & 1 << 12)
               {
                  this._startRotationZ = this._target.rotationZ;
                  this._deltaRotationZ = this._rotationZ - this._startRotationZ;
               }
            }
            if(this._$$bezierX)
            {
               this._bezierX = [];
               this._bezierY = [];
               _loc2_ = this._$$bezierX.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  this._bezierX[_loc1_] = this._target.x + this._$$bezierX[_loc1_];
                  this._bezierY[_loc1_] = this._target.y + this._$$bezierY[_loc1_];
                  _loc1_++;
               }
            }
            if((this._bezierX) || (this._bezierY))
            {
               if(isNaN(this._x))
               {
                  this._x = this._startX = this._target.x;
                  this._deltaX = 0 + _loc3_;
               }
               if(isNaN(this._y))
               {
                  this._y = this._startY = this._target.y;
                  this._deltaY = 0 + _loc4_;
               }
            }
         }
         if((_tweenFlag & 1 << 13) && (this._fadeIn))
         {
            this._target.visible = true;
         }
         if(this._blendMode)
         {
            this._target.blendMode = this._blendMode;
         }
         if(this._useLayerBlend)
         {
            this._beforeBlend = this._target.blendMode;
            this._target.blendMode = "layer";
         }
         if((_tweenFlag & 1 << 14) && !this._mouseEnabled)
         {
            this._target.mouseEnabled = this._mouseEnabled;
         }
         if((_tweenFlag & 1 << 15) && !this._mouseChildren)
         {
            this._target.mouseChildren = this._mouseChildren;
         }
      }
      
      public function initByAlign() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         this._startX = this._targetDisplayObject.x;
         this._startY = this._targetDisplayObject.y;
         this._deltaX = 0;
         this._deltaY = 0;
         if((_tweenFlag & 1 << 4) || (_tweenFlag & 1 << 5))
         {
            this._scaleX = this._scaleY = 1;
            _loc1_ = this._targetDisplayObject.getRect(this._targetDisplayObject);
            if(_tweenFlag & 1 << 4)
            {
               this._scaleX = this._width / _loc1_.width;
            }
            if(_tweenFlag & 1 << 5)
            {
               this._scaleY = this._height / _loc1_.height;
            }
         }
         if((_tweenFlag & 1 << 6) || (_tweenFlag & 1 << 7) || (_tweenFlag & 1 << 4) || (_tweenFlag & 1 << 5))
         {
            this._startScaleX = this._targetDisplayObject.scaleX;
            this._startScaleY = this._targetDisplayObject.scaleY;
            this._deltaScaleX = this._deltaScaleY = 0;
            _loc2_ = this._targetDisplayObject.rotation * Math.PI / 180;
            _loc3_ = this._alignX * (this._startScaleX - this._scaleX);
            _loc4_ = this._alignY * (this._startScaleY - this._scaleY);
            _loc5_ = Math.sin(_loc2_);
            _loc6_ = Math.cos(_loc2_);
            this._alignOffsetByScaleX = _loc3_ * _loc6_ - _loc4_ * _loc5_;
            this._alignOffsetByScaleY = _loc3_ * _loc5_ + _loc4_ * _loc6_;
         }
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         if(this._targetDisplayObject)
         {
            _loc2_ = 0.0;
            _loc3_ = 0.0;
            if(this._align != 0)
            {
               if((_tweenFlag & 1 << 6) || (_tweenFlag & 1 << 7) || (_tweenFlag & 1 << 4) || (_tweenFlag & 1 << 5))
               {
                  if(!(_tweenFlag & 1 << 0))
                  {
                     _loc2_ = _loc2_ + this._alignOffsetByScaleX * param1;
                  }
                  if(!(_tweenFlag & 1 << 1))
                  {
                     _loc3_ = _loc3_ + this._alignOffsetByScaleY * param1;
                  }
               }
               if(_tweenFlag & 1 << 9)
               {
                  _loc4_ = this._alignX * this._targetDisplayObject.scaleX;
                  _loc5_ = this._alignY * this._targetDisplayObject.scaleY;
                  _loc6_ = this._startRotation / 180 * Math.PI;
                  _loc7_ = (this._startRotation + this._deltaRotation * param1) / 180 * Math.PI;
                  _loc8_ = _loc4_ * Math.cos(_loc6_) - _loc5_ * Math.sin(_loc6_);
                  _loc9_ = _loc4_ * Math.sin(_loc6_) + _loc5_ * Math.cos(_loc6_);
                  _loc10_ = _loc4_ * Math.cos(_loc7_) - _loc5_ * Math.sin(_loc7_);
                  _loc11_ = _loc4_ * Math.sin(_loc7_) + _loc5_ * Math.cos(_loc7_);
                  _loc2_ = _loc2_ + (_loc8_ - _loc10_);
                  _loc3_ = _loc3_ + (_loc9_ - _loc11_);
               }
            }
            if(this._bezierX != null)
            {
               this._targetDisplayObject.x = Util24.display.getBezier(this._startX,this._startX + this._deltaX,param1,this._bezierX) + _loc2_;
               this._targetDisplayObject.y = Util24.display.getBezier(this._startY,this._startY + this._deltaY,param1,this._bezierY) + _loc3_;
            }
            else
            {
               if((_tweenFlag & 1 << 0) || (this._align))
               {
                  this._targetDisplayObject.x = this._startX + this._deltaX * param1 + _loc2_;
               }
               if((_tweenFlag & 1 << 1) || (this._align))
               {
                  this._targetDisplayObject.y = this._startY + this._deltaY * param1 + _loc3_;
               }
            }
            if(_tweenFlag & 1 << 2)
            {
               this._target.z = this._startZ + this._deltaZ * param1;
            }
            if(_tweenFlag & 1 << 3)
            {
               this._targetDisplayObject.alpha = this._startAlpha + this._deltaAlpha * param1;
            }
            if(this._useSize)
            {
               if(_tweenFlag & 1 << 4)
               {
                  this._targetDisplayObject.width = this._startWidth + this._deltaWidth * param1;
               }
               if(_tweenFlag & 1 << 5)
               {
                  this._targetDisplayObject.height = this._startHeight + this._deltaHeight * param1;
               }
            }
            if(this._useScale)
            {
               if(_tweenFlag & 1 << 6)
               {
                  this._targetDisplayObject.scaleX = this._startScaleX + this._deltaScaleX * param1;
               }
               if(_tweenFlag & 1 << 7)
               {
                  this._targetDisplayObject.scaleY = this._startScaleY + this._deltaScaleY * param1;
               }
               if(_tweenFlag & 1 << 8)
               {
                  this._target.scaleZ = this._startScaleZ + this._deltaScaleZ * param1;
               }
            }
            if(this._useRotation)
            {
               if(_tweenFlag & 1 << 9)
               {
                  this._targetDisplayObject.rotation = this._startRotation + this._deltaRotation * param1;
               }
               if(_tweenFlag & 1 << 10)
               {
                  this._target.rotationX = this._startRotationX + this._deltaRotationX * param1;
               }
               if(_tweenFlag & 1 << 11)
               {
                  this._target.rotationY = this._startRotationY + this._deltaRotationY * param1;
               }
               if(_tweenFlag & 1 << 12)
               {
                  this._target.rotationZ = this._startRotationZ + this._deltaRotationZ * param1;
               }
            }
         }
         else
         {
            if(this._bezierX)
            {
               this._target.x = Util24.display.getBezier(this._startX,this._startX + this._deltaX,param1,this._bezierX);
               this._target.y = Util24.display.getBezier(this._startY,this._startY + this._deltaY,param1,this._bezierY);
            }
            else
            {
               if(_tweenFlag & 1 << 0)
               {
                  this._target.x = this._startX + this._deltaX * param1;
               }
               if(_tweenFlag & 1 << 1)
               {
                  this._target.y = this._startY + this._deltaY * param1;
               }
            }
            if(_tweenFlag & 1 << 2)
            {
               this._target.z = this._startZ + this._deltaZ * param1;
            }
            if(_tweenFlag & 1 << 3)
            {
               this._target.alpha = this._startAlpha + this._deltaAlpha * param1;
            }
            if(this._useSize)
            {
               if(_tweenFlag & 1 << 4)
               {
                  this._target.width = this._startWidth + this._deltaWidth * param1;
               }
               if(_tweenFlag & 1 << 5)
               {
                  this._target.height = this._startHeight + this._deltaHeight * param1;
               }
            }
            if(this._useScale)
            {
               if(_tweenFlag & 1 << 6)
               {
                  this._target.scaleX = this._startScaleX + this._deltaScaleX * param1;
               }
               if(_tweenFlag & 1 << 7)
               {
                  this._target.scaleY = this._startScaleY + this._deltaScaleY * param1;
               }
               if(_tweenFlag & 1 << 8)
               {
                  this._target.scaleZ = this._startScaleZ + this._deltaScaleZ * param1;
               }
            }
            if(this._useRotation)
            {
               if(_tweenFlag & 1 << 9)
               {
                  this._target.rotation = this._startRotation + this._deltaRotation * param1;
               }
               if(_tweenFlag & 1 << 10)
               {
                  this._target.rotationX = this._startRotationX + this._deltaRotationX * param1;
               }
               if(_tweenFlag & 1 << 11)
               {
                  this._target.rotationY = this._startRotationY + this._deltaRotationY * param1;
               }
               if(_tweenFlag & 1 << 12)
               {
                  this._target.rotationZ = this._startRotationZ + this._deltaRotationZ * param1;
               }
            }
         }
         return this;
      }
      
      override public function complete() : void
      {
         super.complete();
         if((_tweenFlag & 1 << 13) && (this._fadeOut))
         {
            this._target.visible = false;
         }
         if(this._useLayerBlend)
         {
            this._target.blendMode = this._beforeBlend;
         }
         if((_tweenFlag & 1 << 14) && (this._mouseEnabled))
         {
            this._target.mouseEnabled = this._mouseEnabled;
         }
         if((_tweenFlag & 1 << 15) && (this._mouseChildren))
         {
            this._target.mouseChildren = this._mouseChildren;
         }
      }
      
      public function clone() : DisplayObjectUpdater
      {
         var _loc1_:DisplayObjectUpdater = new DisplayObjectUpdater(this._target);
         _loc1_.setProp(this._x,this._y,this.z,this._alpha,this._width,this._height,this._scaleX,this._scaleY,this._scaleZ,this._rotation,this._rotationX,this._rotationY,this._rotationZ);
         _loc1_._$x = this._$x;
         _loc1_._$y = this._$y;
         _loc1_._$z = this._$z;
         _loc1_._$alpha = this._$alpha;
         _loc1_._$width = this._$width;
         _loc1_._$height = this._$height;
         _loc1_._$scaleX = this._$scaleX;
         _loc1_._$scaleY = this._$scaleY;
         _loc1_._$scaleZ = this._$scaleZ;
         _loc1_._$rotation = this._$rotation;
         _loc1_._$rotationX = this._$rotationX;
         _loc1_._$rotationY = this._$rotationY;
         _loc1_._$rotationZ = this._$rotationZ;
         _loc1_._$$x = this._$$x;
         _loc1_._$$y = this._$$y;
         _loc1_._$$z = this._$$z;
         _loc1_._$$alpha = this._$$alpha;
         _loc1_._$$width = this._$$width;
         _loc1_._$$height = this._$$height;
         _loc1_._$$scaleX = this._$$scaleX;
         _loc1_._$$scaleY = this._$$scaleY;
         _loc1_._$$scaleZ = this._$$scaleZ;
         _loc1_._$$rotation = this._$$rotation;
         _loc1_._$$rotationX = this._$$rotationX;
         _loc1_._$$rotationY = this._$$rotationY;
         _loc1_._$$rotationZ = this._$$rotationZ;
         _loc1_._updateFlag = _updateFlag;
         _loc1_._$updateFlag = _$updateFlag;
         _loc1_._$$updateFlag = _$$updateFlag;
         _loc1_._globalX = this._globalX;
         _loc1_._globalY = this._globalY;
         _loc1_._bezierX = this._bezierX;
         _loc1_._bezierY = this._bezierY;
         _loc1_._$$bezierX = this._$$bezierX;
         _loc1_._$$bezierY = this._$$bezierY;
         _loc1_._fadeIn = this._fadeIn;
         _loc1_._fadeOut = this._fadeOut;
         _loc1_._useLayerBlend = this._useLayerBlend;
         _loc1_._useGlobalLocal = this._useGlobalLocal;
         _loc1_._useLayerBlend = this._useLayerBlend;
         _loc1_._useRandom = this._useRandom;
         _loc1_._useRotation = this._useRotation;
         _loc1_._useScale = this._useScale;
         _loc1_._useSize = this._useSize;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "";
         var _loc2_:uint = _updateFlag | _$$updateFlag;
         if(_loc2_ & 1 << 0)
         {
            _loc1_ = "x:" + this._x + ", ";
         }
         if(_loc2_ & 1 << 1)
         {
            _loc1_ = "y:" + this._y + ", ";
         }
         if(_loc2_ & 1 << 2)
         {
            _loc1_ = "z:" + this._z + ", ";
         }
         if(_loc2_ & 1 << 3)
         {
            _loc1_ = "alpha:" + this._alpha + ", ";
         }
         if(_loc2_ & 1 << 4)
         {
            _loc1_ = "width:" + this._width + ", ";
         }
         if(_loc2_ & 1 << 5)
         {
            _loc1_ = "height:" + this._height + ", ";
         }
         if(_loc2_ & 1 << 6)
         {
            _loc1_ = "scaleX:" + this._scaleX + ", ";
         }
         if(_loc2_ & 1 << 7)
         {
            _loc1_ = "scaleY:" + this._scaleY + ", ";
         }
         if(_loc2_ & 1 << 8)
         {
            _loc1_ = "scaleZ:" + this._scaleZ + ", ";
         }
         if(_loc2_ & 1 << 9)
         {
            _loc1_ = "rotation:" + this._rotation + ", ";
         }
         if(_loc2_ & 1 << 10)
         {
            _loc1_ = "rotationX:" + this._rotationX + ", ";
         }
         if(_loc2_ & 1 << 11)
         {
            _loc1_ = "rotationY:" + this._rotationY + ", ";
         }
         if(_loc2_ & 1 << 12)
         {
            _loc1_ = "rotationZ:" + this._rotationZ + ", ";
         }
         if(_loc2_ & 1 << 14)
         {
            _loc1_ = "mouseEnabled:" + this._mouseEnabled + ", ";
         }
         if(_loc2_ & 1 << 15)
         {
            _loc1_ = "mouseChildren:" + this._mouseChildren + ", ";
         }
         return _loc1_.slice(0,-2);
      }
      
      public function getDistance() : Number
      {
         var _loc1_:Number = isNaN(this._deltaX)?0.0:this._deltaX;
         var _loc2_:Number = isNaN(this._deltaY)?0.0:this._deltaY;
         var _loc3_:Number = isNaN(this._deltaZ)?0.0:this._deltaZ;
         return Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      public function get align() : uint
      {
         return this._align;
      }
      
      public function set align(param1:uint) : void
      {
         this._align = param1;
      }
      
      public function get alignX() : Number
      {
         return this._alignX;
      }
      
      public function set alignX(param1:Number) : void
      {
         this._alignX = param1;
         this._align = Align24.SELECTED;
      }
      
      public function get alignY() : Number
      {
         return this._alignY;
      }
      
      public function set alignY(param1:Number) : void
      {
         this._alignY = param1;
         this._align = Align24.SELECTED;
      }
      
      public function get alignScaleX() : Number
      {
         return this._alignScaleX;
      }
      
      public function set alignScaleX(param1:Number) : void
      {
         this._alignScaleX = param1;
         this._align = Align24.SELECTED;
      }
      
      public function get alignScaleY() : Number
      {
         return this._alignScaleY;
      }
      
      public function set alignScaleY(param1:Number) : void
      {
         this._alignScaleY = param1;
         this._align = Align24.SELECTED;
      }
      
      public function get useLayerBlend() : Boolean
      {
         return this._useLayerBlend;
      }
      
      public function set useLayerBlend(param1:Boolean) : void
      {
         this._useLayerBlend = param1;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         this._blendMode = param1;
      }
      
      public function get globalX() : Number
      {
         return this._globalX;
      }
      
      public function set globalX(param1:Number) : void
      {
         this._globalX = param1;
         _updateFlag = _updateFlag | 1 << 0;
         this._useGlobalLocal = true;
      }
      
      public function get globalY() : Number
      {
         return this._globalY;
      }
      
      public function set globalY(param1:Number) : void
      {
         this._globalY = param1;
         _updateFlag = _updateFlag | 1 << 1;
         this._useGlobalLocal = true;
      }
      
      public function get localX() : Number
      {
         return this._localX;
      }
      
      public function set localX(param1:Number) : void
      {
         this._localX = param1;
         _updateFlag = _updateFlag | 1 << 0;
         this._useGlobalLocal = true;
      }
      
      public function get localY() : Number
      {
         return this._localY;
      }
      
      public function set localY(param1:Number) : void
      {
         this._localY = param1;
         _updateFlag = _updateFlag | 1 << 1;
         this._useGlobalLocal = true;
      }
      
      public function get localXTarget() : DisplayObject
      {
         return this._localXTarget;
      }
      
      public function set localXTarget(param1:DisplayObject) : void
      {
         this._localXTarget = param1;
      }
      
      public function get localYTarget() : DisplayObject
      {
         return this._localYTarget;
      }
      
      public function set localYTarget(param1:DisplayObject) : void
      {
         this._localYTarget = param1;
      }
      
      public function get randomMinX() : Number
      {
         return this._randomMinX;
      }
      
      public function set randomMinX(param1:Number) : void
      {
         this._randomMinX = param1;
         _updateFlag = _updateFlag | 1 << 0;
         this._useRandom = true;
      }
      
      public function get randomMaxX() : Number
      {
         return this._randomMaxX;
      }
      
      public function set randomMaxX(param1:Number) : void
      {
         this._randomMaxX = param1;
         this._useRandom = true;
      }
      
      public function get randomMinY() : Number
      {
         return this._randomMinY;
      }
      
      public function set randomMinY(param1:Number) : void
      {
         this._randomMinY = param1;
         _updateFlag = _updateFlag | 1 << 1;
         this._useRandom = true;
      }
      
      public function get randomMaxY() : Number
      {
         return this._randomMaxY;
      }
      
      public function set randomMaxY(param1:Number) : void
      {
         this._randomMaxY = param1;
         this._useRandom = true;
      }
      
      public function get randomMinZ() : Number
      {
         return this._randomMinZ;
      }
      
      public function set randomMinZ(param1:Number) : void
      {
         this._randomMinZ = param1;
         _updateFlag = _updateFlag | 1 << 2;
         this._useRandom = true;
      }
      
      public function get randomMaxZ() : Number
      {
         return this._randomMaxZ;
      }
      
      public function set randomMaxZ(param1:Number) : void
      {
         this._randomMaxZ = param1;
         this._useRandom = true;
      }
      
      public function get randomRound() : Boolean
      {
         return this._randomRound;
      }
      
      public function set randomRound(param1:Boolean) : void
      {
         this._randomRound = param1;
         this._useRandom = true;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         _updateFlag = _updateFlag | 1 << 1;
      }
      
      public function get z() : Number
      {
         return this._z;
      }
      
      public function set z(param1:Number) : void
      {
         this._z = param1;
         _updateFlag = _updateFlag | 1 << 2;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         _updateFlag = _updateFlag | 1 << 3;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
         _updateFlag = _updateFlag | 1 << 4;
         this._useSize = true;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
         _updateFlag = _updateFlag | 1 << 5;
         this._useSize = true;
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this._scaleX = param1;
         _updateFlag = _updateFlag | 1 << 6;
         this._useScale = true;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         this._scaleY = param1;
         _updateFlag = _updateFlag | 1 << 7;
         this._useScale = true;
      }
      
      public function get scaleZ() : Number
      {
         return this._scaleZ;
      }
      
      public function set scaleZ(param1:Number) : void
      {
         this._scaleZ = param1;
         _updateFlag = _updateFlag | 1 << 8;
         this._useScale = true;
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         this._rotation = param1;
         _updateFlag = _updateFlag | 1 << 9;
         this._useRotation = true;
      }
      
      public function get rotationX() : Number
      {
         return this._rotationX;
      }
      
      public function set rotationX(param1:Number) : void
      {
         this._rotationX = param1;
         _updateFlag = _updateFlag | 1 << 10;
         this._useRotation = true;
      }
      
      public function get rotationY() : Number
      {
         return this._rotationY;
      }
      
      public function set rotationY(param1:Number) : void
      {
         this._rotationY = param1;
         _updateFlag = _updateFlag | 1 << 11;
         this._useRotation = true;
      }
      
      public function get rotationZ() : Number
      {
         return this._rotationZ;
      }
      
      public function set rotationZ(param1:Number) : void
      {
         this._rotationZ = param1;
         _updateFlag = _updateFlag | 1 << 12;
         this._useRotation = true;
      }
      
      public function get fadeIn() : Boolean
      {
         return this._fadeIn;
      }
      
      public function set fadeIn(param1:Boolean) : void
      {
         this._fadeIn = param1;
         _updateFlag = _updateFlag | 1 << 13;
      }
      
      public function get fadeOut() : Boolean
      {
         return this._fadeOut;
      }
      
      public function set fadeOut(param1:Boolean) : void
      {
         this._fadeOut = param1;
         _updateFlag = _updateFlag | 1 << 13;
      }
      
      public function get mouseEnabled() : Boolean
      {
         return this._mouseEnabled;
      }
      
      public function set mouseEnabled(param1:Boolean) : void
      {
         this._mouseEnabled = param1;
         _updateFlag = _updateFlag | 1 << 14;
      }
      
      public function get mouseChildren() : Boolean
      {
         return this._mouseChildren;
      }
      
      public function set mouseChildren(param1:Boolean) : void
      {
         this._mouseChildren = param1;
         _updateFlag = _updateFlag | 1 << 15;
      }
      
      public function get $x() : Number
      {
         return this._$x;
      }
      
      public function set $x(param1:Number) : void
      {
         this._$x = param1;
         _$updateFlag = _$updateFlag | 1 << 0;
      }
      
      public function get $y() : Number
      {
         return this._$y;
      }
      
      public function set $y(param1:Number) : void
      {
         this._$y = param1;
         _$updateFlag = _$updateFlag | 1 << 1;
      }
      
      public function get $z() : Number
      {
         return this._$z;
      }
      
      public function set $z(param1:Number) : void
      {
         this._$z = param1;
         _$updateFlag = _$updateFlag | 1 << 2;
      }
      
      public function get $alpha() : Number
      {
         return this._$alpha;
      }
      
      public function set $alpha(param1:Number) : void
      {
         this._$alpha = param1;
         _$updateFlag = _$updateFlag | 1 << 3;
      }
      
      public function get $width() : Number
      {
         return this._$width;
      }
      
      public function set $width(param1:Number) : void
      {
         this._$width = param1;
         _$updateFlag = _$updateFlag | 1 << 4;
         this._useSize = true;
      }
      
      public function get $height() : Number
      {
         return this._$height;
      }
      
      public function set $height(param1:Number) : void
      {
         this._$height = param1;
         _$updateFlag = _$updateFlag | 1 << 5;
         this._useSize = true;
      }
      
      public function get $scaleX() : Number
      {
         return this._$scaleX;
      }
      
      public function set $scaleX(param1:Number) : void
      {
         this._$scaleX = param1;
         _$updateFlag = _$updateFlag | 1 << 6;
         this._useScale = true;
      }
      
      public function get $scaleY() : Number
      {
         return this._$scaleY;
      }
      
      public function set $scaleY(param1:Number) : void
      {
         this._$scaleY = param1;
         _$updateFlag = _$updateFlag | 1 << 7;
         this._useScale = true;
      }
      
      public function get $scaleZ() : Number
      {
         return this._$scaleZ;
      }
      
      public function set $scaleZ(param1:Number) : void
      {
         this._$scaleZ = param1;
         _$updateFlag = _$updateFlag | 1 << 8;
         this._useScale = true;
      }
      
      public function get $rotation() : Number
      {
         return this._$rotation;
      }
      
      public function set $rotation(param1:Number) : void
      {
         this._$rotation = param1;
         _$updateFlag = _$updateFlag | 1 << 9;
         this._useRotation = true;
      }
      
      public function get $rotationX() : Number
      {
         return this._$rotationX;
      }
      
      public function set $rotationX(param1:Number) : void
      {
         this._$rotationX = param1;
         _$updateFlag = _$updateFlag | 1 << 10;
         this._useRotation = true;
      }
      
      public function get $rotationY() : Number
      {
         return this._$rotationY;
      }
      
      public function set $rotationY(param1:Number) : void
      {
         this._$rotationY = param1;
         _$updateFlag = _$updateFlag | 1 << 11;
         this._useRotation = true;
      }
      
      public function get $rotationZ() : Number
      {
         return this._$rotationZ;
      }
      
      public function set $rotationZ(param1:Number) : void
      {
         this._$rotationZ = param1;
         _$updateFlag = _$updateFlag | 1 << 12;
         this._useRotation = true;
      }
      
      public function get $$x() : Number
      {
         return this._$$x;
      }
      
      public function set $$x(param1:Number) : void
      {
         this._$$x = param1;
         _$$updateFlag = _$$updateFlag | 1 << 0;
      }
      
      public function get $$y() : Number
      {
         return this._$$y;
      }
      
      public function set $$y(param1:Number) : void
      {
         this._$$y = param1;
         _$$updateFlag = _$$updateFlag | 1 << 1;
      }
      
      public function get $$z() : Number
      {
         return this._$$z;
      }
      
      public function set $$z(param1:Number) : void
      {
         this._$$z = param1;
         _$$updateFlag = _$$updateFlag | 1 << 2;
      }
      
      public function get $$alpha() : Number
      {
         return this._$$alpha;
      }
      
      public function set $$alpha(param1:Number) : void
      {
         this._$$alpha = param1;
         _$$updateFlag = _$$updateFlag | 1 << 3;
      }
      
      public function get $$width() : Number
      {
         return this._$$width;
      }
      
      public function set $$width(param1:Number) : void
      {
         this._$$width = param1;
         _$$updateFlag = _$$updateFlag | 1 << 4;
         this._useSize = true;
      }
      
      public function get $$height() : Number
      {
         return this._$$height;
      }
      
      public function set $$height(param1:Number) : void
      {
         this._$$height = param1;
         _$$updateFlag = _$$updateFlag | 1 << 5;
         this._useSize = true;
      }
      
      public function get $$scaleX() : Number
      {
         return this._$$scaleX;
      }
      
      public function set $$scaleX(param1:Number) : void
      {
         this._$$scaleX = param1;
         _$$updateFlag = _$$updateFlag | 1 << 6;
         this._useScale = true;
      }
      
      public function get $$scaleY() : Number
      {
         return this._$$scaleY;
      }
      
      public function set $$scaleY(param1:Number) : void
      {
         this._$$scaleY = param1;
         _$$updateFlag = _$$updateFlag | 1 << 7;
         this._useScale = true;
      }
      
      public function get $$scaleZ() : Number
      {
         return this._$$scaleZ;
      }
      
      public function set $$scaleZ(param1:Number) : void
      {
         this._$$scaleZ = param1;
         _$$updateFlag = _$$updateFlag | 1 << 8;
         this._useScale = true;
      }
      
      public function get $$rotation() : Number
      {
         return this._$$rotation;
      }
      
      public function set $$rotation(param1:Number) : void
      {
         this._$$rotation = param1;
         _$$updateFlag = _$$updateFlag | 1 << 9;
         this._useRotation = true;
      }
      
      public function get $$rotationX() : Number
      {
         return this._$$rotationX;
      }
      
      public function set $$rotationX(param1:Number) : void
      {
         this._$$rotationX = param1;
         _$$updateFlag = _$$updateFlag | 1 << 10;
         this._useRotation = true;
      }
      
      public function get $$rotationY() : Number
      {
         return this._$$rotationY;
      }
      
      public function set $$rotationY(param1:Number) : void
      {
         this._$$rotationY = param1;
         _$$updateFlag = _$$updateFlag | 1 << 11;
         this._useRotation = true;
      }
      
      public function get $$rotationZ() : Number
      {
         return this._$$rotationZ;
      }
      
      public function set $$rotationZ(param1:Number) : void
      {
         this._$$rotationZ = param1;
         _$$updateFlag = _$$updateFlag | 1 << 12;
         this._useRotation = true;
      }
   }
}
