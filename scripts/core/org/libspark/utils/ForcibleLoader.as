package org.libspark.utils
{
   import flash.display.Loader;
   import flash.net.URLStream;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.system.LoaderContext;
   import flash.errors.EOFError;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   
   public class ForcibleLoader extends Object
   {
      
      public function ForcibleLoader(param1:Loader)
      {
         super();
         this.loader = param1;
         _stream = new URLStream();
         _stream.addEventListener("complete",completeHandler);
         _stream.addEventListener("ioError",ioErrorHandler);
         _stream.addEventListener("securityError",securityErrorHandler);
      }
      
      private var _loader:Loader;
      
      private var _stream:URLStream;
      
      public function get loader() : Loader
      {
         return _loader;
      }
      
      public function set loader(param1:Loader) : void
      {
         _loader = param1;
      }
      
      public function load(param1:URLRequest) : void
      {
         _stream.load(param1);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _stream.readBytes(_loc2_);
         _stream.close();
         _loc2_.endian = "littleEndian";
         if(isCompressed(_loc2_))
         {
            uncompress(_loc2_);
         }
         var _loc4_:uint = _loc2_[3];
         if(_loc4_ < 9)
         {
            updateVersion(_loc2_,9);
         }
         if(_loc4_ > 7)
         {
            flagSWF9Bit(_loc2_);
         }
         else
         {
            insertFileAttributesTag(_loc2_);
         }
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.allowCodeImport = true;
         loader.loadBytes(_loc2_,_loc3_);
      }
      
      private function isCompressed(param1:ByteArray) : Boolean
      {
         return param1[0] == 67;
      }
      
      private function uncompress(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,8);
         param1.length = 8;
         param1.position = 8;
         _loc2_.uncompress();
         param1.writeBytes(_loc2_);
         param1[0] = 70;
         _loc2_.length = 0;
      }
      
      private function getBodyPosition(param1:ByteArray) : uint
      {
         var _loc3_:uint = 0;
         _loc3_ = _loc3_ + 3;
         _loc3_ = _loc3_ + 1;
         _loc3_ = _loc3_ + 4;
         var _loc2_:uint = param1[_loc3_] >>> 3;
         _loc3_ = _loc3_ + (5 + _loc2_ * 4) / 8;
         _loc3_ = _loc3_ + 2;
         _loc3_ = _loc3_ + 1;
         _loc3_ = _loc3_ + 2;
         return _loc3_;
      }
      
      private function findFileAttributesPosition(param1:uint, param2:ByteArray) : int
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         param2.position = param1;
         try
         {
            while(true)
            {
               _loc3_ = param2.readShort();
               _loc4_ = _loc3_ >>> 6;
               if(_loc4_ == 69)
               {
                  break;
               }
               _loc5_ = _loc3_ & 63;
               if(_loc5_ == 63)
               {
                  _loc5_ = param2.readInt();
               }
               param2.position = param2.position + _loc5_;
            }
            var _loc7_:* = param2.position - 2;
            return _loc7_;
         }
         catch(e:EOFError)
         {
         }
         return -1;
      }
      
      private function flagSWF9Bit(param1:ByteArray) : void
      {
         var _loc2_:int = findFileAttributesPosition(getBodyPosition(param1),param1);
         if(_loc2_ != -1)
         {
            var _loc3_:* = _loc2_ + 2;
            var _loc4_:* = param1[_loc3_] | 8;
            param1[_loc3_] = _loc4_;
         }
         else
         {
            insertFileAttributesTag(param1);
         }
      }
      
      private function insertFileAttributesTag(param1:ByteArray) : void
      {
         var _loc3_:uint = getBodyPosition(param1);
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,_loc3_);
         param1.length = _loc3_;
         param1.position = _loc3_;
         param1.writeByte(68);
         param1.writeByte(17);
         param1.writeByte(8);
         param1.writeByte(0);
         param1.writeByte(0);
         param1.writeByte(0);
         param1.writeBytes(_loc2_);
         _loc2_.length = 0;
      }
      
      private function updateVersion(param1:ByteArray, param2:uint) : void
      {
         param1[3] = param2;
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         loader.dispatchEvent(param1.clone());
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         loader.dispatchEvent(param1.clone());
      }
   }
}
