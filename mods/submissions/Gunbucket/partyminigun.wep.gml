//haha color ball go bweeeee

#define init
global.sprite = sprite_add_weapon("sprites/sprPartyMinigun.png",5,5)

#define weapon_name
return "Party Minigun";

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
return sndSwapFlame;

#define weapon_area
return 11;

#define weapon_text
return "@(color:16745694)THE PARTY NEVER STOPS";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndConfettiGun);
    with instance_create(x,y,ConfettiBall)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
      
	}
  wait(4);
}
