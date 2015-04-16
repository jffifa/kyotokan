package a24.util
{
   public final class Util24 extends Object
   {
      
      public function Util24()
      {
         super();
      }
      
      public static function get array() : ArrayUtil24
      {
         return _array;
      }
      
      private static var _array:ArrayUtil24 = new ArrayUtil24();
      
      public static function get bitmap() : BitmapUtil24
      {
         return _bitmap;
      }
      
      private static var _bitmap:BitmapUtil24 = new BitmapUtil24();
      
      public static function get clazz() : ClassUtil24
      {
         return _class;
      }
      
      private static var _class:ClassUtil24 = new ClassUtil24();
      
      public static function get display() : DisplayUtil24
      {
         return _display;
      }
      
      private static var _display:DisplayUtil24 = new DisplayUtil24();
      
      public static function get graphics() : GraphicsUtil24
      {
         return _graphics;
      }
      
      private static var _graphics:GraphicsUtil24 = new GraphicsUtil24();
      
      public static function get math() : MathUtil24
      {
         return _math;
      }
      
      private static var _math:MathUtil24 = new MathUtil24();
      
      public static function get text() : TextUtil24
      {
         return _text;
      }
      
      private static var _text:TextUtil24 = new TextUtil24();
      
      public static function get timeline() : TimelineUtil24
      {
         return _timeline;
      }
      
      private static var _timeline:TimelineUtil24 = new TimelineUtil24();
   }
}
