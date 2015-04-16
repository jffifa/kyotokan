package
{
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.display.MovieClip;
   import flash.media.Sound;
   
   public class Assets extends EventDispatcher
   {
      
      public function Assets()
      {
         super();
      }
      
      public static function get BGM_bokou2() : Class
      {
         return _getBGMCls("res.sounds.BGM_KanColle_BGM1");
      }
      
      public static function get BGM_Sally_ID() : String
      {
         return "103";
      }
      
      public static function get BGM_Interior_ID() : String
      {
         return "104";
      }
      
      public static function get BGM_SummerEventMap_ID() : String
      {
         return "120";
      }
      
      public static function get SE_system10() : Class
      {
         return _getSECls("res.sounds.SE_system10");
      }
      
      public static function get SE_system23() : Class
      {
         return _getSECls("res.sounds.SE_system23");
      }
      
      public static function get SE_lock_on() : Class
      {
         return _getSECls("res.sounds.SE_lock");
      }
      
      public static function get SE_lock_off() : Class
      {
         return _getSECls("res.sounds.SE_unlock2");
      }
      
      public static function get SE_mamiya() : Class
      {
         return _getSECls("res.sounds.SE_savepoint");
      }
      
      public static function get SE_carclose() : Class
      {
         return _getSECls("res.sounds.SE_carclose");
      }
      
      public static function get SE_kin() : Class
      {
         return _getSECls("res.sounds.SE_kin");
      }
      
      public static function get SE_Fire01_11() : Class
      {
         return _getSECls("res.sounds.SE_Fire01_11");
      }
      
      public static function get SE_paper01() : Class
      {
         return _getSECls("res.sounds.SE_paper01");
      }
      
      public static function get SE_mistake() : Class
      {
         return _getSECls("res.sounds.SE_mistake");
      }
      
      public static function get SE_destruction() : Class
      {
         return _getSECls("res.sounds.SE_destruction");
      }
      
      public static function get SE_miss() : Class
      {
         return _getSECls("res.sounds.SE_miss");
      }
      
      public static function get SE_dismantling() : Class
      {
         return _getSECls("res.sounds.SE_dismantling");
      }
      
      public static function get SE_akashi_ark() : Class
      {
         return _getSECls("res.sounds.SE_akashi_ark");
      }
      
      public static function get SE_akashi_motion1() : Class
      {
         return _getSECls("res.sounds.SE_akashi_mot1");
      }
      
      public static function get SE_akashi_motion2() : Class
      {
         return _getSECls("res.sounds.SE_akashi_mot2");
      }
      
      public static function get SE_akashi_motion3() : Class
      {
         return _getSECls("res.sounds.SE_akashi_mot3");
      }
      
      public static function get SE_akashi_fault() : Class
      {
         return _getSECls("res.sounds.SE_akashi_fault");
      }
      
      public static function get SE_akashi_success() : Class
      {
         return _getSECls("res.sounds.SE_akashi_successm");
      }
      
      public static function get SE_akashi_change() : Class
      {
         return _getSECls("res.sounds.SE_akashi_successl");
      }
      
      public static function get SE_akashi_click1() : Class
      {
         return _getSECls("res.sounds.SE_akashi_click1");
      }
      
      public static function get SE_akashi_click2() : Class
      {
         return _getSECls("res.sounds.SE_akashi_click2");
      }
      
      public static function get SE_sally_compass() : Class
      {
         return _getSECls("res.sounds.SE_sally_compass");
      }
      
      public static function get SE_buy() : Class
      {
         return _getSECls("res.sounds.SE_buy");
      }
      
      public static function get SE_onepoint07() : Class
      {
         return _getSECls("res.sounds.SE_onepoint07");
      }
      
      public static function get SE_onepoint16() : Class
      {
         return _getSECls("res.sounds.SE_onepoint16");
      }
      
      public static function get SE_arsenal_sel() : Class
      {
         return _getSECls("res.sounds.SE_arsenal_sel");
      }
      
      public static function get SE_kan() : Class
      {
         return _getSECls("res.sounds.SE_kan");
      }
      
      public static function get SE_correct_answer3() : Class
      {
         return _getSECls("res.sounds.SE_correct_answer3");
      }
      
      public static function get SE_battle_click() : Class
      {
         return _getSECls("res.sounds.SE_battle_click");
      }
      
      public static function get SE_battle_positive() : Class
      {
         return _getSECls("res.sounds.SE_battle_positive");
      }
      
      public static function get SE_sally_ping() : Class
      {
         return _getSECls("res.sounds.SE_sally_ping");
      }
      
      public static function get SE_sally_storm() : Class
      {
         return _getSECls("res.sounds.SE_sally_storm");
      }
      
      public static function getSceneCLS(param1:int) : Class
      {
         try
         {
            var _loc17_:* = param1;
            if(21 !== _loc17_)
            {
               if(25 !== _loc17_)
               {
                  if(26 !== _loc17_)
                  {
                     if(28 !== _loc17_)
                     {
                        if(27 !== _loc17_)
                        {
                           if(24 !== _loc17_)
                           {
                              if(13 !== _loc17_)
                              {
                                 if(11 !== _loc17_)
                                 {
                                    if(12 !== _loc17_)
                                    {
                                       if(14 !== _loc17_)
                                       {
                                          if(15 !== _loc17_)
                                          {
                                             if(16 !== _loc17_)
                                             {
                                                if(2 !== _loc17_)
                                                {
                                                   if(4 !== _loc17_)
                                                   {
                                                      if(30 === _loc17_)
                                                      {
                                                         var _loc16_:* = ApplicationDomain.currentDomain.getDefinition("scene.Revamp") as Class;
                                                         return _loc16_;
                                                      }
                                                   }
                                                   else
                                                   {
                                                      var _loc15_:* = ApplicationDomain.currentDomain.getDefinition("battle.BattleResult") as Class;
                                                      return _loc15_;
                                                   }
                                                }
                                                else
                                                {
                                                   var _loc14_:* = ApplicationDomain.currentDomain.getDefinition("battle.Battle") as Class;
                                                   return _loc14_;
                                                }
                                             }
                                             else
                                             {
                                                var _loc13_:* = ApplicationDomain.currentDomain.getDefinition("scene.Sally") as Class;
                                                return _loc13_;
                                             }
                                          }
                                          else
                                          {
                                             var _loc12_:* = ApplicationDomain.currentDomain.getDefinition("scene.Arsenal") as Class;
                                             return _loc12_;
                                          }
                                       }
                                       else
                                       {
                                          var _loc11_:* = ApplicationDomain.currentDomain.getDefinition("scene.Repair") as Class;
                                          return _loc11_;
                                       }
                                    }
                                    else
                                    {
                                       var _loc10_:* = ApplicationDomain.currentDomain.getDefinition("scene.Remodel") as Class;
                                       return _loc10_;
                                    }
                                 }
                                 else
                                 {
                                    var _loc9_:* = ApplicationDomain.currentDomain.getDefinition("scene.Supply") as Class;
                                    return _loc9_;
                                 }
                              }
                              else
                              {
                                 var _loc8_:* = ApplicationDomain.currentDomain.getDefinition("scene.Organize") as Class;
                                 return _loc8_;
                              }
                           }
                           else
                           {
                              var _loc7_:* = ApplicationDomain.currentDomain.getDefinition("scene.Duty") as Class;
                              return _loc7_;
                           }
                        }
                        else
                        {
                           var _loc6_:* = ApplicationDomain.currentDomain.getDefinition("scene.Interior") as Class;
                           return _loc6_;
                        }
                     }
                  }
                  var _loc5_:* = ApplicationDomain.currentDomain.getDefinition("scene.Itemlist") as Class;
                  return _loc5_;
               }
               var _loc4_:* = ApplicationDomain.currentDomain.getDefinition("scene.Album") as Class;
               return _loc4_;
            }
            var _loc3_:* = ApplicationDomain.currentDomain.getDefinition("scene.Record") as Class;
            return _loc3_;
         }
         catch(error:ReferenceError)
         {
         }
         return null;
      }
      
      public static function get CLS_wedding() : Class
      {
         var _loc1_:Class = null;
         try
         {
            _loc1_ = ApplicationDomain.currentDomain.getDefinition("scene.Wedding") as Class;
         }
         catch(error:ReferenceError)
         {
         }
         return _loc1_;
      }
      
      public static function get SlotitemIconMC() : Class
      {
         var _loc1_:Class = MovieClip;
         try
         {
            _loc1_ = ApplicationDomain.currentDomain.getDefinition("res.common.MCSlotitemIcon") as Class;
         }
         catch(error:ReferenceError)
         {
         }
         return _loc1_;
      }
      
      public static function get SlotitemCategoryIconMC() : Class
      {
         var _loc1_:Class = MovieClip;
         try
         {
            _loc1_ = ApplicationDomain.currentDomain.getDefinition("res.common.MCSlotitemCategoryIcon") as Class;
         }
         catch(error:ReferenceError)
         {
         }
         return _loc1_;
      }
      
      private static function _getSECls(param1:String) : Class
      {
         var _loc2_:* = null;
         try
         {
            _loc2_ = ApplicationDomain.currentDomain.getDefinition(param1) as Class;
         }
         catch(error:ReferenceError)
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      private static function _getBGMCls(param1:String) : Class
      {
         var _loc2_:* = null;
         try
         {
            _loc2_ = ApplicationDomain.currentDomain.getDefinition(param1) as Class;
         }
         catch(error:ReferenceError)
         {
            _loc2_ = Sound;
         }
         return _loc2_;
      }
      
      public static function getBGMCls(param1:String) : Class
      {
         try
         {
            var _loc3_:* = ApplicationDomain.currentDomain.getDefinition(param1) as Class;
            return _loc3_;
         }
         catch(error:ReferenceError)
         {
         }
         return null;
      }
   }
}
