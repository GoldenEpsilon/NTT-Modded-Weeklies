
/* * * * *\
find modded races
make array of 1-16 +modded races
go through array turning to list
assign modded to map, keying name to place on list
check position with saved map?
so each race is tied to a pos and it cycles through referenced places instead of trying all 0-30
	here the highest number (30) would be the latest new race loaded (in all session)

match names

save new weapons
sort the weapons at least the basegame ones

protochest unlocks any wep for that char?

find a way to hide/trick the game into not drawing the gold weapon assigning when entering a level
draw active wep when loadout closed



--- re use for ui mod	---


draw minimized bwep for not_steroids

add way to make it give rogue both the revolver and rrifle but not give fish 2 revolvers

add way for mods to add weapon/crown art
add option to not use any weapon art


code option for steroids to start with 2


{
    "name": "Testing Bed",
    "description": false,
    "can_resubmit": false,
    "disable_vaults": false,
    "starting_crown": true,
    "starting_weapon": true,
    "race_list": true,
    "seed": 5489,
    "mods": [
        {
            "download_type": "itch",
            "name": "Feels Like Vanilla",
            "description": false,
            "url": "https://dragonstrive.itch.io/feels-like-vanilla"
        },
        {
            "download_type": "itch",
            "name": "Detonator",
            "description": false,
            "url": "https://yokin.itch.io/detonator"
        },
        {
            "download_type": "itch",
            "name": "The Undergrowth",
            "description": false,
            "url": "https://attfooy.itch.io/undergrowth"
        },
        {
            "download_type": "itch",
            "name": "Blaacskills",
            "description": false,
            "url": "https://blaac.itch.io/weapon-mutations"
        },
    ],
    "race": false,
    "wep": false,
    "bwep": false,
    "crwn": false,
}


\* * * * */

#macro debug false
#macro debug2 false

global.information = {
    "name": "Testing Bed",
    "description": false,
    "can_resubmit": false,
    
    "crown": [true, 6],
    "wep": [true],
    "bwep": false,
    "race": [1,2,3,4,5],
    
    "disable_vaults": false,
    
    "seed": 7,
    "mods": [
        {}
    ],
}
///global.information.wep[1] = ASSAULT RIFLE

//update_information_cool_script()

global.previousmode = "";


if debug or debug2{
	// add all the weapons
	var _currentweapons = ds_list_create()
	weapon_get_list(_currentweapons, 0, 300)
	for (var www = 0;www<ds_list_size(_currentweapons);www++){
	global.information.wep[array_length(global.information.wep)]	= _currentweapons[|www]
	}
	ds_list_destroy(_currentweapons)
}



#macro savefile "ui_weapons.txt"
#macro char1 ","
#macro char2 ";"

global.wantsave = 0;

//storing the loaded save data. should have coded around needing to do this
global.loadedarray = []
#macro loadedarray global.loadedarray

//the main thing everything will be combined to form and call
global.race = ds_list_create()
#macro g_list global.race

//array of active races (race_get_active()s and loaded modraces with race_avail() true or undefined)
global.raceray = [0]
#macro raceray global.raceray

//map pointing to specific indexs for each race. so you can unload races, load new ones, and not overwrite them. "detonator" will always reference index X
global.racemap = ds_map_create()
#macro racemap global.racemap

//all loaded modded races
global.modraces = mod_get_names("race")
#macro modraces global.modraces
//all loaded modded weps
global.modweps = mod_get_names("weapon")
#macro modweps global.modweps

//cuz is still set to active for some reason
race_set_active(16,0)

//number of base races active/unlocked
global.raceactive = 0
for(var i = 1;i<16;i++)
if race_get_active(i) global.raceactive += 1




//load the map here
//load_map()
	//sets the map of the saved races
	//copies the save file to loadedarray. shouldnt have to have done this



load_races()

//first_load()



//for(var i = 1;i<array_length(raceray);i++)
//trace(g_list[| racemap[? raceray[i]] ] )
//trace(loadedarray)
//
//trace(raceray)




