//can be a good base for Ghost-Type Weapons
//Yokin and Sani helped get the code to actually work, thank you!
#define init
global.sprite = sprite_add_weapon("sprites/sprGhostSluggerAssault.png",3,3)
global.sprEctoplasmBullet = sprite_add("sprites/sprEctoplasmSlugBullet.png",2,12,12)
global.mskEctoplasmBullet = sprite_add("sprites/mskEctoplasmSlugBullet.png",2,12,12)
global.sprEctoplasmBulletHit = sprite_add("sprites/sprEctoplasmBulletHit.png",4,8,8)
global.sprEctoplasmSlugHit = sprite_add("sprites/sprEctoplasmSlugHit.png",4,16,16)
global.sprEctoplasmSlugDisappear = sprite_add("sprites/sprEctoplasmSlugDisappear.png",4,12,12)
#define weapon_name
return "GHOST ASSAULT SLUGGER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 35;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapShotgun;

#define weapon_area
return 8;

#define weapon_text
return "@(color:16745694)ONE-TWO-THREE";

#define weapon_fire

repeat(3)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndSlugger);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = global.sprEctoplasmBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskEctoplasmBullet;
  speed = 12;
  friction = 0;
  direction = other.gunangle + (random_range(-4, 4) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SPECTRE BULLET"];
  damage = 24;
  force = 3;
  typ = 1;
  bombtimer = 16;
  friction = 0.35;

    on_wall = script_ref_create(ghostprojectile_wall);
  on_hit = script_ref_create(ghostprojectile_hit);
   on_draw = script_ref_create(ghostprojectile_draw);
   on_step = script_ref_create(ghostprojectile_step);
     on_destroy = script_ref_create(ghostprojectile_die);
       on_end_step = my_end_step_scrt;
              on_anim = event
    }
	}
  wait(3);
}


//makes the bullet make particles when it passes through walls
#define ghostprojectile_wall
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEctoplasmBulletHit;
  };
  
//makes the projectile actually do damage and have bullethit effect
#define ghostprojectile_hit
projectile_hit(other,damage,force);
instance_destroy();

//gives the projectile its glow and transparency
#define ghostprojectile_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.5);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.4*image_xscale, 1.4*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//this bombtimer is needed to make the projectiles despawn so there's not massive lag after firing too many
#define ghostprojectile_step
bombtimer -= 1;
if bombtimer < 1 instance_destroy();

//Yokin's thing to make it pass through walls
#define my_end_step_scrt
     // Pass Through Walls:
    if(
        x == xprevious &&
        y == yprevious &&
        place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)
    ){
        x += hspeed_raw;
        y += vspeed_raw;
    }
    

//makes a particle effect when the projectile dissapears    
#define ghostprojectile_die
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEctoplasmSlugHit;
  };
  
#define event
  image_speed = 0;
    image_index = image_number - 1