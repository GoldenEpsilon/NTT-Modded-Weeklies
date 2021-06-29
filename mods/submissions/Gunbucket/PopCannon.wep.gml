//heheeheeeeeh pop canon

#define init
global.sprite = sprite_add_weapon("sprites/sprPopCannon.png",0,3)
global.sprPFlak = sprite_add("sprites/sprPopFlak.png",2,6,6)

#define weapon_name
return "POP CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 3;

#define weapon_cost
return 4;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 12;

#define weapon_text
return "@(color:16745694)POP POP POP";

#define weapon_fire


    weapon_post(6, -8, 8);
    sound_play(sndPopgun);
  with instance_create(x + lengthdir_x(-2,gunangle),y + lengthdir_y(-2,gunangle),CustomProjectile)
{
  sprite_index = global.sprPFlak;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskFlakBullet;
  speed = 12;
  friction = 0.45;
  direction = other.gunangle + (random_range(-2, 2) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "POP FLAK BULLET"];
  damage = 5;
  typ = 1;
    on_wall = script_ref_create(pflak_wall);
  on_hit = script_ref_create(pflak_hit);
  on_destroy = script_ref_create(pflak_die);
    on_draw = script_ref_create(pflak_draw);
    on_step = script_ref_create(pflak_step);
    }


#define pflak_wall
instance_create(x,y,BulletHit)
instance_destroy();

#define pflak_hit
projectile_hit(other,damage);
instance_create(x,y,BulletHit)
instance_destroy();

#define pflak_die
sound_play(sndPopgun);
for (i = 0; i < 360; i += 90)
{
 with instance_create(x,y,Bullet2)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-65,65);
    speed = 10 + random_range(0,4);
  }
}

//Destroys Projectile when speed reaches 0
#define pflak_step
repeat(1)
{
}
if speed <= 0 instance_destroy();
    
#define pflak_draw
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 2, image_yscale * 2, image_angle, image_blend, image_alpha * 0.1);
draw_set_blend_mode(bm_normal);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);