//trace( mod_get_names("race") )
//trace( mod_get_names("weapon") )


   // load();
   
   
   
#define game_start
with instances_matching(Player,"wep","mw_ui_start"){
	setplayerwep(index)
	//event_perform(ev_other,ev_room_end)
}

//save();
   
#define load_map
	/// Load the file and split it into an array
	wait file_load(savefile);
	if file_exists(savefile){
	    trace("WEAPON SAVE DATA LOADED")
		var _races = string_load(savefile);
		_races = string_split(_races,char2);
		for(var i = 0;i<array_length(_races);i++){
	        _races[i] = string_split(_races[i],char1)
		}
		
		//set the name and index
		for(var i = 1;i<array_length(_races)-1;i++){//
	    				//name			//index
	        racemap[? _races[i][0]] = real(_races[i][1])
	        
			
		}
	    
	    
	    loadedarray = _races	
		file_unload(savefile);
	    	
	    	
	    	
	}else{
		trace("FILE DOES NOT EXIST -- ASSUMED FRESH SAVE, USING DEFAULTS");
		
	}
#define load_races
//race_id start at 1 so why not
raceray[0] = player_get_alias(0)
//set up the real races
for(var i = 1;i<=16;i++){
	//if race_get_active(i){
		raceray[array_length(raceray)] = race_get_name(i)
	//}
	// set these 16 always so "detonator" doesnt become 13
	if is_undefined( racemap[? race_get_name(i)] )
		racemap[? race_get_name(i)] = i
		
	//if debug trace(race_get_name(racemap[? race_get_name(i)]))
}
	//sets up which races are active of the 16 real races
	//fills in blank map places for the 16 real races

//find modded races
for(var i = 0;i<array_length(modraces);i++){
	if !mod_script_exists("race",modraces[i],"race_avail") 
	or mod_script_call("race",modraces[i],"race_avail") = true
		raceray[array_length(raceray)] = modraces[i]
		
	//set undefined modraces to the next highest number
	if is_undefined( racemap[? modraces[i] ] ){
		var _highest = 16
		var _mapvals = ds_map_values(racemap)
		for(var f = 0;f<array_length(_mapvals);f++)
			_highest = max(_highest,_mapvals[f])
		racemap[? modraces[i] ] = _highest+1
	}
}
//now have raceray ["fish","crystal",....,"cuz","detonator"] using mod_name not race_name

//turn the map of [names,indexs] and array of active races to a list of names in those indexs
for(var i = 1;i<array_length(raceray);i++){
	
	var f = racemap[? raceray[i] ]
    ds_list_set( g_list , f , [raceray[i], f] )
    
}




load_weps()
//save()	
#define load_weps
var data = mod_script_call("mod", "ModdedWeeklies", "get_current_data");
if "wep" not in data {
	data.wep = false;
}
if "bwep" not in data {
	data.bwep = false;
}

