global.sprdailyicons = sprite_add("sprites/DailyIcons.png", 8, 0, 0);
global.sprtoggle = sprite_add("sprites/Toggle.png", 2, 4, 4);
global.sprMods = sprite_add("sprites/sprModList.png", 0, 0, 0);

#macro debug false
#macro button_position_from_right 3

//save the options somewhere
//update_campfire runs when an option is changed


if debug
global.test_options = {
	area_display: true,
	mini_intros: true
	}


global.option_opening = [0,64]     //  min/start,max
#macro option_opening global.option_opening
#macro option_anim option_opening[0]/option_opening[1]

#define toggleOptions()
//mod_variable_set("mod", "mw_ui", "menu_opened", false)


with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
	instance_destroy();
}
with(instances_matching(CustomObject, "name", "mod_ui_option")){
	instance_destroy();
}
if(array_length(instances_matching(CustomObject,"name","mod_ui_desc"))) {
    with instances_matching(CustomObject,"name","mod_ui_desc"){
        instance_destroy();
    }
    return; 
}
var data = mod_script_call("mod", "ModdedWeeklies", "get_current_data");

if "mods" not in data {
    data = mod_script_call("mod", "ModdedWeeklies", "get_mode_data", "Modded Weekly")
}
var i = 0;
if "name" in data {
    with instance_create(game_width-16,36+i*14,CustomObject){
        name = "mod_ui_desc";
        sprite_index = sprKilledBySplat;
        image_index = 2;
        xscale = 2;
        yscale = 1;
        image_speed = 0;
        depth = 0;
        yoffset = 1;
        visible = 0
        image_alpha = 0.6;
        xstart = x
        ystart = y
        text = data.name = false ? "" : data.name
        val = "description" in data ? data.description : false
        color = c_white
        if "color" in other {
            if is_string(other.color) {
                switch(string_lower(other.color)) {
                    case "aqua":
                        color = c_aqua;
                        break;
                    case "black":
                        color = c_black;
                        break;
                    case "blue":
                        color = c_blue;
                        break;
                    case "dkgray":
                        color = c_dkgray;
                        break;
                    case "fuchsia":
                        color = c_fuchsia;
                        break;
                    case "gray":
                        color = c_gray;
                        break;
                    case "green":
                        color = c_green;
                        break;
                    case "lime":
                        color = c_lime;
                        break;
                    case "ltgray":
                        color = c_ltgray;
                        break;
                    case "maroon":
                        color = c_maroon;
                        break;
                    case "navy":
                        color = c_navy;
                        break;
                    case "olive":
                        color = c_olive;
                        break;
                    case "orange":
                        color = c_orange;
                        break;
                    case "purple":
                        color = c_purple;
                        break;
                    case "red":
                        color = c_red;
                        break;
                    case "silver":
                        color = c_silver;
                        break;
                    case "teal":
                        color = c_teal;
                        break;
                    case "white":
                        color = c_white;
                        break;
                    case "yellow":
                        color = c_yellow;
                        break;
                }
            } else {
                color = other.color
            }
        }
        index = i
        if fork(){
        wait(0)
        while instance_exists(self){
            var hover = 0;
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and 
                
                point_in_rectangle(mouse_x[i],mouse_y[i],
                view_xview[i]+x-96,    view_yview[i]+y,
                view_xview[i]+x+16, view_yview[i]+y+12){
                    hover = 1;
                }
            }

            if hover = 1{
                yoffset = -1;
                image_blend = color
            }else{
                yoffset = 0;
                image_blend = merge_color(color, c_gray, 0.75)
            }
            wait 0;
        }
        exit;
        }
    }
    i += 1.5;
}

if "mods" in data {
    with(data.mods) {
        with instance_create(game_width-16,36+i*14,CustomObject){
            name = "mod_ui_desc";
            sprite_index = sprKilledBySplat;
            image_index = 2;
            xscale = 2;
            yscale = 1;
            image_speed = 0;
            depth = 0;
            yoffset = 1;
            visible = 0
            image_alpha = 0.6;
            xstart = x
            ystart = y
            text = other.name
            val = other.description
            color = c_white
            if "color" in other {color = other.color}
            index = i
            if fork(){
            wait(0)
            while instance_exists(self){
                var hover = 0;
                
                for(var i=0;i<maxp;i++){
                    if instance_exists(self) and 
                    
                    point_in_rectangle(mouse_x[i],mouse_y[i],
                    view_xview[i]+x-96,    view_yview[i]+y,
                    view_xview[i]+x+16, view_yview[i]+y+12){
                        hover = 1;
                    }
                }

                if hover = 1{
                    yoffset = -1;
                    image_blend = color
                }else{
                    yoffset = 0;
                    image_blend = merge_color(color, c_gray, 0.75)
                }
                wait 0;
            }
            exit;
            }
        }
        i++;
    }
}

#define draw_gui

if debug and button_pressed(0,"horn")
    trace(global.test_options)

// if scoreboard opened delete options
//if mod_variable_get("mod", "mw_ui", "menu_opened") {
//    with instances_matching(CustomObject,"name","mod_ui_desc"){
//        instance_destroy();
//    }
//}

