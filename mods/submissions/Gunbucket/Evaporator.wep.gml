//BWOOSH

#define init
global.sprite = sprite_add_weapon("sprites/sprEvaporator.png",5,4)

#define weapon_name
return "EVAPORATOR";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 40;

#define weapon_cost
return 7;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 15;

#define weapon_text
return "@(color:16745694)ERASE THEM";

#define weapon_fire
    sound_play_pitchvol(sndEraser,0.6,1);

repeat(17)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    with instance_create(x,y,Slug)
    {
      direction = other.gunangle + (random_range(0, -0) * other.accuracy);
      speed = 6 + random_range(0,14);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
}
}
