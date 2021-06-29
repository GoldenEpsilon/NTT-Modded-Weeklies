//Shell + Hammer = Shlammer
//Shell + Meat = Shmeat
//Shmeat + Fire = Roast Shmeat

#define init
global.sprite = sprite_add_weapon("sprites/sprFlameShellHammer.png",5,12)
global.sprFShellSlash = sprite_add("sprites/sprFlameSlash.png",3,0,24)
global.sprFlameShlammerHud = sprite_add_weapon("sprites/hudsprites/sprFlameShlammerHud.png",1,3.5,);

#define weapon_name
return "Flame Shlammer";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprFlameShlammerHud;

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
return 13;

#define weapon_text
return "@(color:16745694)FLAMMER TIME";

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
              sprite_index = global.sprFShellSlash;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_speed = 0.4;
      speed = 1.5 * (skill_get(13) + 1);
      image_angle = direction;
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
 with instance_create(x,y,FlameShell)
{
    direction = other.direction + (random_range(15, -15));
    speed = 16
    image_angle = direction;
    team = other.team;
    creator = other;
  }
}
//ma