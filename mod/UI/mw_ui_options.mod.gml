global.sprdailyicons = sprite_add("sprites/DailyIcons.png", 8, 0, 0);
global.sprtoggle = sprite_add("sprites/Toggle.png", 2, 4, 4);
global.sprOptions = sprite_add("sprites/sprOptions.png", 0, 0, 0);

#macro debug false
#macro button_position_from_right 4

//save the options somewhere
//update_campfire runs when an option is changed


if debug
global.test_options = {
	area_display: true,
	mini_intros: true,
	ntt_characters: true,
	}


global.option_opening = [0,64]     //  min/start,max
#macro option_opening global.option_opening
#macro option_anim option_opening[0]/option_opening[1]

update_campfire()

#define toggleOptions()
//mod_variable_set("mod", "mw_ui", "menu_opened", false)


with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
	instance_destroy();
}
with instances_matching(CustomObject,"name","mod_ui_desc"){
    instance_destroy();
}
if(array_length(instances_matching(CustomObject,"name","mod_ui_option"))) {
    with instances_matching(CustomObject,"name","mod_ui_option"){
        instance_destroy();
    }
    return; 
}
var options = mod_script_call("mod", "ModdedWeeklies", "get_options");
if debug {options = global.test_options}

var i = 0;
while(lq_get_key(options, i) != undefined){
    with instance_create(game_width-16,36+i*14,CustomObject){
        name = "mod_ui_option";
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
        text = lq_get_key(options, i)
        val = lq_get_value(options, i)
        index = i
        if fork(){
		wait(0)
        while instance_exists(self){
            var hover = 0;
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and 
                
                point_in_rectangle(mouse_x[i],mouse_y[i],
                view_xview[i]+x-72,    view_yview[i]+y,
                view_xview[i]+x+16, view_yview[i]+y+12){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire") and option_anim = 1{
                        val = !val;
                        lq_set(mod_script_call("mod", "ModdedWeeklies", "get_options"), text, val)
                        mod_script_call("mod", "ModdedWeeklies", "save_options")
                        if debug {
                            lq_set(global.test_options,text,val)
                        }
                        update_campfire()
                        
                    }
                    hover = 1;
                }
            }

            if hover = 1{
                yoffset = -1;
                image_blend = c_white
            }else{
                yoffset = 0;
                image_blend = c_gray
            }
            wait 0;
        }
        exit;
        }
    }
    i++;
}

#define draw_gui

if debug and button_pressed(0,"horn")
    trace(global.test_options)

// if scoreboard opened delete options
//if mod_variable_get("mod", "mw_ui", "menu_opened") {
//    with instances_matching(CustomObject,"name","mod_ui_option"){
//        instance_destroy();
//    }
//}

//create options button
if(instance_exists(Menu))
if array_length(instances_matching(CustomObject,"name","mod_ui_options_button"))<1{
    with instance_create(game_width-4-(20*button_position_from_right),7,CustomObject){
        name = "mod_ui_options_button";
        sprite_index = global.sprOptions;//global.swapButtonImage;
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
    with instances_matching(CustomObject,"name","mod_ui_options_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
        if array_length(instances_matching(CustomObject,"name","mod_ui_option")){
            var xx = 1
            var yy = 1
            draw_sprite_ext(global.sprdailyicons,7,x,y+yoffset,xscale,yscale,0,image_blend,1);
            //draw_rectangle_color(x+xx,y+yy+yoffset,x+xx+13,y+yy+sprite_get_yoffset(sprite_index)+yoffset+21,image_blend,image_blend,image_blend,image_blend,1)
        }
        
    } 
}

//animations
if array_length(instances_matching(CustomObject,"name","mod_ui_option")){ //ease in
    if option_opening[0] < option_opening[1]
        option_opening[0] += ((option_opening[1]-option_opening[0])/2)*current_time_scale
    
}else{  //ease out
    if option_opening[0] > 0
        option_opening[0] = max(0,(option_opening[0]-(16*current_time_scale)))
}

with Loadout {
    //if loadout opened close options
    if selected
        with instances_matching(CustomObject,"name","mod_ui_option"){
            instance_destroy();
        }
    
    draw_set_color(image_blend)
    //draw splat bg
    if round(option_opening[0])>1{
        var _sprite = array_length(instances_matching(CustomObject,"name","mod_ui_option"))? sprLoadoutOpen: sprLoadoutClose//global.sprLoadoutSplat
        draw_sprite_ext(_sprite,clamp((sprite_get_number(_sprite)-1)*option_anim,0,sprite_get_number(_sprite))-1,game_width+32,36,1,-1,0,c_white,1)
        
    }
    //draw options
    with instances_matching(CustomObject,"name","mod_ui_option"){
        var _y = 0//-32*!option_anim
        var _x = (game_width+(y*2))*(1-option_anim)
        draw_set_halign(2)
        //draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,c_white,1);
        draw_set_font(fntM)
        //draw_text(x-sprite_width+8, y+sprite_height/4+yoffset, text)
        draw_set_color(image_blend)
        draw_text((x-16)+_x, (y+4+yoffset)+_y, string_replace(string_replace(text, "co_op", "co-op"), "_", " "))
        draw_set_color(c_white)
        draw_sprite_ext(global.sprtoggle,val,(x)+_x,(y+sprite_height/4+yoffset)+_y,2,2,0,c_white,1);
        draw_set_halign(0)
    } 
    
    draw_set_color(c_white)
    
}
#define update_campfire

var options = mod_script_call("mod", "ModdedWeeklies", "get_options");
if debug
var options = global.test_options
else{
	wait file_load("ModdedWeeklies");
	var options = mod_script_call("mod", "ModdedWeeklies", "get_options");
}

  
if options.ntt_characters{
    race_set_active(15,1);
    race_set_active(14,1);
}
else{
    race_set_active(15,0);
    with instances_matching(CampChar,"num",15) instance_delete(id);
    race_set_active(14,0);
    with instances_matching(CampChar,"num",14) instance_delete(id);
}
/*if options.bigdog
    race_set_active(13,1);
else
    race_set_active(13,0);*/



#define cleanup
    with instances_matching(CustomObject,"name","mod_ui_options_button"){
        instance_destroy();
    }
    with instances_matching(CustomObject,"name","mod_ui_option"){
        instance_destroy();
    }