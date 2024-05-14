global.swapButtonImage = sprite_add("DailyIcons.png", 7, 0, 0);
global.toggleImage = sprite_add("Toggle.png", 2, 4, 4);

#define toggleOptions()
mod_variable_set("mod", "mw_ui", "menu_opened", false)
with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
	instance_destroy();
}
if(array_length(instances_matching(CustomObject,"name","mod_ui_option"))) {
    with instances_matching(CustomObject,"name","mod_ui_option"){
        instance_destroy();
    }
    return; 
}
var options = mod_script_call("mod", "ModdedWeeklies", "get_options");
var i = 0;
while(lq_get_key(options, i) != undefined){
    with instance_create(game_width/2,64+i*24,CustomObject){
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
        if fork(){
		wait(0)
        while instance_exists(self){
            var hover = 0;
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        val = !val;
                        mod_script_call("mod", "ModdedWeeklies", "set_option", text, val);
                    }
                    hover = 1;
                }
            }

            if hover = 1{
                yoffset = -1;
            }else{
                yoffset = 0;
            }
            wait 0;
        }
        exit;
        }
    }
    i++;
}

#define draw_gui
if mod_variable_get("mod", "mw_ui", "menu_opened") {
    with instances_matching(CustomObject,"name","mod_ui_option"){
        instance_destroy();
    }
}
if(instance_exists(Menu))
if array_length(instances_matching(CustomObject,"name","mod_ui_options_button"))<1{
    with instance_create(game_width-62-8,7-4,CustomObject){
        name = "mod_ui_options_button";
        sprite_index = sprOptions;
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
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        toggleOptions();
                    }
                    hover = 1;
                }
            }
            
            if hover = 1{
                //image_speed = 0.4;
                image_blend = c_white;
                image_alpha = 1;
                yoffset = -1;
            }
            else{
    			//if image_index+image_speed>=image_number or image_index<4{
    			//	image_index = 0;
    			//	image_speed = 0;
    			//}
    			
                image_blend = c_silver;
                image_alpha = 0.6;
                yoffset = 0;
            }
            wait 0;
        }
        exit;
        }
    }
}

with Loadout {
    with instances_matching(CustomObject,"name","mod_ui_options_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
    } 
    with instances_matching(CustomObject,"name","mod_ui_option"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
        draw_set_font(fntM)
        draw_text(x-sprite_width+8, y+sprite_height/4+yoffset, text)
        draw_sprite_ext(global.toggleImage,val,x+sprite_width-24,y+sprite_height/4+yoffset,2,2,0,image_blend,1);
    } 
}

#define cleanup
    with instances_matching(CustomObject,"name","mod_ui_options_button"){
        instance_destroy();
    }
    with instances_matching(CustomObject,"name","mod_ui_option"){
        instance_destroy();
    }