//set starting weapons
for(var i = 1;i<array_length(raceray);i++){
	if array_length(g_list[|    racemap[? raceray[i]]	])<3{
	    //current wep slot
	    g_list[|    racemap[? raceray[i]]	][@2] = 3
	    
	    
		if (!is_array(data.wep) && data.wep == false) || data.wep[0]
	    	//weapon in slot 1
			switch( raceray[i] ){
				case("venuz"):	g_list[|racemap[? raceray[i]] ][@3] = wep_golden_revolver		break;
				case("chicken"):g_list[|racemap[? raceray[i]] ][@3] = wep_chicken_sword			break;
				case("rogue"):	g_list[|racemap[? raceray[i]] ][@3] = wep_rogue_rifle			break;
				case("frog"):	g_list[|racemap[? raceray[i]] ][@3] = wep_golden_frog_pistol	break;
				case("skeleton"):g_list[|racemap[?raceray[i]] ][@3] = wep_rusty_revolver		break;
				case("bigdog"):	g_list[|racemap[? raceray[i]] ][@3] = wep_dog_spin_attack		break;
				default:
					if mod_script_exists("race",raceray[i],"race_swep")
						//g_list[|racemap[? i]][@3] = mod_script_call("race",raceray[i],"race_swep")
						g_list[|racemap[? raceray[i]]][@3] = mod_script_call("race",raceray[i],"race_swep")
					else 
						g_list[|racemap[? raceray[i]]][@3] = wep_revolver
			}
	}
	
	
	//get list from mod file
	
	//if debug{
		//testing many weapons
	
	//g_list[|racemap[? raceray[i]] ][@4]	= wep_golden_wrench
	//g_list[|racemap[? raceray[i]] ][@5]	= wep_golden_machinegun
	//g_list[|racemap[? raceray[i]] ][@6]	= wep_golden_shotgun
	//g_list[|racemap[? raceray[i]] ][@7]	= wep_golden_crossbow
	//g_list[|racemap[? raceray[i]] ][@8]	= wep_golden_grenade_launcher
	//g_list[|racemap[? raceray[i]] ][@9]	= wep_golden_laser_pistol
	//g_list[|racemap[? raceray[i]] ][@10]	= wep_auto_crossbow
		
	//}
	
	
	if(is_array(data.wep)){
		for(var _w = 1; _w< array_length(data.wep);_w++){
			g_list[|racemap[? raceray[i]] ][@2+_w+data.wep[0]]= data.wep[_w]
		}
	}else if data.wep {
		g_list[|racemap[? raceray[i]] ][@3]= data.wep
	}
	
}


//set the current wep and weps
	for(var i = 1;i<array_length(loadedarray);i++){
		var _add = 0
		for(var a = 0;a<array_length(raceray);a++)
			if loadedarray[i][0] = raceray[a]
				_add = 1
		if _add
		for(var f = 2;f<array_length(loadedarray[i]);f++){
			g_list[| racemap[? loadedarray[i][0] ]][@f] = real(loadedarray[i][f])
		}
		
	}


#define save
if fork(){
	global.wantsave = 0
	var secondmap = ds_map_create()
	var _str = raceray[0] +";"
	
		var _settings = loadedarray;
	
		var _races = _settings;

		//i need to load the current save file and only overwrite parts of it to not overwrite unloaded characters, ...fun
	    //update the saved races
	    
		for(var i = 1;i<array_length(_races);i++){ 
			
			if !is_undefined(racemap[? _races[i][0] ])
			//and is_array(g_list[| racemap[? _races[i][0] ] ])
			{
				//update weapons and be sure to make them strings :), and add new ones
				for(var f = 1;f<array_length(  g_list[|    racemap[? _races[i][0] ]	]  );f++){
					_races[i][@f] = string( g_list[|    racemap[? _races[i][0] ]	][f] )
				}
				
					//trace( racemap[? _races[i][0] ] )
					
				//cycle through the saved races and add them to the savestring
				//mark them as added
				secondmap[? _races[i][0]] = 0
				
				if is_array(g_list[| racemap[? _races[i][0] ] ])
				for(var f = 0;f<array_length(_races[i])-1;f++){ 
					//trace(g_list[| racemap[? _races[i][0] ] ],f)
					//trace(_races[i][1] ,f)
					//trace(g_list[| racemap[? _races[i][0] ] ][f])
					_str = _str+string( g_list[| racemap[? _races[i][0] ] ][f] )+char1	//error [f] out of bound?
				}
				
				//last one add the ";" to signal next race
			//	f = max(0,array_length(_races[i])-1)
				//trace(g_list[| racemap[? _races[i][0] ] ],f)
			//	_str = _str+string( g_list[| racemap[? _races[i][0] ] ][f] )+char2
				// :-(
			}
		}
//	}
	//else{
	//	if array_length(g_list[|    racemap[? "fish"]	])<3{
	//		first_load()	
	//		exit;
	//	}
	//}
	//add unsaved races
	for(var i = 1;i<array_length(raceray);i++){
		//if the race isnt saved add it
		if is_undefined( secondmap[? raceray[i]] )
		and !is_undefined( racemap[? raceray[i]] ){
			var _who = g_list[| racemap[? raceray[i]] ]
			for(var f = 0;f<array_length(_who)-1;f++){
				_str=_str+string( _who[f] )+char1
			}
			f = max(0,array_length(_who)-1)
			_str = _str+string( _who[f] )+char2
		}
	}
	
	
	
	
	/// Save to file
	string_save(_str,savefile);
	//spawn a swirly
    if _settings !=_str
	with instance_create(-10000,-10000,CustomObject){
		sprite_index = sprSaving;
		image_alpha = 0;
		image_speed = 1.2;
		script_bind_draw("saving_draw",-10000,self)
	}
	exit;
	
}
#define saving_draw(_dad)
if instance_exists(_dad){
	//view_xview_nonsync+game_width-18,view_yview_nonsync+game_height-20
	draw_sprite_ext(sprSaving,_dad.image_index,view_xview_nonsync+game_width-18,view_yview_nonsync+game_height-20,-1,-1,0,c_white,1)
	with _dad
		if image_index+image_speed>=image_number instance_delete(id)
}
else instance_delete(id)
	
		
#define first_load

