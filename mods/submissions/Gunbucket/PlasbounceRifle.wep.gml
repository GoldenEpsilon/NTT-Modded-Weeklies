//BOING BOING BOING BOING BOING

#define init
global.sprite = sprite_add_weapon("sprites/sprPlasbounceRifle.png",5,4)
global.mskPlasbouncer = sprite_add("sprites/mskPlasbouncer.png",0,12,12)
global.sprPlasbouncer = sprite_add("sprites/sprPlasbouncer.png",2,12,12)
global.sprPlasbounceImpact = sprite_add("sprites/sprPlasbounceImpact.png",7,16,16)
global.sprPlasbounceBulletHit = sprite_add("sprites/sprPlasbounceBulletHit.png",4,8,8)
global.sprPlasbounceTrail = sprite_add("sprites/sprPlasbounceTrail.png",3,4,4)
#define weapon_name
return "Plasbounce Rifle";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 8;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)BOING BOING BOING";

#define weapon_fire

motion_add(gunangle,-3);

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndBouncerSmg,0.7,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprPlasbouncer;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskPlasbouncer;
  speed = 16;
  friction = 0;
  direction = other.gunangle + (random_range(-8, 8) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "PLASBOUNCER"];
  damage = 4;
  typ = 1;

    on_wall = script_ref_create(plasbounce_wall);
  on_hit = script_ref_create(plasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(plasbounce_die);
     on_step = script_ref_create(plasbounce_step);
       on_anim = event
   }

	}
}



//makes the projectile bounce when it hits a wall
#define plasbounce_wall

sound_play_pitchvol(sndBouncerBounce,0.7,1);

	image_xscale -= 0.03
	image_yscale = image_xscale;
	
	move_bounce_solid(true);
    with instance_create(x, y, BulletHit)
    {
  sprite_index = global.sprPlasbounceBulletHit;
    }
  
//makes the projectile actually do damage and have bullethit effect
#define plasbounce_hit

projectile_hit(other,damage,force);

image_xscale -= 0.1;
image_yscale -= 0.1;
x -= lengthdir_x(speed * 1,direction);
y -= lengthdir_y(speed * 1,direction);
	
         with instance_create(x,y,BulletHit)
  {
   sprite_index = global.sprPlasbounceBulletHit;
  };


//gives the projectile its glow and transparency
#define plasbounce_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//makes a particle effect when the projectile dissapears    
#define plasbounce_die

sound_play_pitchvol(sndPlasmaHit,0.7,1);
         with instance_create(x,y,PlasmaImpact)
  {
   sprite_index = global.sprPlasbounceImpact;
  };
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1
    
#define plasbounce_step

with instance_create(x+random_range(-5,5),y+random_range(-5,5),PlasmaTrail)
{
  sprite_index = global.sprPlasbounceTrail;
}

if image_xscale < 0.5 instance_destroy();