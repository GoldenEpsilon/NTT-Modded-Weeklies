//Shell + Hammer = Shlammer
//Shell + Meat = Shmeat

#define init
global.sprite = sprite_add_weapon("sprites/sprShellHammer.png",5,12)
global.sprShellSlash = sprite_add("sprites/sprShellSlash.png",3,0,24)
global.sprShlammerHud = sprite_add_weapon("sprites/hudsprites/sprShlammerHud.png",1,3.5,);

#define weapon_name
return "Shlammer";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprShlammerHud;

#define weapon_type
return 2;

#define weapon_melee
return true;

#define weapon_auto
return false;

#define weapon_load
return 40;

#define weapon_cost
return 3;


#define weapon_swap
return sndSwapHammer;

#define weapon_area
return 11;

#define weapon_text
return "@(color:16745694)COME ON AND SHLAM";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-12, -8, 8);
sound_play_pitchvol(sndHammer,0.7,1);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(skill_get(13)*12,gunangle),y+lengthdir_y(skill_get(13)*12,gunangle),CustomSlash)
    {
              sprite_index = global.sprShellSlash;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_angle = direction;
      image_speed = 0.4;
      speed = 1.5 * (skill_get(13) + 1);
      damage = 10
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
sound_play(sndDoubleShotgun);

repeat(1)
{
 with instance_create(x,y,Bullet2)
{
    direction = other.direction + (random_range(15, -15));
    speed = 16
    image_angle = direction;
    team = other.team;
    creator = other;
  }
}
//ma