//I thought about making this thing destroy walls, nah
//turns out its better to use in bursts instead of holding it down, neat!

#define init
global.sprite = sprite_add_weapon("sprites/sprJackhaminator.png",3,7)
global.sprJackhaminatorHud = sprite_add_weapon("sprites/hudsprites/sprJackhaminatorHud.png",1,3.5,);

#define weapon_name
return "The Jackhaminator";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprJackhaminatorHud;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 1;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapMotorized;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)CONSTRUCT THE FUTURE";

#define weapon_fire

repeat(3)
{
  if instance_exists(self)
  {
    weapon_post(-8, -8, 8);
    sound_play_pitchvol(sndJackHammer,0.5,2);
  with instance_create(x+lengthdir_x(skill_get(13)*12,gunangle),y+lengthdir_y(skill_get(13)*12,gunangle),Shank)
    {
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
      image_xscale = 2;
      image_yscale = image_xscale;
      speed = 12;
      image_angle = direction;
      damage = 12
      team = other.team;
      creator = other;
    }
  with instance_create(x+lengthdir_x(skill_get(13)*12,gunangle),y+lengthdir_y(skill_get(13)*12,gunangle),Shank)
    {
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
      image_xscale = 2;
      image_yscale = image_xscale;
      speed = 12;
      image_angle = direction;
      damage = 12
      team = other.team;
      creator = other;
    }
	}
  wait(4);
}
