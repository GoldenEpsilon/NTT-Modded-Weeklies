//the true digging tool

#define init
global.sprite = sprite_add_weapon("sprites/sprHandheldDrill.png",5,10)
global.sprDrillSlash = sprite_add("sprites/sprDrillShank.png",2,-5,9)
global.mskDrillSlash = sprite_add("sprites/mskDrillShank.png",0,-5,9)
global.sprShlammerHud = sprite_add_weapon("sprites/hudsprites/sprHandheldDrillHud.png",1,3.5,);

#define weapon_name
return "HANDHELD DRILL";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprShlammerHud;

#define weapon_type
return 4;

#define weapon_melee
return false;

#define weapon_auto
return true;

#define weapon_load
return 2;

#define weapon_cost
return 1;


#define weapon_swap
return sndSwapMotorized;

#define weapon_area
return 15;

#define weapon_text
return "@(color:16745694)TUNNELING";

#define weapon_fire

motion_add(gunangle, 2);
repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-6, -8, 8);
sound_play_pitchvol(sndHammer,0.7,2);
  with instance_create(x+lengthdir_x(skill_get(13)*7,gunangle),y+lengthdir_y(skill_get(13)*7,gunangle),CustomSlash)
    {
              sprite_index = global.sprDrillSlash;
              mask_index = global.mskDrillSlash;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_angle = direction;
      image_xscale = 1.5;
      image_yscale = image_xscale;
      image_speed = 0.4;
      speed = 1.5 * (skill_get(13) + 2);
      damage = 4 //actually does 20 I dont know why its like this
      team = other.team;
      creator = other;
      candeflect=false;
       on_hit = script_ref_create(drill_hit);
       on_wall = script_ref_create(drill_wall);
    }
}
}


//makes the thing do that one thing
#define drill_hit
projectile_hit(other,damage);


#define drill_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}