/*
0 = racename
1 = position in list
2 = current wep (3~)
3 = basic wep
4~ = stored weps
*/

//test more wep


//save()

#define step

if instance_exists(Loadout){
	
	
	if mod_variable_get("mod", "ModdedWeeklies", "currentMode") != global.previousmode {
		global.previousmode = mod_variable_get("mod", "ModdedWeeklies", "currentMode");
		load_races();
	}
	
    //check new mods
    if array_length(mod_get_names("race")) > array_length(modraces)
    or array_length(mod_get_names("weapon")) > array_length(modweps){
    //or a race_set_active
		modraces = mod_get_names("race")
		modweps = mod_get_names("weapon")
		load_races()
	}
	//check active/inactive real races
//	var _active = 0
//	for(var i = 1;i<16;i++)
//	if race_get_active(i) _active += 1
//	if global.raceactive!=_active{
//		global.raceactive = _active
//		load_races()
//	}
	
    //if Loadout.selected{
    	with LoadoutWep
    	    instance_destroy()
    	if player_get_race_id(0) != 0
    	script_bind_draw(buttons,-1010)
	//}
	
	//if debug and button_pressed(0,"horn") trace(modraces)
	//if debug and button_pressed(0,"horn"){
	//	trace( array_length(loadedarray))
	//	for(var i = 1; i< array_length(loadedarray);i++){
	//		var name = ds_list_find_value(g_list,i)
	//		if is_array(name)
	//		trace(name[0])
	//	}
	//}
}
	if debug2{
	if button_pressed(0,"key1"){
		trace( g_list[| 2]	)
		trace( "hi b")
	}
	}

#define buttons
//unselected close pos
//var _x = view_xview_nonsync+game_width -77;
//var _y = view_xview_nonsync+game_height-39.5;

//selected gold pos
//var _x = game_width -56;
//var _y = game_height-70;

//selected gold pos
var w_x = view_xview_nonsync+game_width -60;
var w_y = view_yview_nonsync+game_height-76;

var l_x = view_xview_nonsync+game_width -72-32;
var r_x = view_xview_nonsync+game_width -72+52;
var b_y = view_yview_nonsync+game_height-70-8;

var open = false;
var anim = 0;

with Loadout{
    if selected
        open = true;
    anim = openanim;
}

anim = 8*(1-(anim/4));
if anim > 0 and anim < 8 anim -= 2.5;
//trace(anim)
if player_get_race_id(0) = 0 exit;

var race = player_get_race(0);
var num = g_list[| racemap[? race] ][2];	//
var _how_many_guns = array_length(g_list[|racemap[? race]])
var b_size = 8;
var check_left = point_in_rectangle(mouse_x,mouse_y,l_x-b_size,b_y-b_size,l_x+b_size,b_y+b_size);
var check_right= point_in_rectangle(mouse_x,mouse_y,r_x-b_size,b_y-b_size,r_x+b_size,b_y+b_size);
//var check_middle = point_in_rectangle(mouse_x,mouse_y,w_x-b_size,b_y-b_size,w_x+b_size,b_y+b_size);