//create options button
if(instance_exists(Menu))
if array_length(instances_matching(CustomObject,"name","mod_ui_mods_button"))<1{
    with instance_create(game_width-4-(20*button_position_from_right),7,CustomObject){
        name = "mod_ui_mods_button";
        sprite_index = global.sprMods;//global.swapButtonImage;
		image_index = 4;
		xscale = 1;
		yscale = 1;
        image_speed = 0;
        depth = 0;
        yoffset = 1;
        visible = 0
        image_alpha = 0.6;
        xstart = x
        ystart = y
        if fork(){
		wait(0)
        while instance_exists(self){
            var hover = 0;
            var _loadout = false
            with Loadout if selected _loadout = true
            
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        if _loadout 
                        with Loadout{
                            selected = false
                            with LoadoutCrown instance_delete(id)
                            with LoadoutSkin instance_delete(id)
                        }
                        toggleOptions()
                        
                    }
                    hover = 1;
                }
            }
            if hover = 1{
                //image_speed = 0.4;
                image_blend = c_white;
                //image_alpha = 1;
                yoffset = -1;
            }
            else{
    			//if image_index+image_speed>=image_number or image_index<4{
    			//	image_index = 0;
    			//	image_speed = 0;
    			//}
    			
                image_blend = c_silver;
                //image_alpha = 0.6;
                yoffset = 0;
            }
            
            if _loadout
            	image_blend = c_dkgray
            wait 0;
        }
        exit;
        }
    }
}

with(Loadout){
    //draw button
    with instances_matching(CustomObject,"name","mod_ui_mods_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
        if array_length(instances_matching(CustomObject,"name","mod_ui_desc")){
            var xx = 1
            var yy = 1
            draw_sprite_ext(global.sprdailyicons,7,x,y+yoffset,xscale,yscale,0,image_blend,1);
            //draw_rectangle_color(x+xx,y+yy+yoffset,x+xx+13,y+yy+sprite_get_yoffset(sprite_index)+yoffset+21,image_blend,image_blend,image_blend,image_blend,1)
        }
        
    } 
}

//animations
if array_length(instances_matching(CustomObject,"name","mod_ui_desc")){ //ease in
    if option_opening[0] < option_opening[1]
        option_opening[0] += ((option_opening[1]-option_opening[0])/2)*current_time_scale
    
}else{  //ease out
    if option_opening[0] > 0
        option_opening[0] = max(0,(option_opening[0]-(16*current_time_scale)))
}

with Loadout {
    //if loadout opened close options
    if selected
        with instances_matching(CustomObject,"name","mod_ui_desc"){
            instance_destroy();
        }
    
    //draw_set_color(image_blend)
    //draw splat bg
    if round(option_opening[0])>1{
        var _sprite = array_length(instances_matching(CustomObject,"name","mod_ui_desc"))? sprLoadoutOpen: sprLoadoutClose//global.sprLoadoutSplat
        draw_sprite_ext(_sprite,clamp((sprite_get_number(_sprite)-1)*option_anim,0,sprite_get_number(_sprite))-1,game_width,36,1,-1,0,c_white,1)
        
    }
    //draw options
    with instances_matching(CustomObject,"name","mod_ui_desc"){
        var _y = 0//-32*!option_anim
        var _x = (game_width+(y*2))*(1-option_anim)
        draw_set_halign(2)
        //draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,c_white,1);
        draw_set_font(fntM0)
        //draw_text(x-sprite_width+8, y+sprite_height/4+yoffset, text)
        //draw_set_color(image_blend)
        draw_text_nt((x)+_x, (y+4+yoffset)+_y, `@(color:${image_blend})`+text)
        //draw_set_color(c_white)
        draw_set_halign(0)
    } 
    draw_set_font(fntM0)
    //draw descriptions
    with instances_matching(CustomObject,"name","mod_ui_desc"){
        if(is_string(val)) {
            var hover = 0;
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and 
                point_in_rectangle(mouse_x[i],mouse_y[i],
                view_xview[i]+x-96,    view_yview[i]+y,
                view_xview[i]+x+16, view_yview[i]+y+12){
                    draw_set_color(make_color_rgb(15,15,25))
                    var _round = 0//max(0.2,((round((mouse_delta_y[i])*8))/8))
                    var xanim = -18
                    var yoffset = 12//18
                    var height = string_count("#", val)*8+4
                    var ybonus = 8
                    while (y+yoffset+height) > (game_height-16)
                    	yoffset-=8
                    draw_set_halign(2)
                    draw_rectangle(0,y-2+yoffset,game_width,y+yoffset-6,0)
                    draw_rectangle(0,y+yoffset,game_width,y+height+yoffset+ybonus,0)
                    draw_rectangle(0,y+height+2+yoffset+ybonus,game_width,y+height+yoffset+ybonus+4,0)
                    //draw_set_color(color)
                    draw_text_nt(game_width-16,y-8+yoffset,`@(color:${color})`+text)
                    //draw_set_color(c_silver)
                    draw_set_halign(0)
                    draw_text_nt(8,y+yoffset+2,"@s"+val);
                    draw_set_color(c_white)
                    draw_set_halign(0)
                    break;
                }
            }
        }
    }
    
    draw_set_color(c_white)
    
}



#define cleanup
    with instances_matching(CustomObject,"name","mod_ui_mods_button"){
        instance_destroy();
    }
    with instances_matching(CustomObject,"name","mod_ui_desc"){
        instance_destroy();
    }