#define init
global.sprButton = sprite_add("Sprites/Main/Energized Intestines.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Energized Intestines Icon.png", 1, 8, 8)
global.sprBurningLaser = sprite_add("Sprites/BurningLaser.png", 1, 2, 3)

#define skill_name
	return "Energized Intestines";
	
#define skill_text
	return "@wBolts@s in @wwalls@s#zap enemies";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "It's rave time";
	
#define skill_take
	sound_play(sndMutTriggerFingers)
	
#define step
with(instances_matching([Bolt, HeavyBolt, ToxicBolt, Seeker, Splinter, Disc, UltraBolt, SplinterBurst, CustomProjectile], "speed", 0)){
	if((object_index == CustomProjectile || object_index == CustomSlash) && (mask_index != mskBolt && mask_index != mskHeavyBolt)){
		continue;
	}
	if("eitimer" not in self){eitimer = 0;}
	if((eitimer * skill_get(mod_current)) % 12 == 0){
		with instance_create(x,y,Lightning){
			alarm0 = 4;
			ammo = 8;
			var nearest = instance_nearest(x,y,enemy);
			if(nearest == noone){
				nearest = creator;
			}
			if(nearest != noone){
				image_angle = point_direction(x,y,nearest.x,nearest.y);
			}else{
				image_angle = other.image_angle;
			}
			team = other.team;
		}
	}
	eitimer++;
}