//spears are meant to be longer-range higher dps melees, but with much lower protection against projectiles and such
//good base for spear-type melee weps

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraSpear.png",11,2)
global.sprUltraShank = sprite_add("sprites/sprUltraShank.png",2,-5,8)
global.sprUltraSpearHud = sprite_add_weapon("sprites/hudsprites/sprUltraSpearHud.png",1,3.5,);

#define weapon_name
return "ULTRA SPEAR";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprUltraSpearHud;

#define weapon_type
return 0;

#define weapon_melee
return false;

#define weapon_auto
return false;

#define weapon_load
return 20;

#define weapon_cost
return 0;

#define weapon_rads
return 19

#define weapon_swap
return sndSwapSword;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)ANCIENT WEAPONRY";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-12, -8, 8);
sound_play_pitchvol(sndUltraShovel,1.5,1);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),Shank)
    {
              sprite_index = global.sprUltraShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 32
      team = other.team;
      creator = other;
    }
}
}
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
sound_play_pitchvol(sndUltraShovel,1.5,1);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),Shank)
    {
              sprite_index = global.sprUltraShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 32
      team = other.team;
      creator = other;
    }
  }
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
sound_play_pitchvol(sndUltraShovel,1.5,1);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),Shank)
    {
              sprite_index = global.sprUltraShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            image_speed = 0.4;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 32
      team = other.team;
      creator = other;
    }
  }
