global.swapButtonImage = sprite_add("DailyIcons.png", 8, 0, 0);

#define toggleModeSelectionButtons()
mod_variable_set("mod", "ui", "menu_opened", false)
with instances_matching(CustomObject,"name","mod_ui_option"){
	instance_destroy();
}
if(array_length(instances_matching(CustomObject, "name", "mod_ui_mode_button")) > 0) {
	with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
		instance_destroy();
	}
	return;
}
var modedata = mod_variable_get("mod", "ModdedWeeklies", "data");
if(array_length(modedata) == 0) {
    trace("No valid dailies/weeklies available!")
    trace("Are you offline?")
}
for(var i = 0; i < array_length(modedata); i++) {
	with instance_create(game_width/2 - ((array_length(modedata)/2 - i) * 72),game_height/2-48,CustomObject){
		name = "mod_ui_mode_button";
		sprite_index = global.swapButtonImage;
        image_index = "valid" in modedata[i] && modedata[i].valid ? modedata[i].index : 4;
		modeName = modedata[i].modeName;
		xscale = 4;
		yscale = 4;
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
			
			//y = ystart - 210*menu_anim - 64*_loadout
			
			for(var i=0;i<maxp;i++){
				if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index)*xscale,view_yview[i]+y+sprite_get_height(sprite_index)*yscale){
					//trace(choose(""," ","  "),"hover")
					if button_pressed(i,"fire"){
                        mod_variable_set("mod", "ModdedWeeklies", "currentMode", modeName);
						with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
							instance_destroy();
						}
                        mod_script_call("mod", "ModdedWeeklies", "loadAllMods");
						exit;
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

#define draw_gui
if mod_variable_get("mod", "ui", "menu_opened") && array_length(instances_matching(CustomObject, "name", "mod_ui_mode_button")) > 1 {
	with(instances_matching(CustomObject, "name", "mod_ui_mode_button")){
		instance_destroy();
	}
}
if(instance_exists(Menu))
if array_length(instances_matching(CustomObject,"name","mod_ui_mode_swap_button"))<1{
	var modedata = mod_script_call("mod", "ModdedWeeklies", "get_current_data");
    with instance_create(game_width-43,7,CustomObject){
        name = "mod_ui_mode_swap_button";
        sprite_index = global.swapButtonImage;
		image_index = "index" in modedata ? ("valid" in modedata && modedata.valid ? modedata.index : 4) : 0;
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
			modedata = mod_script_call("mod", "ModdedWeeklies", "get_current_data")
			image_index = "index" in modedata ? ("valid" in modedata && modedata.valid ? modedata.index : 4) : 0;

            var hover = 0;
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        //exit;
                        toggleModeSelectionButtons();
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
    with instances_matching(CustomObject,"name","mod_ui_mode_swap_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
    } 
    with instances_matching(CustomObject,"name","mod_ui_mode_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
        draw_set_font(fntM)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_text(x+sprite_width/2*xscale, y+yoffset+10, string_replace(modeName, " ", "#"));
		draw_set_halign(0)
		draw_set_valign(0)
    } 
}

#define cleanup
    with instances_matching(CustomObject,"name","mod_ui_mode_swap_button"){
        instance_destroy();
    }
    with instances_matching(CustomObject,"name","mod_ui_mode_button"){
        instance_destroy();
    }