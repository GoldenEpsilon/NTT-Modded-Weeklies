//this thing's single target damage is way too high, but I also really wanted a Super Blood Cannon so it's staying
//ok I nerfed it, I don't know if its shit now but it shouldn't one-shot throne anymore
#define init
global.sprite = sprite_add_weapon("sprites/sprSuperBloodCannon.png",12,14)
global.sprSuperBloodCannonHud = sprite_add_weapon("sprites/hudsprites/sprSuperBloodCannonHud.png",1,3.5,);

#define weapon_name
return "SUPER BLOOD CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprSuperBloodCannonHud;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 80;

#define weapon_cost
return 0; // look down below for ammo cost

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)FLESH AND BONE";

#define weapon_fire

if(ammo[weapon_get_type(argument0)] < 16)
{
  sound_play(sndBloodHurt);
  projectile_hit(self, 2, 0, 0);
  lasthit = [weapon_get_sprite(argument0), weapon_get_name(argument0)];
  ammo[4] += 18;
}
if(infammo = 0) ammo[weapon_get_type(argument0)] -= 18;

    weapon_post(6, -8, 8);
    sound_play(sndBloodCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = sprBloodBall;
  image_xscale = 1.5;
  image_yscale = image_xscale;
  mask_index = mskHeavyBullet;
  speed = 5;
  friction = 0;
  direction = other.gunangle
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SUPER BLOOD BALL"];
  damage = 60;
  force = 10;
  typ = 1;
    on_wall = script_ref_create(bbloodball_wall);
  on_hit = script_ref_create(bbloodball_hit);
  on_destroy = script_ref_create(bbloodball_die);
   on_draw = script_ref_create(bbloodball_draw);
   on_step = bbloodball_step;
   old_active_frame = current_frame;
    }

	//blood explosion trail
#define bbloodball_step
if current_frame > old_active_frame + 5{
    old_active_frame = current_frame;

   instance_create(x + random_range(-3,3),y + random_range(-3,3),MeatExplosion)

}
#define bbloodball_wall
instance_create(x,y,PortalClear)
instance_destroy();

#define bbloodball_hit
projectile_hit(other,damage,force);
instance_destroy();

#define bbloodball_die
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,BloodBall)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 5;
  }
}
for (i = 0; i < 360; i += 48)
repeat(1)
{
 with instance_create(x,y,BloodGrenade)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 5;
  }
}
#define bbloodball_draw
image_angle += (speed * 2);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_normal);