//another lazy minigun wep, miniguns are fun ok!?

#define init
global.sprite = sprite_add_weapon("sprites/sprSplinterMinigun.png",5,5)

#define weapon_name
return "Splinter Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 3;

#define weapon_auto
return true;

#define weapon_load
return 2;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapBow;

#define weapon_area
return 12;

#define weapon_text
return "@(color:16745694)RAINING NEEDLES";

#define weapon_fire

repeat(5)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndSplinterGun);
    with instance_create(x,y,Splinter)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 14 + irandom(2);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
}
}
