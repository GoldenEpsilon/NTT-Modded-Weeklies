//these drill projectiles were Lamp's idea, thank you Lamp!
//this is the small one that should be decent preloop but might fall off in loop

#define init
global.sprite = sprite_add_weapon("sprites/sprHyperDrillGun.png",7,5)
global.sprSmallDrill = sprite_add("sprites/sprHyperDrillAnim.png",3,-3,7)
global.mskSmallDrill = sprite_add("sprites/mskSmallDrill.png",0,-3,7)
global.sprhyperdrillblink = sprite_add("sprites/sprHyperDrillAnimBlink.png",3,-3,7)

#define weapon_name
return "HYPER DRILL GUN";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 20;

#define weapon_cost
return 4;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)SPEED DIG";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlameCannon);
  with instance_create(x + lengthdir_x(4,gunangle),y + lengthdir_y(4,gunangle),CustomProjectile)
{
  sprite_index = global.sprSmallDrill;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskSmallDrill;
  speed = 8;
  friction = -.48;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SMALL DRILL"];
  damage = 20;
  force = 50;
  typ = 1;
  bombtimer = 25;
    on_wall = script_ref_create(drill_wall);
  on_hit = script_ref_create(drill_hit);
  on_destroy = script_ref_create(drill_die);
   	on_step = script_ref_create(drillstep);
    }
	}
  wait(4);
}

#define drill_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}

#define drill_hit
projectile_hit(other,damage,force);

#define drillstep
{
  instance_create(x+random_range(-1,1),y+random_range(-1,1),Smoke);
}
bombtimer -= 1;
if bombtimer < 11 sprite_index = global.sprhyperdrillblink;
if bombtimer < 1 || place_meeting(x,y,Explosion) || place_meeting(x,y,PopoExplosion) instance_destroy();

#define drill_die
sound_play(sndExplosionS);
for (i = 0; i < 80; i += 24)
repeat(1)
{
 instance_create(x,y,SmallExplosion)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 20;
  }
}
