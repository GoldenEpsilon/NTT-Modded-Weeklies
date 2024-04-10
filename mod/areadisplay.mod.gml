#macro timer true

global.playercount = max(1,instance_number(Player));
global.areaname = " "
setname()
#define game_start
global.playercount = max(1,instance_number(Player));
#define step
with instances_matching(GenCont,"areadisplay",null){
    level_start()
    areadisplay = true;
}
#define level_start
setname();
#define setname
switch(GameCont.area){
    case(100):  
        global.areaname = "???"; 
        break;
    case(107):  
        global.areaname = "$$$"; 
        break;
    case(106):  
        global.areaname = "HQ"+string(GameCont.subarea); 
        break;
    default:
        global.areaname = 
        is_string(GameCont.area) ? 
            mod_script_call("area",string(GameCont.area),"area_name",GameCont.subarea,GameCont.loops) 
            :
            string(GameCont.area mod 100)+"-"+(GameCont.area>=100?"?":string(GameCont.subarea));
        break;
        
}
#define draw_gui
if instance_exists(Player){
    draw_set_font(fntM0)
    switch(global.playercount){
        case(1):
            draw_set_halign(fa_right);
            draw_text_nt(game_width-2,(game_height-20)+10*(timer=false),global.areaname);
            break;
        case(2):
            draw_set_halign(fa_left);
            draw_text_nt(2,(game_height-20)+10*(timer=false),global.areaname);
            break;
        default:
            draw_set_halign(fa_center);
            draw_text_nt(game_width/2,(game_height-20),global.areaname);
            break;
    }
    draw_set_halign(fa_left);
}




/*                                                                                                                          *\
    displays the current level-subarea in the bottom right corner
    works with custom areas, it will show the same text displayed on the map screen.
    
    it adjusts its position based on the number of players, 
    following the timer for 1-2 players and centering under the rad counter for 3-4 players
    
    intended to be used with the timer option enabled but can be adjusted by editing the first line of the file to false. 
    there is no way i can make the mod detect if you have it enabled or not
    
    i like it mostly just for quickly checking if it is stage 2 or 3 for loop 0 boss spawns

    /loadmod areadisplay
    you can add this line to a textfile named startup.txt in the main mods folder to auto load






\*                                                                                                                          */