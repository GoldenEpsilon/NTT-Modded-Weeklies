//this was Mac's idea, this will probably kill you

#define init
global.sprite = sprite_add_weapon("sprites/sprSawnOffGrenadeShotgun.png",1,3)

#define weapon_name
return "SAWED-OFF GRENADE SHOTGUN";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 30;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 11;

#define weapon_text
return "@(color:16745694)BE CAREFUL";

#define weapon_fire
motion_add(gunangle,-5);
repeat(9)
{
  if instance_exists(self)
  {
    weapon_post(12, -8, 8);
sound_play_pitchvol(sndGrenadeShotgun,0.7,1);
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),MiniNade)
    {
      direction = other.gunangle + (random_range(50, -50) * other.accuracy);
      speed = 12;
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
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),MiniNade)
    {
      direction = other.gunangle + (random_range(50, -50) * other.accuracy);
      speed = 12;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}