//thank you Mufina for this weapons sprite!
//I don't know how to do the cool particle thing, one day ill figure it out and it will be really cool, for now its just kinda cool

#define init
global.sprite = sprite_add_weapon("sprites/sprFlameSword.png",4,5)
global.sprFlameMegaSlash = sprite_add("sprites/sprFlameMegaSlash.png",3,0,36)
global.sprFlameSwordGroundParticle = sprite_add("sprites/sprFlameSwordGroundParticle.png",4,3,3)
global.sprFlameSwordHud = sprite_add_weapon("sprites/hudsprites/sprFlameSwordHud.png",1,3.5,);
global.d = [true, true, true, true]

#define weapon_name
return "FLAME SWORD";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprFlameSwordHud;


#define weapon_type
return 4;

#define weapon_melee
return true;

#define weapon_auto
return false;

#define weapon_load
return 25;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapSword;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)SEARING SLICES";

#define weapon_fire

sound_play(sndBlackSword);
sound_play(sndFireShotgun);
weapon_post(0, 4, 12);

  with instance_create(x+lengthdir_x(3,gunangle),y+lengthdir_y(3,gunangle),CustomSlash)
    {
              sprite_index = global.sprFlameMegaSlash;
              mask_index = mskMegaSlash;
      direction = other.gunangle
      image_xscale = 1;
      image_yscale = image_xscale;
      image_speed = 0.4;
      speed = 1.2 * (skill_get(13) + 2.7);
      image_angle = direction;
      damage = 25
      team = other.team;
      creator = other;
      on_draw = script_ref_create(flameslash_draw);
      on_hit = script_ref_create(flameslash_hit);
      on_step = script_ref_create(flameslash_step);
    }
wepangle = -wepangle;
motion_add(gunangle, 3.5);
    
#define flameslash_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.9);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.1*image_xscale, 1.1*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

#define flameslash_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}
#define flameslash_step
repeat(5)
{
  with instance_create(x+lengthdir_x(3,random_range(20, -20)),y+lengthdir_y(3,random_range(20, -20)),Flame)
{
      team = other.team;
      creator = other;
     speed = 5 + (skill_get(13) + 2);
     image_angle = other.image_angle;
     direction = other.direction + random_range(20, -20);
}
}

//particles (the lame ones not the cool one)
#define prt_create
	{
	with(instance_create(x, y, CustomObject))
		{
		direction = argument0
		sprite_index = global.sprFlameSwordGroundParticle
		image_speed = 0.4
		speed = argument2
		time = argument1
		on_step = prtStep
		
		return self
		}
	}
	
#define step
	{
	var ws = current_time_scale * 4
	if(argument0)
		{
		if(wkick > 0)
			{wkick -= ws}
		if(speed && global.d[@index])
			{
			if(fork())
				{
				var i = index
				wait(5)
				if(instance_exists(self))
					{prt_create(random(360), 30, random(1))}
				global.d[@i] = true
				}
			else{
				global.d[@index] = false
				exit
				}
			}
		}
	else{
		if(bwkick > 0)
			{bwkick -= ws}
		}
	}

#define prtStep
	{
	if(time)
		{
		time -= current_time_scale
		exit
		}
	instance_destroy()
	}