//LOTTA NUKES

#define init
global.sprite = sprite_add_weapon("sprites/sprNukabazook.png",10,7)

#define weapon_name
return "SUPER NUKABAZOOK";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 120;

#define weapon_cost
return 12;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)THIS IS A GOOD IDEA!";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
  	    weapon_post(12, -8, 8);
sound_play_pitchvol(sndNukeFire,0.6,1);
    	for(i = -14; i <= 14; i += 7)
  with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Nuke)
{
  direction = other.gunangle + (other.i * other.accuracy) + (random_range(-0,0) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;

    }
	}
}
	
