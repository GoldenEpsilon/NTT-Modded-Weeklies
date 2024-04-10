global.newLevel = instance_exists(GenCont);
#define level_start
if GameCont.area != GameCont.lastarea or GameCont.lastsubarea = 0{
    var level = "???";
    if is_string(GameCont.area){
    	level = GameCont.area
    }
    else
    switch(GameCont.area){
        case 0:     level = "home?" break;
        case 1:     level = "the desert" break;
        case 2:     level = "sewers" break;
        case 3:     level = "scrapyard" break;
        case 4:     level = "crystal caves" break;
        case 5:     level = "frozen city" break;
        case 6:     level = "lab" break;
        case 7:     level = "the palace" break;
        case 100:   level = "???" break;
        case 101:   level = "hidden oasis" break;
        case 102:   level = "???" break;
        case 103:   level = "$$$venuz$$$" break;
        case(104):level = 
	string(choose("c","c","c","c","c","c","c","c","*","!","^","q","r","a","]","\","+"))+
	string(choose("r","r","r","r","r","r","r","r","q","4","^","q","r","a","]","\","+"))+
	string(choose("y","y","y","y","y","y","y","y","q","4","a","4","\","4",",",">","F"))+
	string(choose("s","s","s","s","s","s","s","s","q","4","a","4","-","*","\","+"))+
	string(choose("t","t","t","t","t","t","t","t","4","\","4",",",">","F","\","+"))+
	string(choose("a","a","a","a","a","a","a","a","q","4","a","4","\","4",",",">","F","-"))+
	string(choose("l","l","l","l","l","l","l","l","q","4","a","]","\","+"))+
	" "+
	string(choose("c","c","c","c","c","c","c","c","\","4",",",">","F","]","\","+"))+
	string(choose("a","a","a","a","a","a","a","a","q","-","*","!","^","q","r","a","]","\"))+
	string(choose("v","v","v","v","v","v","v","v","q","F","-","*","!","^"))+
	string(choose("e","e","e","e","e","e","e","e","q","-","*","!","^","q","r","a"))+
	string(choose("s","s","s","s","s","s","s","s","q","4","q","r","a","]","\","+"))
		 break;
        case 105:   level = "hidden jungle" break;
        case 106:   level = "IDPD HQ" break;
        case 107:   level = "CRIB" break;
    }
    bigtext(level)
}
#define step
	if !mod_script_call("mod", "ModdedWeeklies", "get_option", "mini_intros") {
		return;
	}
    if(instance_exists(GenCont)) global.newLevel = 1;
    else if(global.newLevel){
        global.newLevel = 0;
        level_start();
    }
    
    if !UberCont.opt_bossintros 
    with instances_matching(enemy,"intro",1) if "bossintrothing" not in self{
        bossintrothing=1
        var text = "???";
        
        
        //switch(GameCont.area){
        //    case 1: if GameCont.loops = 0
        //                text = "big bandit" else
        //                text = "big bandits" break;
        //    case 2:     text = "mom" break;
        //    case 3:     text = "big dog" break;
        //    case 4:     text = "hyper crystal" break;
        //    case 5:     text = "lil hunter" break;
        //    case 6:     text = "technomancer" break;
        //    case 7:     text = "the throne" break;
        //    case 100:   text = "???" break;
        //    case 101:   text = "big fish" break;
        //    case 102:   text = "the turtles" break;
        //    case 103:   text = "yung cuz" break;
        //    case 104:   text = "CURSED HYPER CRYSTAL" break;
        //    case 105:   text = "malaria" break;
        //    case 106:   text = "IDPD CAPTAIN" break;
        //    case 107:   text = "yung cuz" break;
        //    case 108:   text = "the nuclear throne" break;
        //    case 0:     text = "THE nuclear throne" break;
        //}
        if is_array(hitid){
        	text = hitid[1]
        }
        else{
        	var bb = (hitid = 6) 
        	text = killed_by(hitid)[1]
        	
        	if bb and GameCont.loops >= 1
        	text = string(text)+"s"
        }
        text = string(text)+"!"
        
        bigtext(text)
    }
#define bigtext(_text)
    if fork(){
        var btext = _text
        var goalx = 220
        for(var i=0;i>-120;i--){
            script_bind_draw(bigtext_draw,-30,btext,i*-1,goalx)
            goalx = goalx + ((0 - goalx) * 0.5)
            wait 0
        }
        exit;
    }
#define bigtext_draw(btext,i,f)
    draw_set_color(c_white)
    draw_set_halign(2)
    draw_set_font(fntM)
    if i < 100
    draw_sprite(sprUnlockPopupSplat,min(i,2),view_xview+game_width,view_yview+game_height)
    else
    draw_sprite(sprUnlockPopupSplat,min(i,2),view_xview+game_width+(i-100)*3,view_yview+game_height+(i-100)*10)
    if i < 100 or i mod 3 = 1
    //draw_text_shadow(view_xview+game_width-6+240-min(i*2,240)+choose(0,0,0,0,-1,1),view_yview+game_height-16+choose(0,0,0,0,-1,1),string(ultext)+"!");
    draw_text_shadow(view_xview+game_width-6+(f),view_yview+game_height-20,string(btext)+"    ");
    draw_set_halign(0)
    instance_destroy()

#define killed_by(_cause)
	/*
		Returns the death cause associated with a given index as an array containing [Sprite, Name]
	*/
	
	_cause = floor(_cause);
	
	 // Normal:
	var _loc = `CauseOfDeath:${_cause}`;
	switch(_cause){
		case   0 : return [sprBanditIdle,           loc(_loc, "bandit"                                              )];
		case   1 : return [sprMaggotIdle,           loc(_loc, "maggot"                                              )];
		case   2 : return [sprRadMaggot,            loc(_loc, "rad maggot"                                          )];
		case   3 : return [sprBigMaggotIdle,        loc(_loc, "big maggot"                                          )];
		case   4 : return [sprScorpionIdle,         loc(_loc, "scorpion"                                            )];
		case   5 : return [sprGoldScorpionIdle,     loc(_loc, "golden scorpion"                                     )];
		case   6 : return [sprBanditBossIdle,       loc(_loc, "big bandit"                                          )];
		case   7 : return [sprRatIdle,              loc(_loc, "rat"                                                 )];
		case   8 : return [sprRatkingIdle,          loc(_loc, "big rat"                                             )];
		case   9 : return [sprFastRatIdle,          loc(_loc, "green rat"                                           )];
		case  10 : return [sprGatorIdle,            loc(_loc, "gator"                                               )];
		case  11 : return [sprExploderIdle,         loc(_loc, "frog"                                                )];
		case  12 : return [sprSuperFrogIdle,        loc(_loc, "super frog"                                          )];
		case  13 : return [sprFrogQueenIdle,        loc(_loc, "mom"                                                 )];
		case  14 : return [sprMeleeIdle,            loc(_loc, "assassin"                                            )];
		case  15 : return [sprRavenIdle,            loc(_loc, "raven"                                               )];
		case  16 : return [sprSalamanderIdle,       loc(_loc, "salamander"                                          )];
		case  17 : return [sprSniperIdle,           loc(_loc, "sniper"                                              )];
		case  18 : return [sprScrapBossIdle,        loc(_loc, "big dog"                                             )];
		case  19 : return [sprSpiderIdle,           loc(_loc, "spider"                                              )];
		case  20 : return [sprBanditIdle,           loc(_loc, "new cave thing"                                      )];
		case  21 : return [sprLaserCrystalIdle,     loc(_loc, "laser crystal"                                       )];
		case  22 : return [sprHyperCrystalIdle,     loc(_loc, "hyper crystal"                                       )];
		case  23 : return [sprSnowBanditIdle,       loc(_loc, "snow bandit"                                         )];
		case  24 : return [sprSnowBotIdle,          loc(_loc, "snowbot"                                             )];
		case  25 : return [sprWolfIdle,             loc(_loc, "wolf"                                                )];
		case  26 : return [sprSnowTankIdle,         loc(_loc, "snowtank"                                            )];
		case  27 : return [sprLilHunter,            loc(_loc, "lil hunter"                                          )];
		case  28 : return [sprFreak1Idle,           loc(_loc, "freak"                                               )];
		case  29 : return [sprExploFreakIdle,       loc(_loc, "explo freak"                                         )];
		case  30 : return [sprRhinoFreakIdle,       loc(_loc, "rhino freak"                                         )];
		case  31 : return [sprNecromancerIdle,      loc(_loc, "necromancer"                                         )];
		case  32 : return [sprTurretIdle,           loc(_loc, "turret"                                              )];
		case  33 : return [sprTechnoMancer,         loc(_loc, "technomancer"                                        )];
		case  34 : return [sprGuardianIdle,         loc(_loc, "guardian"                                            )];
		case  35 : return [sprExploGuardianIdle,    loc(_loc, "explo guardian"                                      )];
		case  36 : return [sprDogGuardianWalk,      loc(_loc, "dog guardian"                                        )];
		case  37 : return [sprNothingOn,            loc(_loc, "throne"                                              )];
		case  38 : return [sprNothing2Idle,         loc(_loc, "throne II"                                           )];
		case  39 : return [sprBoneFish1Idle,        loc(_loc, "bonefish"                                            )];
		case  40 : return [sprCrabIdle,             loc(_loc, "crab"                                                )];
		case  41 : return [sprTurtleIdle,           loc(_loc, "turtle"                                              )];
		case  42 : return [sprMolefishIdle,         loc(_loc, "molefish"                                            )];
		case  43 : return [sprMolesargeIdle,        loc(_loc, "molesarge"                                           )];
		case  44 : return [sprFireBallerIdle,       loc(_loc, "fireballer"                                          )];
		case  45 : return [sprSuperFireBallerIdle,  loc(_loc, "super fireballer"                                    )];
		case  46 : return [sprJockIdle,             loc(_loc, "jock"                                                )];
		case  47 : return [sprInvSpiderIdle,        loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qs@qp@qi@qd@qe@qr"             )];
		case  48 : return [sprInvLaserCrystalIdle,  loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qc@qr@qy@qs@qt@qa@ql"          )];
		case  49 : return [sprMimicTell,            loc(_loc, "mimic"                                               )];
		case  50 : return [sprSuperMimicTell,       loc(_loc, "health mimic"                                        )];
		case  51 : return [sprGruntIdle,            loc(_loc, "grunt"                                               )];
		case  52 : return [sprInspectorIdle,        loc(_loc, "inspector"                                           )];
		case  53 : return [sprShielderIdle,         loc(_loc, "shielder"                                            )];
		case  54 : return [sprOldGuardianIdle,      loc(_loc, "crown guardian"                                      )];
		case  55 : return [sprExplosion,            loc(_loc, "explosion"                                           )];
		case  56 : return [sprSmallExplosion,       loc(_loc, "small explosion"                                     )];
		case  57 : return [sprTrapGameover,         loc(_loc, "fire trap"                                           )];
		case  58 : return [sprShielderShieldAppear, loc(_loc, "shield"                                              )];
		case  59 : return [sprToxicGas,             loc(_loc, "toxic"                                               )];
		case  60 : return [sprEnemyHorrorIdle,      loc(_loc, "horror"                                              )];
		case  61 : return [sprBarrel,               loc(_loc, "barrel"                                              )];
		case  62 : return [sprToxicBarrel,          loc(_loc, "toxic barrel"                                        )];
		case  63 : return [sprGoldBarrel,           loc(_loc, "golden barrel"                                       )];
		case  64 : return [sprCarIdle,              loc(_loc, "car"                                                 )];
		case  65 : return [sprVenusCar,             loc(_loc, "venus car"                                           )];
		case  66 : return [sprVenusCarFixed,        loc(_loc, "venus car fixed"                                     )];
		case  67 : return [sprVenuzCar2,            loc(_loc, "venus car 2"                                         )];
		case  68 : return [sprFrozenCar,            loc(_loc, "icy car"                                             )];
		case  69 : return [sprFrozenCarThrown,      loc(_loc, "thrown car"                                          )];
		case  70 : return [sprWaterMine,            loc(_loc, "mine"                                                )];
		case  71 : return [sprCrown1Idle,           loc(_loc, "crown of death"                                      )];
		case  72 : return [sprPopoExplo,            loc(_loc, "rogue strike"                                        )];
		case  73 : return [sprBloodNader,           loc(_loc, "blood launcher"                                      )];
		case  74 : return [sprBloodCannon,          loc(_loc, "blood cannon"                                        )];
		case  75 : return [sprBloodHammer,          loc(_loc, "blood hammer"                                        )];
		case  76 : return [sprDisc,                 loc(_loc, "disc"                                                )];
		case  77 : return [sprCurse,                loc(_loc, "@p@qc@qu@qr@qs@qe"                                   )];
		case  78 : return [sprScrapBossMissileIdle, loc(_loc, "big dog missile"                                     )];
		case  79 : return [sprSpookyBanditIdle,     loc(_loc, "halloween bandit"                                    )];
		case  80 : return [sprLilHunterHurt,        loc(_loc, "lil hunter fly"                                      )];
		case  81 : return [sprNothingDeathLoop,     loc(_loc, "throne death"                                        )];
		case  82 : return [sprJungleBanditIdle,     loc(_loc, "jungle bandit"                                       )];
		case  83 : return [sprJungleAssassinIdle,   loc(_loc, "jungle assassin"                                     )];
		case  84 : return [sprJungleFlyIdle,        loc(_loc, "jungle fly"                                          )];
		case  85 : return [sprCrown1Idle,           loc(_loc, "crown of hatred"                                     )];
		case  86 : return [sprIceFlowerIdle,        loc(_loc, "ice flower"                                          )];
		case  87 : return [sprCursedAmmo,           loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qa@qm@qm@qo @qp@qi@qc@qk@qu@qp")];
		case  88 : return [sprLightningDeath,       loc(_loc, "electrocution"                                       )];
		case  89 : return [sprEliteGruntIdle,       loc(_loc, "elite grunt"                                         )];
		case  90 : return [sprKillsIcon,            loc(_loc, "blood gamble"                                        )];
		case  91 : return [sprEliteShielderIdle,    loc(_loc, "elite shielder"                                      )];
		case  92 : return [sprEliteInspectorIdle,   loc(_loc, "elite inspector"                                     )];
		case  93 : return [sprLastIdle,             loc(_loc, "captain"                                             )];
		case  94 : return [sprVanDrive,             loc(_loc, "van"                                                 )];
		case  95 : return [sprBuffGatorIdle,        loc(_loc, "buff gator"                                          )];
		case  96 : return [sprBigGenerator,         loc(_loc, "generator"                                           )];
		case  97 : return [sprLightningCrystalIdle, loc(_loc, "lightning crystal"                                   )];
		case  98 : return [sprGoldTankIdle,         loc(_loc, "golden snowtank"                                     )];
		case  99 : return [sprGreenExplosion,       loc(_loc, "green explosion"                                     )];
		case 100 : return [sprSmallGenerator,       loc(_loc, "small generator"                                     )];
		case 101 : return [sprGoldDisc,             loc(_loc, "golden disc"                                         )];
		case 102 : return [sprBigDogExplode,        loc(_loc, "big dog explosion"                                   )];
		case 103 : return [sprPopoFreakIdle,        loc(_loc, "popo freak"                                          )];
		case 104 : return [sprNothing2Death,        loc(_loc, "throne II death"                                     )];
		case 105 : return [sprOasisBossIdle,        loc(_loc, "big fish"                                            )];
	}
	
	 // Sprite:
	if(sprite_exists(_cause)){
		return [_cause, sprite_get_name(_cause)];
	}
	
	 // None:
	return [mskNone, ""];
    