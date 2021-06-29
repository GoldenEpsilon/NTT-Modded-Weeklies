//BOING BOING BOING
//totally not a Shellshock Live weapon

#define init
global.sprite = sprite_add_weapon("sprites/sprBouncesploder.png",7,7)
global.mskBall = sprite_add("sprites/mskLargeCrystalBullet.png",0,12,12)
global.sprBouncesploderBall = sprite_add("sprites/sprBouncesploderBall.png",2,12,12)
global.sprPurpleExplosion = sprite_add("sprites/sprPurpleExplosion.png",9,24,24)
global.sprPurpleFire = sprite_add("sprites/sprPurpleFlame.png",8,4,6)
global.sprPurpleFireBig = sprite_add("sprites/sprPurpleFlameBig.png",8,6,8)
#define weapon_name
return "Bouncesploder";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 40;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)RIGHT BACK AT YOU";

#define weapon_fire

motion_add(gunangle,-3);

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndBouncerSmg,0.7,1);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),CustomProjectile)
{
  sprite_index = global.sprBouncesploderBall;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskBall;
  speed = 16;
  friction = 0;
  direction = other.gunangle + (random_range(-10, 10) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "BOUNCESPLODER"];
  damage = 10;
  typ = 1;
  bombtimer = 75;

    on_wall = script_ref_create(bouncesplode_wall);
  on_hit = script_ref_create(bouncesplode_hit);
   on_draw = script_ref_create(bouncesplode_draw);
     on_destroy = script_ref_create(bouncesplode_die);
     on_step = script_ref_create(bsplode_step);
       on_anim = event
   }

	}
}



//makes the projectile die when it hits a wall
#define bouncesplode_wall

sound_play_pitchvol(sndBouncerBounce,0.3,2);
	move_bounce_solid(true);
    with instance_create(x, y, Explosion)
    {
  sprite_index = global.sprPurpleExplosion;
    }
  
//makes the projectile actually do damage and have bullethit effect
#define bouncesplode_hit

projectile_hit(other,damage);
         with instance_create(x,y,Explosion)
  {
   sprite_index = global.sprPurpleExplosion;
  };


//gives the projectile its glow and transparency
#define bouncesplode_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//makes a particle effect when the projectile dissapears    
#define bouncesplode_die

sound_play_pitchvol(sndExplosion,0.7,1);
         with instance_create(x,y,Explosion)
  {
   sprite_index = global.sprPurpleExplosion;
  };
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1
    
#define bsplode_step

with instance_create(x+random_range(-7,7),y+random_range(-7,7),PlasmaTrail)
{
  sprite_index = global.sprPurpleFire;
}
with instance_create(x+random_range(-7,7),y+random_range(-7,7),PlasmaTrail)
{
  sprite_index = global.sprPurpleFireBig;
}

bombtimer -= 1;
if bombtimer < 1 instance_destroy();