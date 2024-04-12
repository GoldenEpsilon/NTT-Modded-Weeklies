

#macro debug false


//crown [ forced? , crown1 , crown2 , crown3 ...]

global.mod_bigcrown = sprite_add("sprites/mod_mutation.png",1,8,8)

global.currentcrown = 1
global.wantcrown = 1

global.crowns = [0]

update_information_cool_script()

#define game_start
if debug
trace("crownmod: ",global.wantcrown)

#define update_information_cool_script

global.modedata = mod_script_call("mod", "ModdedWeeklies", "get_current_data");

if debug{
    
    global.modedata = {
        "name": "Testing Bed",
        "description": false,
        "can_resubmit": false,
        
        "crown": [false, 7],
        "wep": [true],
        "bwep": false,
        "race": [1,2,3,4,5],
        
        "disable_vaults": false,
        
        "seed": 7,
        "mods": [
            {}
        ],
    }
    
	// add all the crowns
	var _crowns = [1,2,3,4,5,6,7,8,9,10,11,12,13]
	var _moddedcrowns = mod_get_names("crown")
	for(var _mc = 0; _mc < array_length(_moddedcrowns); _mc ++){
	    _crowns[array_length(_crowns)] = _moddedcrowns[_mc]
	}
	    
	for (var ccc = 1;ccc<array_length(_crowns);ccc++){
	global.modedata.crown[array_length(global.modedata.crown)]	= _crowns[ccc]
	}
}

if("crown" in global.modedata) {
    if !is_array(global.modedata.crown) {
        global.modedata.crown = [global.modedata.crown];
    }
    global.crowns = global.modedata.crown
}


#define draw_gui_end
with Loadout{
    with LoadoutCrown{
        instance_delete(id)
    }
    
    
    var crown_y_offset = 45
    
    //selected gold pos
    var w_x = game_width -40 -40*(Loadout.openanim/4);
    var w_y = game_height-30-(36*(Loadout.openanim/4))-crown_y_offset;
    
    var l_x = game_width -72-32;
    var r_x = game_width -72+52;
    var b_y = game_height-70-8-crown_y_offset;
    
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
    var num = global.currentcrown;	//
    var _how_many_crowns = array_length(global.crowns)
    var b_size = 8;
    var check_left = point_in_rectangle(mouse_x-view_xview_nonsync,mouse_y-view_yview_nonsync,l_x-b_size,b_y-b_size,l_x+b_size,b_y+b_size);
    var check_right= point_in_rectangle(mouse_x-view_xview_nonsync,mouse_y-view_yview_nonsync,r_x-b_size,b_y-b_size,r_x+b_size,b_y+b_size);
    //var check_middle = point_in_rectangle(mouse_x,mouse_y,w_x-b_size,b_y-b_size,w_x+b_size,b_y+b_size);
    
    var c_x = view_xview_nonsync+game_width -107;
    var c_y = view_yview_nonsync+game_height-67-crown_y_offset;
    var check_closed = point_in_rectangle(mouse_x,mouse_y,c_x,c_y,view_xview_nonsync+game_width,c_y+31);
    var check_middle = point_in_rectangle(mouse_x,mouse_y,c_x-20,c_y-30,view_xview_nonsync+game_width,c_y+31);
    
    var clicked_left = 0;
    var clicked_right = 0;
    
    //make buttons work
    if check_right and button_pressed(0,"fire") and _how_many_crowns>2{
        if num < _how_many_crowns-1
            num += 1
        else
            num = 1
        global.currentcrown = num
        global.wantcrown = global.crowns[num]
        clicked_right = 2;
        anim -= 2
    }
    if check_left and button_pressed(0,"fire") and _how_many_crowns>2{
        if num > 1
            num -= 1
        else
            num = _how_many_crowns-1 //
        global.currentcrown = num
        global.wantcrown = global.crowns[num]
        clicked_left = 2;
        anim -= 2
    }
    
    //if selected
    //if global.information.crown[0]
    //    draw_sprite(sprite,index,game_width-48,game_height-112)
    
    //global.wantcrown = global.crowns[num]
    //trace(global.wantcrown)
    
    var sprite = sprLoadoutCrown
    var index = global.wantcrown
    var xoffset = 0
    var yoffset = 0
    var scale = 1
    var customsprite = false
    var name = crown_get_name(index)
    
    if is_string(global.wantcrown){
        sprite = global.mod_bigcrown
        index = 0
    	name = "mod"
    	if mod_exists("crown",global.wantcrown){
    	    if mod_variable_exists("crown",global.wantcrown,"crown_name")
    	    name = mod_variable_get("crown",global.wantcrown,"crown_name")
    	    else name = global.wantcrown
    	    
    	}
    }
    
    if global.wantcrown = -1{
        name = "none"
        index = 0
    }
    
        
//draw things
    if open{
    	//buttons
        draw_sprite_ext(sprDailyArrow,0,l_x-clicked_left,b_y+(anim)+!check_left,1,1,0,(check_left ? c_white:c_gray),_how_many_crowns>2?1:0)
        draw_sprite_ext(sprDailyArrow,1,r_x+clicked_right,b_y+(anim)+!check_right,1,1,0,(check_right ? c_white:c_gray),_how_many_crowns>2?1:0)
        //wep
        draw_sprite_ext(sprite,index,
        w_x-xoffset+lengthdir_x(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_x(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
        w_y+(anim)+yoffset+check_middle+lengthdir_y(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_y(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
        scale,scale,26.5*(scale=2.5),c_white,1)
    
    	//text
    	draw_set_halign(2)
    	
    	//if string_length(name)>18
    	//	draw_sprite_ext(sprLoadoutSplat,3,w_x+(anim*16)-6-(4*string_length(name)),w_y+45,1,1,0,c_white,1)
    	//else if string_length(name)<8{
    	//	draw_set_halign(1)
    	//	w_x -= 30
    	//}
    	draw_set_alpha( (check_middle ? 1:0.5) )
    	draw_text_nt(w_x+64+(anim*16),w_y+8+!check_middle,name)
    	draw_set_alpha( 1 )
    }
    else{
    	
    	
    	
        draw_sprite_ext(sprite,index,
        w_x-xoffset+lengthdir_x(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_x(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
        w_y+(anim)+yoffset+!check_middle+lengthdir_y(sprite_get_xoffset(sprite)*(scale)*(!customsprite),0)+lengthdir_y(sprite_get_yoffset(sprite)*(scale)*(!customsprite),90),
        scale,scale,26.5*(scale=2.5),c_white,1)//if global.wantsave{
    	//	//if fork(){
    	//		//save()
    	//		global.wantsave = 0
    	//	//	exit;
    	//	//}
    	//}
    }

    
    
    
}



