global.swapButtonImage = sprite_add("DailyIcons.png", 7, 0, 0);

#define createOptions()
with instances_matching(CustomObject,"name","mod_ui_option"){
	instance_destroy();
} 
var options = mod_script_call("mod", "ModdedWeeklies", "get_options");
var i = 0;
while(lq_get_key(options, i)){
    with instance_create(game_width/2,32+i*16,CustomObject){
        name = "mod_ui_option";
        sprite_index = sprScoreSplat;
		image_index = i;
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
            
            //y = ystart - 210*menu_anim - 64*_loadout
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        
                        exit;
                    }
                    hover = 1;
                }
            }
            
            /*if hover = 1{
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
            }*/
            wait 0;
        }
        exit;
        }
    }
}

#define draw_gui
if(instance_exists(Menu))
if array_length(instances_matching(CustomObject,"name","mod_ui_options_button"))<1{
    with instance_create(game_width-58,7,CustomObject){
        name = "mod_ui_options_button";
        sprite_index = global.swapButtonImage;
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
            
            //y = ystart - 210*menu_anim - 64*_loadout
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                        createOptions();
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

with Loadout {
    with instances_matching(CustomObject,"name","mod_ui_options_button"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
    } 
    with instances_matching(CustomObject,"name","mod_ui_option"){
        draw_sprite_ext(sprite_index,image_index,x,y+yoffset,xscale,yscale,0,image_blend,1);
    } 
}