//this is a fucked up version of SpazProject's Hyper Magnum, I hardly understand it but its working!

#define init
//sprites
global.sprite = sprite_add_weapon("sprites/sprMelodaser.png",12,9)
global.sprMelolaser = sprite_add("sprites/sprMelolaser.png",1,2,3)
global.mskMelolaser = sprite_add("sprites/mskMelolaser.png",1,2,3)
global.sprMelodaserSpark = sprite_add("sprites/sprMelodaserSpark.png",12,4,4)
global.sprMelodaserImpact = sprite_add("sprites/sprMelodaserPlasmaImpact.png",7,16,16)
global.sprMelodaserMuzzleflash = sprite_add("sprites/sprMelodaserMuzzleflash.png",6,24,24)
global.sprMelodaserHit = sprite_add("sprites/sprMelodaserHit.png",6,24,24)
//sounds
global.sndMelodaserFire1 = sound_add("sounds/sndMelodaserFire1.ogg");
global.sndMelodaserFire2 = sound_add("sounds/sndMelodaserFire2.ogg");
global.sndMelodaserFire3 = sound_add("sounds/sndMelodaserFire3.ogg");
#define weapon_name
return "Melodaser";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 10;

#define weapon_cost
return 4;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)WHAT A NICE MELODY";

#define weapon_fire

//Muzzleflash
with instance_create(x+lengthdir_x(32,gunangle),y+ lengthdir_y(32,gunangle),CustomObject)
{
	depth = -1
	sprite_index = global.sprMelodaserMuzzleflash;
	image_speed = 0.9;
	image_xscale = 1.4;
	image_yscale = image_xscale;
	on_step = muzzle_step
	on_draw = muzzle_draw
	image_angle = other.gunangle
}

//Projectile
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(choose(global.sndMelodaserFire1,global.sndMelodaserFire2,global.sndMelodaserFire3,));
  with instance_create(x+lengthdir_x(-2,gunangle),y+lengthdir_y(-2,gunangle),CustomProjectile)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_angle = direction;
      sprite_index = global.sprMelolaser;
      mask_index =global.mskMelolaser;
      tries = 65 + (skill_get(17) * 20); //distance the laser can fire (increased by LB)
      team = other.team;
      creator = other;
      damage = 16;
      typ = 0;
      
		script_bind_end_step(mlaser_hitscan, depth, id);
		

		return id;
	}
}
}


#define mlaser_hitscan(_instance)
	if(fork()){
		with(_instance){
			var _triesMax = tries;

			 // Hitscan:
			while(instance_exists(self) && tries-- > 0){
				x += lengthdir_x(4, direction);
				y += lengthdir_y(4, direction);

				 // Beam Effect:
				if(_triesMax - tries > 7 && !(tries mod 6)) with instance_create(x, y, BoltTrail){
					sprite_index = global.sprMelolaser;
					image_index = 1;
					image_speed = 0;
					image_xscale = 8;
					image_yscale = 4;
					image_angle = other.direction;
					if(fork()){
						while(instance_exists(self)){
						image_yscale -= 0.3;
							wait(1);
						}
						exit;
					}
				}

										
					//spawn particles
					if(_triesMax - tries > 7 && (random_range(1,20) > 15)) with instance_create(x+random_range(-3,3), y+random_range(-3,3), PlasmaTrail){
					depth = -2
					sprite_index = global.sprMelodaserSpark;
					image_angle = random_range(0,360);
					image_xscale = 1;
					image_yscale = image_xscale;								
					}


				 // Enemy/Prop Collisions:
				if(place_meeting(x,y,hitme)) with(hitme){
					if(place_meeting(x,y,other) && team != other.team) with(other){
							
						 // Hit Enemy
                        with(other){
                        if nexthurt <= current_frame{
                        projectile_hit(self,other.damage,other.force)
                        //Hit Particle
						with instance_create(x,y,CustomObject)
						{
						depth = -1
						sprite_index = global.sprMelodaserHit;
						image_speed = 0.9;
						image_xscale = 1.5;
						image_yscale = image_xscale;
						on_step = muzzle_step
						on_draw = muzzle_draw
						image_angle = direction;
							}	
                        }}
					}
				}


				 // Wall Collisions:
				 			var ox = lengthdir_x(4, direction);
							var oy = lengthdir_y(4, direction);
				if(place_meeting(x + ox, y + oy, Wall)){
				                with instance_create(x,y,PlasmaImpact){
				                    image_xscale = 1;
				                    image_yscale = image_xscale;
				                    sprite_index = global.sprMelodaserImpact;
				                }
								
								if(place_meeting(x + ox, y, Wall)){
									ox *= -1;
								} 
								else if(place_meeting(x, y + oy, Wall)){
									oy *= -1;
								}
								else{ 
									ox *=-1; oy *= -1; 
								} 
								direction = point_direction(x, y, x + ox, y + oy);}

				 // Slash Reflection: Destroyed on slashes
				with instances_matching(projectile, "object_index", Slash, GuitarSlash, EnergySlash, EnergyHammerSlash, BloodSlash, LightningSlash){
					if(place_meeting(x,y,other) && team != other.team) with(other){
						tries = 0;
					}
				}

				 // Shield Reflection: Destroyed on shields
				var	_shields = [CrystalShield, PopoShield];
				for(var i = 0; i < array_length_1d(_shields); i++) with(_shields[i]){
					if(place_meeting(x,y,other) && team != other.team) with(other){
						tries = 0;
					}
				}

				 // Shank Destruction:
				with instances_matching(projectile, "object_index", Shank, EnergyShank, HorrorBullet){
					if(place_meeting(x,y,other) && team != other.team) other.tries = 0;
				}
			}

			 // On Destroy:
			if(instance_exists(self)){
				with instance_create(x,y,PlasmaImpact){
					sprite_index = global.sprMelodaserImpact;
				}
				repeat(2) instance_create(x, y, Dust);
				instance_destroy();
			}
		}
		instance_destroy();
		exit;
	}
	
#define muzzle_step
if image_index > 5{instance_destroy()}

#define muzzle_draw
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.3*image_xscale, 1.3*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);