//spears are meant to be longer-range higher dps melees, but with much lower protection against projectiles and such
//good base for spear-type melee weps

#define init
global.sprite = sprite_add_weapon("sprites/sprFireSpear.png",11,2)
global.sprFlameShank = sprite_add("sprites/sprFlameShank.png",2,-5,8)
global.sprFlameSpearHud = sprite_add_weapon("sprites/hudsprites/sprFlameSpearHud.png",1,3.5,);

#define weapon_name
return "VOLCANIC SPEAR";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprFlameSpearHud;

#define weapon_type
return 0;

#define weapon_melee
return false;

#define weapon_auto
return false;

#define weapon_load
return 50;

#define weapon_cost
return 0;


#define weapon_swap
return sndSwapSword;

#define weapon_area
return 10;

#define weapon_text
return "@(color:16745694)SHISH KABOB";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-12, -8, 8);
    sound_play(sndScrewdriver);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),CustomSlash)
    {
              sprite_index = global.sprFlameShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 8);
      image_angle = direction;
      damage = 20
      candeflect=false;
      team = other.team;
      creator = other;
       on_hit = script_ref_create(fspearhit);
               on_step = fspearstep;
       
    }
}
}
    
    
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
    sound_play(sndScrewdriver);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),CustomSlash)
    {
              sprite_index = global.sprFlameShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 8);
      image_angle = direction;
      damage = 20
      candeflect=false;
      team = other.team;
      creator = other;
       on_hit = script_ref_create(fspearhit);
               on_step = fspearstep;
    }
  }
      wait(4.5);
        if instance_exists(self)
  {
          weapon_post(-12, -8, 8);
    sound_play(sndScrewdriver);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),CustomSlash)
    {
              sprite_index = global.sprFlameShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            image_speed = 0.4;
            speed = 1.7 * (skill_get(13) * 8);
      image_angle = direction;
      damage = 20
      candeflect=false;
      team = other.team;
      creator = other;
        on_hit = script_ref_create(fspearhit);
        on_step = fspearstep;
    }
  }


#define fspearhit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}

#define fspearstep
repeat(3)
{
  with instance_create(x+lengthdir_x(0,random_range(20, -20)),y+lengthdir_y(0,random_range(20, -20)),Flame)
{
      team = other.team;
      creator = other;
     speed = 4 + (skill_get(13) + 2);
     image_angle = other.image_angle;
     direction = other.direction;
}
}