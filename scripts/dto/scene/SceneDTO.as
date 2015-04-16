package dto.scene
{
   import vo.BaseData;
   import scene.ISceneDTO;
   
   public class SceneDTO extends BaseData implements ISceneDTO
   {
      
      public function SceneDTO(param1:Object = null)
      {
         super();
         _o = param1 != null?param1:{};
      }
      
      protected var _o:Object;
      
      public function createObject() : Object
      {
         return _o;
      }
   }
}
