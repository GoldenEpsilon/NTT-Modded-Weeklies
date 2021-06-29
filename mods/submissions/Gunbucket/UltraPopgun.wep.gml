//world's laziest ultra weapon

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraPopgun.png",5,2)

#define weapon_name
return "Ultra Pop Gun";

#define weapon_sprt
return global.sprite;

#define weapon_rads
return 1.5

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 2;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)POPOPOPOPOPOP";

#define weapon_fire

repeat(2)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndPopgun,0.7,1);
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),UltraShell)
    {
      direction = other.gunangle + (random_range(6, -6) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
  wait(4);
}
