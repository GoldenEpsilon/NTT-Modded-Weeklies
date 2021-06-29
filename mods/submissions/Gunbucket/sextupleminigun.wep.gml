//It actually isn't a sex joke, sextuple means six

#define init
global.sprite = sprite_add_weapon("sprites/sprSextupleMinigun.png",3,15)

#define weapon_name
return "Sextuple Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 1;

#define weapon_cost
return 6;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 15;

#define weapon_text
return "@(color:16745694)SEXTUPLE MEANS SIX";

#define weapon_fire

motion_add(gunangle,-3);
repeat(6)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndDoubleMinigun);
    with instance_create(x,y,Bullet1,)
    {
      direction = other.gunangle + (random_range(50, -50) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
}
}