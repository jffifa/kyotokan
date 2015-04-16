package a24.tween.plugins.proxy
{
   public class PluginProxy extends Object
   {
      
      public function PluginProxy()
      {
         super();
         this._matrix = new MatrixPluginProxy();
         this._social = new SocialPulginProxy();
         this._soundMixer = new SoundMixerPluginProxy();
         this._sound = new SoundPulginProxy();
         this._timeline = new TimelinePluginProxy();
         this._text = new TextPulginProxy();
      }
      
      public function get matrix() : MatrixPluginProxy
      {
         return this._matrix;
      }
      
      private var _matrix:MatrixPluginProxy;
      
      public function get social() : SocialPulginProxy
      {
         return this._social;
      }
      
      private var _social:SocialPulginProxy;
      
      public function get soundMixer() : SoundMixerPluginProxy
      {
         return this._soundMixer;
      }
      
      private var _soundMixer:SoundMixerPluginProxy;
      
      public function get sound() : SoundPulginProxy
      {
         return this._sound;
      }
      
      private var _sound:SoundPulginProxy;
      
      public function get text() : TextPulginProxy
      {
         return this._text;
      }
      
      private var _text:TextPulginProxy;
      
      public function get timeline() : TimelinePluginProxy
      {
         return this._timeline;
      }
      
      private var _timeline:TimelinePluginProxy;
   }
}
