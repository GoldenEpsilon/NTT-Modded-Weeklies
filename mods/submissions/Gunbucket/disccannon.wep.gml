//of course there's a Disc Cannon! why wouldn't there be?

#define init
global.sprite = sprite_add_weapon("sprites/sprDiscCannon.png",3,7)
global.sprBigDisc = sprite_add("sprites/sprBigDisc.png",2,6,6)
global.mskBigDisc = sprite_add("sprites/mskBigDisc.png",2,6,6)

#define weapon_name
return "DISC CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 3;

#define weapon_auto
return true;

#define weapon_load
return 70;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapBow;

#define weapon_area
return 6;

#define weapon_text
return "@(color:16745694)DISC ROOM";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndSuperDiscGun);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprBigDisc;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskDisc;
  speed = 8;
  friction = 0;
  direction = other.gunangle + (random_range(-2, 2) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "DISC CANNON"];
  damage = 7;
  typ = 1;
  bdiscfunny = 0;
  discteamtime = 3;
    on_wall = script_ref_create(bdisc_wall);
  on_hit = script_ref_create(bdisc_hit);
  on_destroy = script_ref_create(bdisc_die);
  on_step = bdisc_step;
    }
	}
}

#define bdisc_step

discteamtime -= 1;
if discteamtime < 1 team = -4;
if bdiscfunny = 3 instance_destroy()


#define bdisc_wall
bdiscfunny += 1;
sound_play_pitchvol(sndDiscBounce,0.8,1);
	move_bounce_solid(true);

#define bdisc_hit
projectile_hit(other,damage);
instance_destroy()



#define bdisc_die
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 50)
repeat(1)
{
 with instance_create(x,y,Disc)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 7;
  }
}

#define bdisc_draw
image_angle += (speed * 2);