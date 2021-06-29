#define init
global.sprButton = sprite_add("Sprites/Main/Staked Chest.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Staked Chest Icon.png", 1, 8, 8)

#define skill_name
	return "Staked Chest";
	
#define skill_text
	return "Piercing @wbolts@s#create @wsplinters@s";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "These things hurt";
	
#define skill_take
	sound_play(sndMutTriggerFingers)
	
#define step

with(instances_matching_le(enemy, "my_health", 0)){
	var list = [Bolt, HeavyBolt, ToxicBolt, UltraBolt, Disc, CustomProjectile];
	var temp = -4;
	for(var i = 0; i < array_length(list); i++){
		temp = instance_nearest(x,y,list[i]);
		if(temp >= 0 && distance_to_object(list[i]) < sqrt(sqr((sprite_width*image_xscale)/2)+sqr((sprite_height*image_yscale)/2))){
			with(temp){
				if((object_index == CustomProjectile || object_index == CustomSlash) && (mask_index != mskBolt && mask_index != mskHeavyBolt)){
					continue;
				}
				for(var i = 36; i < 360; i += 72 / skill_get(mod_current)){
					if(speed > 0){
						with(instance_create(x,y,Splinter)){
							direction = other.direction + i;
							image_angle = direction;
							speed = 12;
							team = other.team;
							creator = other.creator;
						}
					}
				}
			}
		}
	}
}