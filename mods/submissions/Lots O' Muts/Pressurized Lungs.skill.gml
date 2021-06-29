#define init
global.sprButton = sprite_add("Sprites/Main/Pressurized Lungs.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Pressurized Lungs Icon.png", 1, 8, 8)

#define skill_name
	return "Pressurized Lungs";
	
#define skill_text
	return "@wFlames@s knock back enemies";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "It's the terror of knowing#what this world is about";
	
#define skill_take
	sound_play(sndMutTriggerFingers)
	
#define step
with(Player){
	script_bind_step(custom_step, 0, team);
}

#define custom_step(_t)
instance_destroy();
with(instances_matching_ne(instances_matching(Flame, "team", _t), "pressurizedTime", current_frame)){
	pressurizedTime = current_frame;
	with(instance_rectangle_bbox(bbox_left, bbox_top, bbox_right, bbox_bottom, instances_matching_ne(enemy, "team", team))){
		if(speed < 1){
			motion_set(other.direction, 2 + 2 * skill_get(mod_current));
		}else{
			speed -= skill_get(mod_current) * current_time_scale;
		}
	}
}
	
#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing "place_meeting()" with every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);