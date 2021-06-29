//HAHA! I CAN MAKE SHOTGUNS NOW!

#define init
global.sprite = sprite_add_weapon("sprites/sprSawnOffFlameShotgun.png",0,2)

#define weapon_name
return "SAWED-OFF FLAME SHOTGUN";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 30;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 7;

#define weapon_text
return "@(color:16745694)WAVE OF FLAMES";

#define weapon_fire
motion_add(gunangle,-5);
repeat(9)
{
  if instance_exists(self)
  {
    weapon_post(12, -8, 8);
sound_play_pitchvol(sndDoubleFireShotgun,0.7,1);
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),FlameShell)
    {
      direction = other.gunangle + (random_range(50, -50) * other.accuracy);
      speed = 13;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}
  wait(1.5);
repeat(9)
{
  if instance_exists(self)
  {
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),FlameShell)
    {
      direction = other.gunangle + (random_range(50, -50) * other.accuracy);
      speed = 13;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}