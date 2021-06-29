//more bullets are better than less bullets

#define init
global.sprite = sprite_add_weapon("sprites/sprTripleMinigun.png",3,8)

#define weapon_name
return "Triple Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 1;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 12;

#define weapon_text
return "@(color:16745694)3 IS BETTER THAN 2!";

#define weapon_fire

motion_add(gunangle,-2);
repeat(3)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndDoubleMinigun);
    with instance_create(x,y,Bullet1,)
    {
      direction = other.gunangle + (random_range(28, -28) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
	}
}
