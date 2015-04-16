package port.views.jukebox
{
   import res.port.MCJukeboxCell;
   import common.models.JukeBGMObject;
   
   public class JukeBoxListCell extends MCJukeboxCell
   {
      
      public function JukeBoxListCell()
      {
         super();
         this.stop();
      }
      
      public function setData(param1:JukeBGMObject) : void
      {
         if(param1 != null)
         {
            this.titleBox.text = param1.name;
            this.infoBox.text = param1.description;
            this.valueBox.text = param1.fCoin.toString();
         }
      }
   }
}
