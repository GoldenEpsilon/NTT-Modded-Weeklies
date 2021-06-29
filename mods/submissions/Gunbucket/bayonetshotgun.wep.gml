//original sprite of this gun was made by Mufina, I just slapped a bayonet on and tweaked the colors

#define init
global.sprite = sprite_add_weapon("sprites/sprBayonetShotgun.png",4,3)

#define weapon_name
return "Bayonet Shotgun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 16;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapShotgun;


#define weapon_area
return 6;

#define weapon_text
return "@(color:16745694)SHANK N' SHOOT";

#define weapon_fire

    weapon_post(-12, -8, 8);
    sound_play(sndScrewdriver);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),Shank)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      speed = 1.7 * (skill_get(13) * 3);
      image_angle = direction;
      damage = 12
      team = other.team;
      creator = other;
    }

      wait(6);
sound_play_pitchvol(sndDoubleShotgun,1.7,0.8)
weapon_post(8, -6, 9);
for(var i = -6; i <= 6; i += 1.5)
{
with instance_create(x,y,Bullet2)
{
  speed = 14 + random_range(0,6);
  direction = other.gunangle + i + (random_range(-3, 3) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  force = 3;
  typ = 1;
	}
}
