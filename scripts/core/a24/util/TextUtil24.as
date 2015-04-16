package a24.util
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.events.FocusEvent;
   import flash.system.Capabilities;
   import flash.system.IME;
   import flash.system.IMEConversionMode;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public final class TextUtil24 extends Object
   {
      
      public function TextUtil24()
      {
         super();
      }
      
      public function setTextSize(param1:TextField, param2:Number) : TextField
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.size = param2;
         param1.defaultTextFormat = _loc3_;
         return param1;
      }
      
      public function setLeading(param1:TextField, param2:Number = 0) : TextField
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.leading = param2;
         param1.defaultTextFormat = _loc3_;
         return param1;
      }
      
      public function setLetterSpacing(param1:TextField, param2:Number = 0) : TextField
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.letterSpacing = param2;
         param1.defaultTextFormat = _loc3_;
         return param1;
      }
      
      public function setUnderline(param1:TextField, param2:Boolean = true) : TextField
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.underline = param2;
         param1.defaultTextFormat = _loc3_;
         return param1;
      }
      
      public function restrictPostcode(param1:TextField) : TextField
      {
         param1.restrict = "0-9-";
         return param1;
      }
      
      public function restrictEnglish(param1:TextField) : TextField
      {
         param1.restrict = "a-zA-Z";
         return param1;
      }
      
      public function restrictEnglishNum(param1:TextField) : TextField
      {
         param1.restrict = "a-zA-Z0-9";
         return param1;
      }
      
      public function restrictMailAddress(param1:TextField) : TextField
      {
         param1.restrict = "a-zA-Z0-9-_.@";
         return param1;
      }
      
      public function restrictJapanese(param1:TextField) : TextField
      {
         param1.restrict = "ぁ-ん/ァ-ン/一-龥/ 　";
         return param1;
      }
      
      public function inputModeEnglish(param1:TextField) : TextField
      {
         var tf:TextField = param1;
         tf.addEventListener(FocusEvent.FOCUS_IN,function():void
         {
            if(Capabilities.hasIME)
            {
               try
               {
                  IME.enabled = false;
               }
               catch(err:Error)
               {
               }
            }
         });
         return tf;
      }
      
      public function inputModeJapanese(param1:TextField) : TextField
      {
         var tf:TextField = param1;
         tf.addEventListener(FocusEvent.FOCUS_IN,function():void
         {
            if(Capabilities.hasIME)
            {
               try
               {
                  IME.conversionMode = IMEConversionMode.JAPANESE_HIRAGANA;
               }
               catch(err:Error)
               {
               }
            }
         });
         return tf;
      }
      
      public function defaultInputText(param1:TextField, param2:String, param3:uint = 10066329) : TextField
      {
         var c:uint = 0;
         var tf:TextField = param1;
         var text:String = param2;
         var textColor:uint = param3;
         c = tf.textColor;
         tf.textColor = textColor;
         tf.text = text;
         tf.addEventListener(FocusEvent.FOCUS_IN,function():void
         {
            if(tf.text == text)
            {
               tf.textColor = c;
               tf.text = "";
            }
         });
         tf.addEventListener(FocusEvent.FOCUS_OUT,function():void
         {
            if(!tf.text.length)
            {
               tf.textColor = textColor;
               tf.text = text;
            }
         });
         return tf;
      }
      
      public function enterAndFocus(param1:TextField, param2:TextField) : TextField
      {
         var tf:TextField = param1;
         var next:TextField = param2;
         tf.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               tf.stage.focus = next;
            }
         });
         return tf;
      }
      
      public function enterAndFunc(param1:TextField, param2:Function) : TextField
      {
         var tf:TextField = param1;
         var func:Function = param2;
         tf.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               func();
            }
         });
         return tf;
      }
      
      public function isMailAddress(param1:String) : Boolean
      {
         return !(param1.match(new RegExp("^([a-z0-9_]|\\-|\\.|\\+)+@(([a-z0-9_]|\\-)+\\.)+[a-z]{2,6}$","i")) == null);
      }
   }
}
