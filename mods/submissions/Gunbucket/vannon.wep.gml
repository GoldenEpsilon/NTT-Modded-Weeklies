//apparently this was done by like 500 other mods already but whatever
//can be useful as both a Drill Weapon base and for giving trails particles

#define init
global.sprite = sprite_add_weapon("sprites/sprVannon.png",17,15)

#define weapon_name
return "VANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 50;

#define weapon_cost
return 10;

#define weapon_swap
return sndSwapMotorized;

#define weapon_area
return 17;

#define weapon_text
return "@(color:16745694)WOOP WOOP";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndVanWarning);
  with instance_create(x + lengthdir_x(45,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = sprVanDrive;
  image_xscale = 1;
    image_yscale = other.right
  mask_index = mskVan;
  speed = 9;
  friction = 0;
  direction = other.gunangle + (random_range(1, 1) * other.accuracy);
  image_angle = direction;
  image_speed = 0.4;
  depth = -2
  team = other.team;
  creator = other;
  hitid = [sprite_index, "VAN LAUNCHED"];
  damage = 10;
  force = 50;
  bombtimer = 30;
    on_wall = script_ref_create(vandrill_wall);
  on_hit = script_ref_create(vandrill_hit);
  on_destroy = script_ref_create(vandrill_die);
   	on_step = script_ref_create(vanstep);
    }
	}
}

#define vandrill_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}

#define vandrill_hit
projectile_hit(other,damage,force);

#define vanstep
with instance_create(x+random_range(-20,20),y+random_range(-20,20),BlueFlame)
{
  sprite_index = sprBlueFlameBig;
}
bombtimer -= 1;
if bombtimer < 1 || place_meeting(x,y,Explosion) || place_meeting(x,y,PopoExplosion) instance_destroy();

#define vandrill_die
sound_play(sndExplosionCar);
for (i = 0; i < 1; i += 1)
repeat(3)
{
 with instance_create(x + random_range(-10,10),y + random_range(-10,10),PopoExplosion)
  {
    direction = other.direction + other.i + random_range(-10,10);
    speed = 1;
  }
}