var c_x = view_xview_nonsync+game_width -107;
var c_y = view_yview_nonsync+game_height-67;
var check_closed = point_in_rectangle(mouse_x,mouse_y,c_x,c_y,view_xview_nonsync+game_width,c_y+31);
var check_middle = point_in_rectangle(mouse_x,mouse_y,c_x-20,c_y-30,view_xview_nonsync+game_width,c_y+31);

var clicked_left = 0;
var clicked_right = 0;

//make buttons work
if check_right and button_pressed(0,"fire") and _how_many_guns>4{
    if num < array_length( g_list[| racemap[? race] ] )-1
        num += 1
    else
        num = 3
    g_list[| racemap[? race] ][@2] = num
    global.wantsave = 1
    clicked_right = 2;
    anim -= 2
}
if check_left and button_pressed(0,"fire") and _how_many_guns>4{
    if num > 3
        num -= 1
    else
        num = array_length( g_list[| racemap[? race] ] )-1 //
    g_list[| racemap[? race] ][@2] = num
    global.wantsave = 1
    clicked_left = 2;
    anim -= 2
}

var wep = g_list[| racemap[? race] ][num]
	

//var wep_spr = get_weapon_menu_sprite(wep)
//var sprite = wep_spr[1]
//var customsprite = wep_spr[0]

var sprite = 0
var scale = 1
var customsprite = false
switch (wep){
    case( wep_revolver						):customsprite = true ;sprite = sprRevolverLoadout 				break;
    case( wep_chicken_sword 				):customsprite = true ;sprite = sprChickenSwordLoadout 			break;
    case( wep_rogue_rifle					):customsprite = true ;sprite = sprRogueRifleLoadout			break;
    case( wep_golden_revolver				):customsprite = true ;sprite = sprGoldRevolverLoadout 			break;
    case( wep_golden_wrench 				):customsprite = true ;sprite = sprGoldWrenchLoadout			break;
    case( wep_golden_machinegun 			):customsprite = true ;sprite = sprGoldMachinegunLoadout		break;
    case( wep_golden_shotgun	 			):customsprite = true ;sprite = sprGoldShotgunLoadout			break;
    case( wep_golden_crossbow				):customsprite = true ;sprite = sprGoldCrossbowLoadout 			break;
    case( wep_golden_grenade_launcher		):customsprite = true ;sprite = sprGoldGrenadeLauncherLoadout	break;
    case( wep_golden_laser_pistol			):customsprite = true ;sprite = sprGoldLaserPistolLoadout		break;
    case( wep_golden_frog_pistol	 		):customsprite = true ;sprite = sprGoldToxicGunLoadout 			break;
    case( wep_golden_splinter_gun			):customsprite = true ;sprite = sprGoldSplintergunLoadout		break;
    case( wep_golden_slugger	 			):customsprite = true ;sprite = sprGoldSluggerLoadout			break;
    case( wep_golden_screwdriver	 		):customsprite = true ;sprite = sprGoldScrewdriverLoadout		break;
    case( wep_golden_plasma_gun 			):customsprite = true ;sprite = sprGoldPlasmaGunLoadout			break;
    case( wep_golden_nuke_launcher			):customsprite = true ;sprite = sprGoldNukeLauncherLoadout		break;
    case( wep_golden_disc_gun				):customsprite = true ;sprite = sprGoldDiscgunLoadout			break;
    case( wep_golden_bazooka	 			):customsprite = true ;sprite = sprGoldBazookaLoadout			break;
    case( wep_golden_assault_rifle			):customsprite = true ;sprite = sprGoldAssaultRifleLoadout		break;
    case( wep_rusty_revolver				):customsprite = true ;sprite = sprRustyRevolverLoadout			break;
	default:	sprite = weapon_get_sprite(g_list[|racemap[? race]][num]); scale=2.5;
}
if is_string(wep) and mod_variable_exists("wep",wep,"weapon_loadout"){
    customsprite = true ;    sprite = mod_variable_get("wep",wep,"weapon_loadout");
	scale = 1;
}
var xoffset = 32*(!customsprite)//((sprite_get_width(sprite)/2)+sprite_get_xoffset(sprite) )*(scale=2.5)
var yoffset = (8)*(scale=2.5)



