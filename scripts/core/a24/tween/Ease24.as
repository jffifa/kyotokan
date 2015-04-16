package a24.tween
{
   import flash.geom.Point;
   
   public class Ease24 extends Object
   {
      
      public function Ease24()
      {
         super();
      }
      
      public static const _Linear:Function = linear;
      
      public static const _1_SineIn:Function = sineIn;
      
      public static const _1_SineOut:Function = sineOut;
      
      public static const _1_SineInOut:Function = sineInOut;
      
      public static const _1_SineOutIn:Function = sineOutIn;
      
      public static const _2_QuadIn:Function = quadIn;
      
      public static const _2_QuadOut:Function = quadOut;
      
      public static const _2_QuadInOut:Function = quadInOut;
      
      public static const _2_QuadOutIn:Function = quadOutIn;
      
      public static const _3_CubicIn:Function = cubicIn;
      
      public static const _3_CubicOut:Function = cubicOut;
      
      public static const _3_CubicInOut:Function = cubicInOut;
      
      public static const _3_CubicOutIn:Function = cubicOutIn;
      
      public static const _4_QuartIn:Function = quartIn;
      
      public static const _4_QuartOut:Function = quartOut;
      
      public static const _4_QuartInOut:Function = quartInOut;
      
      public static const _4_QuartOutIn:Function = quartOutIn;
      
      public static const _5_QuintIn:Function = quintIn;
      
      public static const _5_QuintOut:Function = quintOut;
      
      public static const _5_QuintInOut:Function = quintInOut;
      
      public static const _5_QuintOutIn:Function = quintOutIn;
      
      public static const _6_ExpoIn:Function = expoIn;
      
      public static const _6_ExpoOut:Function = expoOut;
      
      public static const _6_ExpoInOut:Function = expoInOut;
      
      public static const _6_ExpoOutIn:Function = expoOutIn;
      
      public static const _7_CircIn:Function = circIn;
      
      public static const _7_CircOut:Function = circOut;
      
      public static const _7_CircInOut:Function = circInOut;
      
      public static const _7_CircOutIn:Function = circOutIn;
      
      public static const _BackIn:Function = _BackInWith();
      
      public static const _BackOut:Function = _BackOutWith();
      
      public static const _BackInOut:Function = _BackInOutWith();
      
      public static const _BackOutIn:Function = _BackOutInWith();
      
      public static const _BounceIn:Function = bounceIn;
      
      public static const _BounceOut:Function = bounceOut;
      
      public static const _BounceInOut:Function = bounceInOut;
      
      public static const _BounceOutIn:Function = bounceOutIn;
      
      public static const _ElasticIn:Function = _ElasticInWith();
      
      public static const _ElasticOut:Function = _ElasticOutWith();
      
      public static const _ElasticInOut:Function = _ElasticInOutWith();
      
      public static const _ElasticOutIn:Function = _ElasticOutInWith();
      
      private static function linear(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * param1 / param4 + param2;
      }
      
      private static function sineIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * Math.cos(param1 / param4 * Math.PI / 2) + param3 + param2;
      }
      
      private static function sineOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * Math.sin(param1 / param4 * Math.PI / 2) + param2;
      }
      
      private static function sineInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 / 2 * (Math.cos(Math.PI * param1 / param4) - 1) + param2;
      }
      
      private static function sineOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param3 / 2 * Math.sin(param1 * 2 / param4 * Math.PI / 2) + param2;
         }
         return -(param3 / 2) * Math.cos((param1 * 2 - param4) / param4 * Math.PI / 2) + param3 / 2 + (param2 + param3 / 2);
      }
      
      private static function quadIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 + param2;
      }
      
      private static function quadOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
      
      private static function quadInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 + param2;
         }
         return -param3 / 2 * (--param1 * (param1 - 2) - 1) + param2;
      }
      
      private static function quadOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return -(param3 / 2) * (param1 = param1 * 2 / param4) * (param1 - 2) + param2;
         }
         return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 + (param2 + param3 / 2);
      }
      
      private static function cubicIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 + param2;
      }
      
      private static function cubicOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 + 1) + param2;
      }
      
      private static function cubicInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = param1 / (param4 / 2)) < 1?param3 / 2 * param1 * param1 * param1 + param2:param3 / 2 * ((param1 = param1 - 2) * param1 * param1 + 2) + param2;
      }
      
      private static function cubicOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 < param4 / 2?param3 / 2 * ((param1 = param1 * 2 / param4 - 1) * param1 * param1 + 1) + param2:param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 * param1 + param2 + param3 / 2;
      }
      
      private static function quartIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 * param1 + param2;
      }
      
      private static function quartOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 - 1) + param2;
      }
      
      private static function quartInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 + param2;
         }
         return -param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 - 2) + param2;
      }
      
      private static function quartOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return -(param3 / 2) * ((param1 = param1 * 2 / param4 - 1) * param1 * param1 * param1 - 1) + param2;
         }
         return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 * param1 * param1 + (param2 + param3 / 2);
      }
      
      private static function quintIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 * param1 * param1 + param2;
      }
      
      private static function quintOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
      }
      
      private static function quintInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 * param1 + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 * param1 + 2) + param2;
      }
      
      private static function quintOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param3 / 2 * ((param1 = param1 * 2 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
         }
         return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 * param1 * param1 * param1 + (param2 + param3 / 2);
      }
      
      private static function expoIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == 0?param2:param3 * Math.pow(2,10 * (param1 / param4 - 1)) + param2;
      }
      
      private static function expoOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == param4?param2 + param3:param3 * (1 - Math.pow(2,-10 * param1 / param4)) + param2;
      }
      
      private static function expoInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0)
         {
            return param2;
         }
         if(param1 == param4)
         {
            return param2 + param3;
         }
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * Math.pow(2,10 * (param1 - 1)) + param2;
         }
         return param3 / 2 * (2 - Math.pow(2,-10 * --param1)) + param2;
      }
      
      private static function expoOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param1 * 2 == param4?param2 + param3 / 2:param3 / 2 * (1 - Math.pow(2,-10 * param1 * 2 / param4)) + param2;
         }
         return param1 * 2 - param4 == 0?param2 + param3 / 2:param3 / 2 * Math.pow(2,10 * ((param1 * 2 - param4) / param4 - 1)) + param2 + param3 / 2;
      }
      
      private static function circIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * (Math.sqrt(1 - (param1 = param1 / param4) * param1) - 1) + param2;
      }
      
      private static function circOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * Math.sqrt(1 - (param1 = param1 / param4 - 1) * param1) + param2;
      }
      
      private static function circInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return -param3 / 2 * (Math.sqrt(1 - param1 * param1) - 1) + param2;
         }
         return param3 / 2 * (Math.sqrt(1 - (param1 = param1 - 2) * param1) + 1) + param2;
      }
      
      private static function circOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param3 / 2 * Math.sqrt(1 - (param1 = param1 * 2 / param4 - 1) * param1) + param2;
         }
         return -(param3 / 2) * (Math.sqrt(1 - (param1 = (param1 * 2 - param4) / param4) * param1) - 1) + (param2 + param3 / 2);
      }
      
      public static function _BackInWith(param1:Number = 1.70158) : Function
      {
         var overshoot:Number = param1;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            return param3 * (param1 = param1 / param4) * param1 * ((overshoot + 1) * param1 - overshoot) + param2;
         };
      }
      
      public static function _BackOutWith(param1:Number = 1.70158) : Function
      {
         var overshoot:Number = param1;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            return param3 * ((param1 = param1 / param4 - 1) * param1 * ((overshoot + 1) * param1 + overshoot) + 1) + param2;
         };
      }
      
      public static function _BackInOutWith(param1:Number = 1.70158) : Function
      {
         var overshoot:Number = param1;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            if((param1 = param1 / (param4 / 2)) < 1)
            {
               return param3 / 2 * param1 * param1 * ((overshoot * 1.525 + 1) * param1 - overshoot * 1.525) + param2;
            }
            return param3 / 2 * ((param1 = param1 - 2) * param1 * ((overshoot * 1.525 + 1) * param1 + overshoot * 1.525) + 2) + param2;
         };
      }
      
      public static function _BackOutInWith(param1:Number = 1.70158) : Function
      {
         var overshoot:Number = param1;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            if(param1 < param4 / 2)
            {
               return param3 / 2 * ((param1 = param1 * 2 / param4 - 1) * param1 * ((overshoot + 1) * param1 + overshoot) + 1) + param2;
            }
            return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 * ((overshoot + 1) * param1 - overshoot) + (param2 + param3 / 2);
         };
      }
      
      private static function bounceIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = (param4 - param1) / param4) < 1 / 2.75)
         {
            return param3 - param3 * 7.5625 * param1 * param1 + param2;
         }
         if(param1 < 2 / 2.75)
         {
            return param3 - param3 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) + param2;
         }
         if(param1 < 2.5 / 2.75)
         {
            return param3 - param3 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) + param2;
         }
         return param3 - param3 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) + param2;
      }
      
      private static function bounceOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / param4) < 1 / 2.75)
         {
            return param3 * 7.5625 * param1 * param1 + param2;
         }
         if(param1 < 2 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) + param2;
         }
         if(param1 < 2.5 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) + param2;
         }
         return param3 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) + param2;
      }
      
      private static function bounceInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            if((param1 = (param4 - param1 * 2) / param4) < 1 / 2.75)
            {
               return (param3 - param3 * 7.5625 * param1 * param1) * 0.5 + param2;
            }
            if(param1 < 2 / 2.75)
            {
               return (param3 - param3 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75)) * 0.5 + param2;
            }
            if(param1 < 2.5 / 2.75)
            {
               return (param3 - param3 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375)) * 0.5 + param2;
            }
            return (param3 - param3 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375)) * 0.5 + param2;
         }
         if((param1 = (param1 * 2 - param4) / param4) < 1 / 2.75)
         {
            return param3 * 7.5625 * param1 * param1 * 0.5 + param3 * 0.5 + param2;
         }
         if(param1 < 2 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) * 0.5 + param3 * 0.5 + param2;
         }
         if(param1 < 2.5 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) * 0.5 + param3 * 0.5 + param2;
         }
         return param3 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) * 0.5 + param3 * 0.5 + param2;
      }
      
      private static function bounceOutIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            if((param1 = param1 * 2 / param4) < 1 / 2.75)
            {
               return param3 / 2 * 7.5625 * param1 * param1 + param2;
            }
            if(param1 < 2 / 2.75)
            {
               return param3 / 2 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) + param2;
            }
            if(param1 < 2.5 / 2.75)
            {
               return param3 / 2 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) + param2;
            }
            return param3 / 2 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) + param2;
         }
         if((param1 = (param4 - (param1 * 2 - param4)) / param4) < 1 / 2.75)
         {
            return param3 / 2 - param3 / 2 * 7.5625 * param1 * param1 + (param2 + param3 / 2);
         }
         if(param1 < 2 / 2.75)
         {
            return param3 / 2 - param3 / 2 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) + (param2 + param3 / 2);
         }
         if(param1 < 2.5 / 2.75)
         {
            return param3 / 2 - param3 / 2 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) + (param2 + param3 / 2);
         }
         return param3 / 2 - param3 / 2 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) + (param2 + param3 / 2);
      }
      
      public static function _ElasticInWith(param1:Number = 0, param2:Number = 0) : Function
      {
         var amplitude:Number = param1;
         var period:Number = param2;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = undefined;
            var param1:Number = param1 / 1000;
            var param4:Number = param4 / 1000;
            if(param1 == 0)
            {
               return param2;
            }
            if((param1 = param1 / param4) == 1)
            {
               return param2 + param3;
            }
            if(!period)
            {
               period = param4 * 0.3;
            }
            if(!amplitude || amplitude < Math.abs(param3))
            {
               amplitude = param3;
               _loc5_ = period / 4;
            }
            else
            {
               _loc5_ = period / (2 * Math.PI) * Math.asin(param3 / amplitude);
            }
            return -(amplitude * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period)) + param2;
         };
      }
      
      public static function _ElasticOutWith(param1:Number = 0, param2:Number = 0) : Function
      {
         var amplitude:Number = param1;
         var period:Number = param2;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = undefined;
            var param1:Number = param1 / 1000;
            var param4:Number = param4 / 1000;
            if(param1 == 0)
            {
               return param2;
            }
            if((param1 = param1 / param4) == 1)
            {
               return param2 + param3;
            }
            if(!period)
            {
               period = param4 * 0.3;
            }
            if(!amplitude || amplitude < Math.abs(param3))
            {
               amplitude = param3;
               _loc5_ = period / 4;
            }
            else
            {
               _loc5_ = period / (2 * Math.PI) * Math.asin(param3 / amplitude);
            }
            return amplitude * Math.pow(2,-10 * param1) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period) + param3 + param2;
         };
      }
      
      public static function _ElasticInOutWith(param1:Number = 0, param2:Number = 0) : Function
      {
         var amplitude:Number = param1;
         var period:Number = param2;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = undefined;
            var param1:Number = param1 / 1000;
            var param4:Number = param4 / 1000;
            if(param1 == 0)
            {
               return param2;
            }
            if((param1 = param1 / (param4 / 2)) == 2)
            {
               return param2 + param3;
            }
            if(!period)
            {
               period = param4 * 0.3 * 1.5;
            }
            if(!amplitude || amplitude < Math.abs(param3))
            {
               amplitude = param3;
               _loc5_ = period / 4;
            }
            else
            {
               _loc5_ = period / (2 * Math.PI) * Math.asin(param3 / amplitude);
            }
            if(param1 < 1)
            {
               return -0.5 * amplitude * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period) + param2;
            }
            return amplitude * Math.pow(2,-10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period) * 0.5 + param3 + param2;
         };
      }
      
      public static function _ElasticOutInWith(param1:Number = 0, param2:Number = 0) : Function
      {
         var amplitude:Number = param1;
         var period:Number = param2;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = undefined;
            var param1:Number = param1 / 1000;
            var param4:Number = param4 / 1000;
            var param3:Number = param3 / 2;
            if(param1 < param4 / 2)
            {
               if((param1 = param1 * 2) == 0)
               {
                  return param2;
               }
               if((param1 = param1 / param4) == 1)
               {
                  return param2 + param3;
               }
               if(!period)
               {
                  period = param4 * 0.3;
               }
               if(!amplitude || amplitude < Math.abs(param3))
               {
                  amplitude = param3;
                  _loc5_ = period / 4;
               }
               else
               {
                  _loc5_ = period / (2 * Math.PI) * Math.asin(param3 / amplitude);
               }
               return amplitude * Math.pow(2,-10 * param1) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period) + param3 + param2;
            }
            if((param1 = param1 * 2 - param4) == 0)
            {
               return param2 + param3;
            }
            if((param1 = param1 / param4) == 1)
            {
               return param2 + param3 + param3;
            }
            if(!period)
            {
               period = param4 * 0.3;
            }
            if(!amplitude || amplitude < Math.abs(param3))
            {
               amplitude = param3;
               _loc5_ = period / 4;
            }
            else
            {
               _loc5_ = period / (2 * Math.PI) * Math.asin(param3 / amplitude);
            }
            return -(amplitude * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc5_) * 2 * Math.PI / period)) + (param2 + param3);
         };
      }
      
      public static function custom(param1:Array) : Function
      {
         var points:Array = param1;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = 0;
            while(_loc5_ < points.length - 1)
            {
               if(param1 / param4 >= points[_loc5_].point[0] && param1 / param4 <= points[_loc5_ + 1].point[0])
               {
                  return param3 * getYForX(param1 / param4,new Point(points[_loc5_].point[0],points[_loc5_].point[1]),new Point(points[_loc5_].post[0],points[_loc5_].post[1]),new Point(points[_loc5_ + 1].pre[0],points[_loc5_ + 1].pre[1]),new Point(points[_loc5_ + 1].point[0],points[_loc5_ + 1].point[1])) + param2;
               }
               _loc5_++;
            }
            return NaN;
         };
      }
      
      public static function blend(param1:Function, param2:Function, param3:Function = null, param4:Number = 0, param5:Number = 1) : Function
      {
         var easeA:Function = param1;
         var easeB:Function = param2;
         var mixing:Function = param3;
         var start:Number = param4;
         var end:Number = param5;
         mixing = mixing || linear;
         return function(param1:Number, param2:Number, param3:Number, param4:Number):Number
         {
            var _loc5_:* = easeA(param1,param2,param3,param4);
            var _loc6_:* = easeB(param1,param2,param3,param4);
            var _loc7_:* = mixing(param1,param2,param3,param4);
            var _loc8_:* = end - start;
            return _loc5_ + (_loc6_ - _loc5_) * (_loc7_ * _loc8_ + start);
         };
      }
      
      private static function getYForX(param1:Number, param2:Point, param3:Point, param4:Point, param5:Point) : Number
      {
         var _loc10_:* = NaN;
         if(param2.x < param5.x)
         {
            if(param1 <= param2.x + 1.0E-16)
            {
               return param2.y;
            }
            if(param1 >= param5.x - 1.0E-16)
            {
               return param5.y;
            }
         }
         else
         {
            if(param1 >= param2.x + 1.0E-16)
            {
               return param2.y;
            }
            if(param1 <= param5.x - 1.0E-16)
            {
               return param5.y;
            }
         }
         var _loc6_:Array = getCubicCoefficients(param2.x,param3.x,param4.x,param5.x);
         var _loc7_:Array = getCubicRoots(_loc6_[0],_loc6_[1],_loc6_[2],_loc6_[3] - param1);
         var _loc8_:Number = NaN;
         if(_loc7_.length == 0)
         {
            _loc8_ = 0.0;
         }
         else if(_loc7_.length == 1)
         {
            _loc8_ = _loc7_[0];
         }
         else
         {
            for each(_loc10_ in _loc7_)
            {
               if(0 <= _loc10_ && _loc10_ <= 1)
               {
                  _loc8_ = _loc10_;
                  break;
               }
            }
         }
         
         if(isNaN(_loc8_))
         {
            return NaN;
         }
         var _loc9_:Number = getSingleValue(_loc8_,param2.y,param3.y,param4.y,param5.y);
         return _loc9_;
      }
      
      private static function getCubicCoefficients(param1:Number, param2:Number, param3:Number, param4:Number) : Array
      {
         return [-param1 + 3 * param2 - 3 * param3 + param4,3 * param1 - 6 * param2 + 3 * param3,-3 * param1 + 3 * param2,param1];
      }
      
      private static function getCubicRoots(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : Array
      {
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = 0;
         var _loc16_:* = NaN;
         if(!param1)
         {
            return getQuadraticRoots(param2,param3,param4);
         }
         if(param1 != 1)
         {
            var param2:Number = param2 / param1;
            var param3:Number = param3 / param1;
            var param4:Number = param4 / param1;
         }
         var _loc5_:* = (param2 * param2 - 3 * param3) / 9;
         var _loc6_:Number = _loc5_ * _loc5_ * _loc5_;
         var _loc7_:Number = (2 * param2 * param2 * param2 - 9 * param2 * param3 + 27 * param4) / 54;
         var _loc8_:Number = _loc6_ - _loc7_ * _loc7_;
         if(_loc8_ >= 0)
         {
            if(!_loc5_)
            {
               return [0];
            }
            _loc9_ = Math.acos(_loc7_ / Math.sqrt(_loc6_));
            _loc10_ = Math.sqrt(_loc5_);
            _loc11_ = -2 * _loc10_ * Math.cos(_loc9_ / 3) - param2 / 3;
            _loc12_ = -2 * _loc10_ * Math.cos((_loc9_ + 2 * Math.PI) / 3) - param2 / 3;
            _loc13_ = -2 * _loc10_ * Math.cos((_loc9_ + 4 * Math.PI) / 3) - param2 / 3;
            return [_loc11_,_loc12_,_loc13_];
         }
         _loc14_ = Math.pow(Math.sqrt(-_loc8_) + Math.abs(_loc7_),1 / 3);
         _loc15_ = _loc7_ > 0?1:_loc7_ < 0?-1:0;
         _loc16_ = -_loc15_ * (_loc14_ + _loc5_ / _loc14_) - param2 / 3;
         return [_loc16_];
      }
      
      private static function getSingleValue(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0) : Number
      {
         return (param1 * param1 * (param5 - param2) + 3 * (1 - param1) * (param1 * (param4 - param2) + (1 - param1) * (param3 - param2))) * param1 + param2;
      }
      
      private static function getQuadraticRoots(param1:Number, param2:Number, param3:Number) : Array
      {
         var _loc7_:* = NaN;
         var _loc4_:Array = [];
         if(!param1)
         {
            if(!param2)
            {
               return [];
            }
            _loc4_[0] = -param3 / param2;
            return _loc4_;
         }
         var _loc5_:Number = param2 * param2 - 4 * param1 * param3;
         var _loc6_:int = _loc5_ > 0?1:_loc5_ < 0?-1:0;
         if(_loc6_ < 0)
         {
            return [];
         }
         if(!_loc6_)
         {
            _loc4_[0] = -param2 / (2 * param1);
         }
         else
         {
            _loc4_[0] = _loc4_[1] = -param2 / (2 * param1);
            _loc7_ = Math.sqrt(_loc5_) / (2 * param1);
            _loc4_[0] = _loc4_[0] - _loc7_;
            _loc4_[1] = _loc4_[1] + _loc7_;
         }
         return _loc4_;
      }
      
      public function get Linear() : Function
      {
         return linear;
      }
      
      public function get SineIn() : Function
      {
         return sineIn;
      }
      
      public function get SineOut() : Function
      {
         return sineOut;
      }
      
      public function get SineInOut() : Function
      {
         return sineInOut;
      }
      
      public function get SineOutIn() : Function
      {
         return sineOutIn;
      }
      
      public function get QuadIn() : Function
      {
         return quadIn;
      }
      
      public function get QuadOut() : Function
      {
         return quadOut;
      }
      
      public function get QuadInOut() : Function
      {
         return quadInOut;
      }
      
      public function get QuadOutIn() : Function
      {
         return quadOutIn;
      }
      
      public function get CubicIn() : Function
      {
         return cubicIn;
      }
      
      public function get CubicOut() : Function
      {
         return cubicOut;
      }
      
      public function get CubicInOut() : Function
      {
         return cubicInOut;
      }
      
      public function get CubicOutIn() : Function
      {
         return cubicOutIn;
      }
      
      public function get QuintIn() : Function
      {
         return quintIn;
      }
      
      public function get QuintOut() : Function
      {
         return quintOut;
      }
      
      public function get QuintInOut() : Function
      {
         return quintInOut;
      }
      
      public function get QuintOutIn() : Function
      {
         return quintOutIn;
      }
      
      public function get QuartIn() : Function
      {
         return quartIn;
      }
      
      public function get QuartOut() : Function
      {
         return quartOut;
      }
      
      public function get QuartInOut() : Function
      {
         return quartInOut;
      }
      
      public function get QuartOutIn() : Function
      {
         return quartOutIn;
      }
      
      public function get ExpoIn() : Function
      {
         return expoIn;
      }
      
      public function get ExpoOut() : Function
      {
         return expoOut;
      }
      
      public function get ExpoInOut() : Function
      {
         return expoInOut;
      }
      
      public function get ExpoOutIn() : Function
      {
         return expoOutIn;
      }
      
      public function get CircIn() : Function
      {
         return circIn;
      }
      
      public function get CircOut() : Function
      {
         return circOut;
      }
      
      public function get CircInOut() : Function
      {
         return circInOut;
      }
      
      public function get CircOutIn() : Function
      {
         return circOutIn;
      }
      
      public function get BackIn() : Function
      {
         return _BackInWith();
      }
      
      public function get BackOut() : Function
      {
         return _BackOutWith();
      }
      
      public function get BackInOut() : Function
      {
         return _BackInOutWith();
      }
      
      public function get BackOutIn() : Function
      {
         return _BackOutInWith();
      }
      
      public function get BounceIn() : Function
      {
         return bounceIn;
      }
      
      public function get BounceOut() : Function
      {
         return bounceOut;
      }
      
      public function get BounceInOut() : Function
      {
         return bounceInOut;
      }
      
      public function get BounceOutIn() : Function
      {
         return bounceOutIn;
      }
      
      public function get ElasticIn() : Function
      {
         return _ElasticInWith();
      }
      
      public function get ElasticOut() : Function
      {
         return _ElasticOutWith();
      }
      
      public function get ElasticInOut() : Function
      {
         return _ElasticInOutWith();
      }
      
      public function get ElasticOutIn() : Function
      {
         return _ElasticOutInWith();
      }
      
      public function BackInWith(param1:Number = 1.70158) : Function
      {
         return _BackInWith(param1);
      }
      
      public function BackOutWith(param1:Number = 1.70158) : Function
      {
         return _BackOutWith(param1);
      }
      
      public function BackInOutWith(param1:Number = 1.70158) : Function
      {
         return _BackInOutWith(param1);
      }
      
      public function BackOutInWith(param1:Number = 1.70158) : Function
      {
         return _BackOutInWith(param1);
      }
      
      public function ElasticInWith(param1:Number = 0, param2:Number = 0) : Function
      {
         return _ElasticInWith(param1,param2);
      }
      
      public function ElasticOutWith(param1:Number = 0, param2:Number = 0) : Function
      {
         return _ElasticOutWith(param1,param2);
      }
      
      public function ElasticInOutWith(param1:Number = 0, param2:Number = 0) : Function
      {
         return _ElasticInOutWith(param1,param2);
      }
      
      public function ElasticOutInWith(param1:Number = 0, param2:Number = 0) : Function
      {
         return _ElasticOutInWith(param1,param2);
      }
   }
}
