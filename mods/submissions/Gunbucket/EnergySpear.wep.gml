//spears are meant to be longer-range higher dps melees, but with much lower protection against projectiles and such
//good base for spear-type melee weps

#define init
global.sprite = sprite_add_weapon("sprites/sprEnergySpear.png",11,2)
global.sprEnergySpearHud = sprite_add_weapon("sprites/hudsprites/sprEnergySpearHud.png",1,3.5,);
#define weapon_name
return "ENERGY SPEAR";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprEnergySpearHud;

#define weapon_type
return 5;

#define weapon_melee
return false;

#define weapon_auto
return false;

#define weapon_load
return 25;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 10;

#define weapon_text
return "@(color:16745694)WHAT'S OLD IS NEW";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-12, -8, 8);
    sound_play(sndEnergySword);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),EnergyShank)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 17
      team = other.team;
      creator = other;
    }
}
}
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
    sound_play(sndEnergySword);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),EnergyShank)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 17
      team = other.team;
      creator = other;
    }
  }
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
    sound_play(sndEnergySword);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),EnergyShank)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 17
      team = other.team;
      creator = other;
    }
  }