//draw things
if open{
	var data = mod_script_call("mod", "ModdedWeeklies", "get_current_data");
	if race = "steroids" or ("bwep" in data and data.bwep != false) {
    xoffset += 8
    draw_sprite_ext(sprRevolverLoadout,( check_middle ? min((current_frame-3)*0.4 mod 36,6):0 ),w_x+20,w_y+(anim)+check_middle,1,1,0,c_white,0.8)
}
	
	
	//buttons
    draw_sprite_ext(sprDailyArrow,0,l_x-clicked_left,b_y+(anim)+!check_left,1,1,0,(check_left ? c_white:c_gray),_how_many_guns>4?1:0)
    draw_sprite_ext(sprDailyArrow,1,r_x+clicked_right,b_y+(anim)+!check_right,1,1,0,(check_right ? c_white:c_gray),_how_many_guns>4?1:0)
    //wep
    draw_sprite_ext(sprite,( check_middle ?  min((current_frame*0.4 mod 36),(sprite_get_number(sprite)-(!customsprite))+!customsprite)   :0 ),
    w_x-xoffset+lengthdir_x(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_x(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
    w_y+(anim)+yoffset+check_middle+lengthdir_y(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_y(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
    scale,scale,26.5*(scale=2.5),c_white,1)

	//text
	draw_set_halign(2)
	var name = weapon_get_name(wep)
	if wep = wep_rogue_rifle name = "@b"+name
	if wep = wep_rusty_revolver name = "@(color:" + string(make_color_rgb(97,63,51)) + ")"+name
	if weapon_get_gold(wep) name = "@y"+name
	if weapon_get_rads(wep) name = "@g"+name
	if wep = wep_super_disc_gun name = "@p@q"+name
	
	if string_length(name)>18
		draw_sprite_ext(sprLoadoutSplat,3,w_x+(anim*16)-6-(4*string_length(name)),w_y+45,1,1,0,c_white,1)
	else if string_length(name)<8{
		draw_set_halign(1)
		w_x -= 30
	}
	draw_set_alpha( (check_middle ? 1:0.5) )
	draw_text_nt(w_x+28+(anim*16),w_y+33+!check_middle,name)
	draw_set_alpha( 1 )
}
else{
	draw_sprite_ext(sprite,0,w_x-xoffset-check_closed,w_y+26+yoffset+check_closed,scale,scale,26.5*(scale=2.5),c_white,1)
	if global.wantsave{
		//if fork(){
			//save()
			global.wantsave = 0
		//	exit;
		//}
	}
}

instance_delete(id)

#define setplayerwep(_index)

var race = player_get_race(_index)
var gwep = g_list[| racemap[? race]][2]
var gcrown = mod_variable_get("mod","mw_ui_crowns","wantcrown")

with player_find(_index){
	wep = g_list[| racemap[? race] ][ gwep ]
	if wep = wep_super_disc_gun curse = 1
	ammo[weapon_get_type(wep)] = typ_ammo[weapon_get_type(wep)]*3
	
	var data = mod_script_call("mod", "ModdedWeeklies", "get_current_data");
	if "bwep" in data && data.bwep != false{
		bwep = data.bwep
		ammo[weapon_get_type(bwep)] = typ_ammo[weapon_get_type(bwep)]*3
	}else if race_id == char_steroids {
		bwep = wep_revolver
	}else {
		bwep = 0
	}
	
	GameCont.crown = gcrown
	
	
	//with(instance_create(0, 0, Revive)){
	//  try{
	//    p = other.index;
	//    instance_change(Player, false);
	//    wep = other.wep
	//    event_perform(ev_other, ev_room_end);
	//    instance_delete(self);
	//  }
	//  catch(_error){}
	//}
}
