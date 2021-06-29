#define init
global.sprButton = sprite_add("Sprites/Main/Confidence.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Confidence Icon.png", 1, 8, 8)

#define skill_name
	return "Confidence";
	
#define skill_text
	return "@wPower boost@s#at full health#(speed, reload speed, shot speed)";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;

#define skill_tip
	return "I CAN TAKE ON EVERYTHING!";
	
#define skill_take
	sound_play(sndMutRabbitPaw);
#define skill_lose
with(Player){
	if(my_health < maxhealth && confidence > 0){
		confidence = 0;
		maxspeed -= 0.5 * skill_get(mod_current);
		reloadspeed -= 0.3 * skill_get(mod_current);
	}
}
#define step
with(Player){
	if("confidence" not in self){
		confidence = 0;
	}
	if(my_health >= maxhealth && confidence == 0){
		confidence = 8;
		maxspeed += 0.5 * skill_get(mod_current);
		reloadspeed += 0.3 * skill_get(mod_current);
	}
	if(my_health < maxhealth && confidence > 0){
		confidence = 0;
		maxspeed -= 0.5 * skill_get(mod_current);
		reloadspeed -= 0.3 * skill_get(mod_current);
	}
	if(confidence > 1){confidence-= 1;}
}
script_bind_step(custom_step, 0);
#define custom_step
instance_destroy();
with(instances_matching(Player, "confidence", 1)){
	with(instances_matching_ne(instances_matching(projectile, "creator", self), "confidence", 1)){
		confidence = 1;
		speed *= 1 + 0.3 * skill_get(mod_current);
	}
}