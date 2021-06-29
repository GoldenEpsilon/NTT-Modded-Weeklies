//these drill projectiles were Lamp's idea, thank you Lamp!
//so I made a drill projectile right? the obvious next step is make it really really big!

#define init
global.sprite = sprite_add_weapon("sprites/sprGigaDrillCannon.png",5,8)
global.sprGigaDrill = sprite_add("sprites/sprGigaDrillAnim.png",10,-10,20)
global.mskGigaDrill = sprite_add("sprites/mskGigaDrill.png",0,-10,20)
global.sprgigadrillblink = sprite_add("sprites/sprGigaDrillAnimBlink.png",10,-10,20)

#define weapon_name
return "GIGA DRILL CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 130;

#define weapon_cost
return 16;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 16;

#define weapon_text
return "@(color:16745694)CRACK THE EARTH";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlameCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = global.sprGigaDrill;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskGigaDrill;
  speed = 0.5;
  friction = -.095;
  direction = other.gunangle + (random_range(0, 0) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "GIGA DRILL"];
  damage = 15;
  force = 50;
  bombtimer = 90;
    on_wall = script_ref_create(gdrill_wall);
  on_hit = script_ref_create(gdrill_hit);
  on_destroy = script_ref_create(gdrill_die);
   	on_step = script_ref_create(gdrillstep);
    }
	}
  wait(4);
}

#define gdrill_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}

#define gdrill_hit
projectile_hit(other,damage,force);

#define gdrillstep
{
  instance_create(x+random_range(-15,15),y+random_range(-15,15),Smoke);
}
{
  instance_create(x+random_range(-15,15),y+random_range(-15,15),Smoke);
}
{
  instance_create(x+random_range(-15,15),y+random_range(-15,15),Smoke);
}
bombtimer -= 1;
if bombtimer < 11 sprite_index = global.sprgigadrillblink;
if bombtimer < 1 instance_destroy();

#define gdrill_die
sound_play(sndExplosionXL);
for (i = 0; i < 360; i += 24)
repeat(1)
{
 instance_create(x,y,Explosion)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 20;
  }
}
