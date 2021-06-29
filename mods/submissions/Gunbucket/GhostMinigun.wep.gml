//can be a good base for Ghost-Type Weapons
//Yokin and Sani helped get the code to actually work, thank you!
//Cillian and Squiddy have now also given me code to make recycle gland work, thank you!
#define init
global.sprite = sprite_add_weapon("sprites/sprGhostMinigun.png",3,4)
global.sprEctoplasmBullet = sprite_add("sprites/sprEctoplasmBullet.png",2,6,8)
global.mskEctoplasmBullet = sprite_add("sprites/mskEctoplasmBullet.png",2,6,8)
global.sprEctoplasmBulletHit = sprite_add("sprites/sprEctoplasmBulletHit.png",4,8,8)
#define weapon_name
return "Ghost Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 1;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapMachinegun;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)ECTOPLASM GOES THROUGH WALLS";

#define weapon_fire

    weapon_post(6, -8, 8);
    sound_play(sndMinigun);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprEctoplasmBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskEctoplasmBullet;
  speed = 13;
  friction = 0;
  direction = other.gunangle + (random_range(-13, 13) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SPECTRE BULLET"];
  damage = 1.5;
  typ = 1;
  bombtimer = 40;
  depth = -16;

    on_wall = script_ref_create(ghostprojectile_wall);
  on_hit = script_ref_create(ghostprojectile_hit);
   on_draw = script_ref_create(ghostprojectile_draw);
   on_step = script_ref_create(ghostprojectile_step);
     on_destroy = script_ref_create(ghostprojectile_die);
       on_end_step = my_end_step_scrt;
       on_anim = event
    }
	
  wait(4);



//makes the bullet make particles when it passes through walls
#define ghostprojectile_wall
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEctoplasmBulletHit;
  };
  
//makes the projectile actually do damage and have bullethit effect
#define ghostprojectile_hit
if (!projectile_canhit(other)) exit;

projectile_hit(other, damage, force);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + weapon_cost(), typ_amax[1]);
}
projectile_hit(other,damage,force);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEctoplasmBulletHit;
  };
instance_destroy();

//gives the projectile its glow and transparency
#define ghostprojectile_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.5);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.2);
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
    sprite_index = global.sprEctoplasmBulletHit;
  };
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1