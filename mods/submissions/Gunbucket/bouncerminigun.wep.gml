//this is probably the laziest weapon in the mod, but I like bouncy bullets too much to remove it

#define init
global.sprite = sprite_add_weapon("sprites/sprBouncerMinigun.png",4,3)

#define weapon_name
return "Bouncer Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 1;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)BOUNCY DESTRUCTION";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndBouncerSmg);
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),BouncerBullet)
    {
      direction = other.gunangle + (random_range(17, -17) * other.accuracy);
      speed = 6;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
  wait(4);
}
