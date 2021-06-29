//basically Lil hunter's bouncer but unmodified / unirradiated because radiation is gross!
//I had to recode Bouncers just so i could change what the BulletHit effect looks like, so if you want custom bouncers this works well as a Base

#define init
global.sprite = sprite_add_weapon("sprites/sprPopoBouncerShotgun.png",5,5)
global.sprPopoBouncer = sprite_add("sprites/sprPopoBouncerBullet.png",2,8,8)

#define weapon_name
return "SCOUT BOUNCER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 17;

#define weapon_cost
return 9;

#define weapon_swap
return sndSwapPistol;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)THE HUNTER BECOMES THE HUNTED";

#define weapon_fire

   weapon_post(6, -8, 8);
   sound_play(sndLilHunterBouncer);
   motion_add(gunangle,-3);

repeat(11)
{
  if instance_exists(self)
  {
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprPopoBouncer;
      mask_index = mskBouncerBullet;
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 5 + random_range(0, 4);
      damage = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
      on_hit = script_ref_create(popobouncer_hit);
      on_draw = script_ref_create(popobouncer_draw);
      on_destroy = script_ref_create(popobouncer_die);
      on_wall = script_ref_create(popobouncer_wall);
      on_step = script_ref_create(popobouncer_step);
      on_anim = event;
      bouncecount = 1;
      typ = 1;
    }
    }
	}

#define popobouncer_step
if bouncecount > 2  instance_destroy();

#define popobouncer_wall

sound_play_pitchvol(sndBouncerBounce,1,1);
	move_bounce_solid(true);
    instance_create(x, y, Dust)

    bouncecount +=1;
    
#define popobouncer_hit

if (!projectile_canhit(other)) exit;

projectile_hit(other, damage, force, direction);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + 1, typ_amax[1]);
}

instance_destroy();

#define popobouncer_die

         with instance_create(x,y,BulletHit)
  {
   sprite_index = sprIDPDBulletHit;
  };

//gives the projectile its glow and transparency
#define popobouncer_draw
image_angle += 1 + random_range(0, 4);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1