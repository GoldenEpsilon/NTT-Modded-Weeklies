//spears are meant to be longer-range higher dps melees, but with much lower protection against projectiles and such
//good base for spear-type melee weps

#define init
global.sprite = sprite_add_weapon("sprites/sprLightningSpear.png",11,1)
global.sprLightningShank = sprite_add("sprites/sprLightningShank.png",2,-5,8)
global.sprLightningSpearHud = sprite_add_weapon("sprites/hudsprites/sprLightningSpearHud.png",1,3.5,);

#define weapon_name
return "LIGHTNING SPEAR";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprLightningSpearHud;

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
return 12;

#define weapon_text
return "@(color:16745694)ZAP ZAP ZAP";

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
              sprite_index = global.sprLightningShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 8);
      image_angle = direction;
      damage = 20
      candeflect=false;
      team = other.team;
      creator = other;
            lightningcharge=1+(skill_get(17));
       on_hit = script_ref_create(lspearhit);
       
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
              sprite_index = global.sprLightningShank;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1.5;
      image_yscale = image_xscale;
            speed = 1.7 * (skill_get(13) * 8);
      image_angle = direction;
      damage = 20
      candeflect=false;
      team = other.team;
      creator = other;
            lightningcharge=1+(skill_get(17));
       on_hit = script_ref_create(lspearhit);
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
              sprite_index = global.sprLightningShank;
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
            lightningcharge=1+(skill_get(17));
        on_hit = script_ref_create(lspearhit);
    }
  }

#define lspearhit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}
if (lightningcharge>0){
lightningcharge-=1;
with instance_create(x,y,Lightning)
{
  move_contact_solid(other.direction, 40);
  alarm0 = 1;
  ammo = 4;
  image_angle = other.direction + (random_range(-10, 10));
  damage= 7;
  team = other.team;
  creator = other
  with instance_create(x,y,LightningSpawn){
 image_angle = other.image_angle;
damage=other.damage;
	}
    }
}

