//okay, okay I get it, you probably killed yourself by accident with this thing, its not my fault alright!? I named the damn thing "Disc Nightmare" it's your own curiosty that got you killed!

#define init
global.sprite = sprite_add_weapon("sprites/sprNightmareDiscGun.png",4,4)
global.sprNightmareDisc = sprite_add("sprites/sprNightmareDisc.png",2,6,6)
global.sprDiscTrail = sprite_add("sprites/sprNightmareDiscTrail.png",2,4,4)

#define weapon_name
return "DISC NIGHTMARE";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 3;

#define weapon_auto
return false;

#define weapon_load
return 70;

#define weapon_cost
return 24;

#define weapon_swap
return sndSwapBow;

#define weapon_area
return 20;

#define weapon_text
return "@(color:16745694)@q@q@pINFINITE FRISBEE!";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlameCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = global.sprNightmareDisc;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskDisc;
  speed = 5;
  friction = 0;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "DISC NIGHTMARE"];
  damage = 50;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(ndisc_wall);
  on_hit = script_ref_create(ndisc_hit);
  on_destroy = script_ref_create(ndisc_die);
  on_step = script_ref_create(ndisc_step);
    }
	}
}

#define ndisc_wall
instance_destroy();

#define ndisc_hit
projectile_hit(other,damage,force);
instance_destroy();

#define ndisc_die
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 3)
repeat(1)
{
 with instance_create(x,y,Disc)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 15;
  }
}

#define ndisc_step

with instance_create(x+random_range(-3,3),y+random_range(-3,3),PlasmaTrail)
{
  sprite_index = global.sprDiscTrail;
}