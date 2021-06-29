//first actually kinda decent weapon ive made, also pretty good, nice!

#define init
global.sprite = sprite_add_weapon("sprites/sprSuperFlameCannon.png",4,10)

#define weapon_name
return "SUPER FLAME CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 70;

#define weapon_cost
return 19;

#define weapon_swap
return sndSwapFlame;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)IT BURNS! IT BURNS!";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlameCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = sprFlameBall;
  image_xscale = 1.5;
  image_yscale = image_xscale;
  mask_index = mskHeavyBullet;
  speed = 5;
  friction = 0;
  direction = other.gunangle + (random_range(-12, 12) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SUPER FLAME BALL"];
  damage = 75;
  force = 10;
  typ = 1;
    on_wall = script_ref_create(bflameball_wall);
  on_hit = script_ref_create(bflameball_hit);
  on_destroy = script_ref_create(bflameball_die);
   on_draw = script_ref_create(bflameball_draw);
   on_step = bflameball_step;
    }
	}
}

#define bflameball_step
with instance_create(x+random_range(-10,10),y+random_range(-10,10),Flame)
   {   team = other.team;
      creator = other; }
with instance_create(x+random_range(-12,12),y+random_range(-12,12),Flame)
    {   team = other.team;
      creator = other; }
#define bflameball_wall
instance_destroy();

#define bflameball_hit
projectile_hit(other,damage,force);
instance_destroy();

#define bflameball_die
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 24)
repeat(1)
{
 with instance_create(x,y,FlameBall)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 5;
  }
}
#define bflameball_draw
image_angle += (speed * 2);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.9);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);