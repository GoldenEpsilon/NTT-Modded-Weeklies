#define init
global.sprButton = sprite_add("Sprites/Main/Fractured Fingers.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Fractured Fingers Icon.png", 1, 8, 8)
global.sprRocketExplo = sprite_add("Sprites/RocketExplo.png", 7, 12, 12)

#define skill_name
	return "Fractured Fingers";
	
#define skill_text
	return "Enemies killed by explosions#@wexplode@s";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "Explosion babies";
	
#define skill_take
	sound_play(sndMutTriggerFingers)
	
#define step

with(instances_matching_le(enemy, "my_health", 0)){
	if("FracturedFingers" not in self){
		FracturedFingers = 1;
		with(Explosion){
			if(object_index == PopoExplosion){continue;}
			if("FracturedFingers" not in self){
				FracturedFingers = 1;
			}else{
				if(FracturedFingers > skill_get(mod_current)){continue;}
				FracturedFingers++;
			}
			if(distance_to_object(other) < sqrt(sqr((sprite_width*image_xscale)/2)+sqr((sprite_height*image_yscale)/2))){
				if("rocketcasings" in self && rocketcasings){
					with(instance_create(x + lengthdir_x(32,point_direction(x,y,other.x,other.y)),y + lengthdir_y(32,point_direction(x,y,other.x,other.y)),CustomProjectile)){
						rocketcasings = true;
						duplicators = true;
						damage = skill_get("Rocket Casings");
						timer = 8;
						team = _t;
						image_speed = 0.4;
						sprite_index = global.sprRocketExplo;
						hitid = [sprite_index, "ROCKET AMMO"];
						mask_index = mskSmallExplosion;
						on_wall = rocketWall;
						on_hit = rocketHit;
						on_step = rocketStep;
						with(instance_create(x,y,SmallExplosion)){
							sprite_index = mskNone;
							image_index = mskNone;
						}
						exit;
					}
				}else{
					with(instance_create(x + lengthdir_x(sprite_width,point_direction(x,y,other.x,other.y)),y + lengthdir_y(sprite_width,point_direction(x,y,other.x,other.y)),object_index)){
						FracturedFingers = other.FracturedFingers + 1;
						team = other.team;
						WasteGland = irandom(1);
					}
				}
			}
		}
	}
}
/*
with(PopoExplosion){
	if("FracturedFingers" not in self){FracturedFingers = 1;}
}
with(SmallExplosion){
	if(instance_exists(self) && "FracturedFingers" not in self){
		FracturedFingers=1;
		var _x=x,_y=y,_t=team;
		if(fork()){
			wait(10);
			if("rocketcasings" in self && rocketcasings){
				with(instance_create(_x,_y,SmallExplosion)){
					rocket = true;
					damage = 2;
					sprite_index = global.sprRocketExplo;
					var _mask = mask_index;
					mask_index = mskNone;
					if(fork()){
						wait(4);
						if(instance_exists(self)){
							mask_index = _mask;
							with(hitme){
								if(place_meeting(x,y,other) && projectile_canhit(other)){
									projectile_hit(self, other.damage);
								}
							}
							mask_index = mskNone;
						}
					}
				}
			}else{
				with(instance_create(_x,_y,SmallExplosion)){
					FracturedFingers=1;
					team=_t;
					WasteGland = 1;
				}
			}
			exit;
		}
	}
}
with(Explosion){
	if(instance_exists(self) && "FracturedFingers" not in self){
		FracturedFingers=1;
		var _x=x,_y=y,_t=team;
		if(fork()){
			wait(10);
			with(instance_create(_x,_y,Explosion)){
				FracturedFingers=1;
				team=_t;
				WasteGland = 1;
			}
			exit;
		}
	}
}*/