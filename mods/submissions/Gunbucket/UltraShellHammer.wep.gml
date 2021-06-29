//Shell + Hammer = Shlammer
//Shell + Meat = Shmeat

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraShellHammer.png",5,12)
global.sprUltraShlammerHud = sprite_add_weapon("sprites/hudsprites/sprUltraShlammerHud.png",1,3.5,);

#define weapon_name
return "Ultra Shlammer";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprUltraShlammerHud;

#define weapon_type
return 2;

#define weapon_melee
return true;

#define weapon_auto
return false;

#define weapon_load
return 25;

#define weapon_cost
return 3;

#define weapon_rads
return 24;

#define weapon_swap
return sndSwapHammer;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)SHLAMMER TIME";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-12, -8, 8);
sound_play_pitchvol(sndUltraShovel,0.7,0.9);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(skill_get(13)*12,gunangle),y+lengthdir_y(skill_get(13)*12,gunangle),CustomSlash)
    {
              sprite_index = sprUltraSlash;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_angle = direction;
      image_speed = 0.4;
      speed = 1.5 * (skill_get(13) + 1);
      damage = 30
      team = other.team;
      creator = other;
       on_hit = script_ref_create(Shlammer_hit);
    }
}
}
        wepangle = -wepangle;
motion_add(gunangle, 3.5);

//makes the thing do that one thing
#define Shlammer_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}
sound_play(sndUltraShotgun);

repeat(1)
{
 with instance_create(x,y,UltraShell)
{
    direction = other.direction + (random_range(15, -15));
    speed = 16
    image_angle = direction;
    team = other.team;
    creator = other;
  }
}
//ma