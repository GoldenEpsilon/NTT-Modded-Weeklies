#define init
global.sprButton = sprite_add("Sprites/Main/Muscle Memory.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Muscle Memory Icon.png", 1, 8, 8)

#define skill_name
	return "Muscle Memory";
	
#define skill_text
	return "Reflected bullets attack#the nearest enemy";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return choose("Reflexes", "Reflected bullets#are now faster!", "Reflected bullets#deal more damage!");
	
#define skill_take
	sound_play(sndMutHammerhead);
	
#define step
with(Player){
	with(instances_matching_ne(projectile, "team", team)){
		if(fork()){
			var _t = other.team;
			wait(0);
			if(instance_exists(self) && instance_exists(enemy) && team == _t){
				var i = instance_nearest(x,y,enemy);
				direction = point_direction(x,y,i.x,i.y);
				image_angle = direction;
				speed *= 2 + 0.5 * skill_get(mod_current);
				damage += skill_get(mod_current);
			}
			exit;
		}
	}	
}