//kinda cool but kinda lame, its flameflaks! SUPER MODE

#define init
global.sprite = sprite_add_weapon("sprites/sprFlameFlakerSuper.png",3,3)
global.sprFFlak = sprite_add("sprites/sprFlameFlakBullet.png",2,6,6)
global.sprFFHit = sprite_add("sprites/sprFlameFlakHit.png",8,16,16)
global.sprFFlakS = sprite_add("sprites/sprFlameFlakBulletSuper.png",2,12,12)
global.sprFFHitS = sprite_add("sprites/sprFlameFlakHitSuper.png",9,24,24)

#define weapon_name
return "SUPER FLAME FLAKER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 70;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)BURNING BLASTS";

#define weapon_fire


    weapon_post(6, -8, 8);
    sound_play(sndSuperFlakCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = global.sprFFlakS;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskSuperFlakBullet;
  speed = 12;
  friction = 0.55;
  direction = other.gunangle + (random_range(-2, 2) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SUPER FLAME FLAK BULLET"];
  damage = 60;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(superfflak_wall);
  on_hit = script_ref_create(superfflak_hit);
  on_destroy = script_ref_create(superfflak_die);
    on_draw = script_ref_create(fflak_draw);
    on_step = script_ref_create(superfflak_step);
    }
    

#define superfflak_die
sound_play(sndFlakExplode);

         with instance_create(x,y,BulletHit) //creates a bullet hit
  {
    sprite_index = global.sprFFHitS;
  }
  
for (i = 0; i < 360; i += 72)
{
  with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprFFlak;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskFlakBullet;
  speed = 12;
  friction = 0.45;
  direction = other.direction + other.i + random_range(-15,15);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "FLAME FLAK BULLET"];
  damage = 16;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(fflak_wall);
  on_hit = script_ref_create(fflak_hit);
  on_destroy = script_ref_create(fflak_die);
    on_draw = script_ref_create(fflak_draw);
    on_step = script_ref_create(fflak_step);
    }
}

#define superfflak_wall
with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprFFHitS;
  }
instance_destroy();

#define superfflak_hit
projectile_hit(other,damage);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprFFHitS;
  }
instance_destroy();

#define superfflak_step
repeat(3)
{
  instance_create(x+random_range(-5,5),y+random_range(-5,5),Smoke);
}
if speed <= 0 instance_destroy();




//small flame flak stuff
#define fflak_wall
with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprFFHit;
  }
instance_destroy();

#define fflak_hit
projectile_hit(other,damage,force);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprFFHit;
  }
instance_destroy();

#define fflak_die
sound_play(sndFlakExplode);

         with instance_create(x,y,BulletHit) //creates a bullet hit
  {
    sprite_index = global.sprFFHit;
  }
  
for (i = 0; i < 360; i += 14)
{
 with instance_create(x,y,FlameShell) //makes the flak do the flak thing
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-65,65);
    speed = 10 + random_range(0,4);
  }
}

//Smoke Trail + Destroys Projectile when speed reaches 0
#define fflak_step
repeat(1)
{
  instance_create(x+random_range(-4,4),y+random_range(-4,4),Smoke);
}
if speed <= 0 instance_destroy();
    
#define fflak_draw
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 2, image_yscale * 2, image_angle, image_blend, image_alpha * 0.1);
draw_set_blend_mode(bm_normal);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);