//basically Lil hunter's rifle but unmodified / unirradiated because radiation is gross!
//I had to recode bullets just to get recycle gland working with IDPD Bullets so this is a good bullet Base I guess

#define init
global.sprite = sprite_add_weapon("sprites/sprPopoRifle.png",7,5)

#define weapon_name
return "SCOUT RIFLE";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 17;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapPistol;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)THE HUNTER BECOMES THE HUNTED";

#define weapon_fire

//IMPORTANT IF COPYING THESE FOR IDPD BULLET BASE: THE NORMAL DAMAGE PER BULLET IS 4, THESE DO 6
   weapon_post(6, -8, 8);
   sound_play(sndLilHunterSniper);
   motion_add(gunangle,-2);

repeat(8)
{
  if instance_exists(self)
  {
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = sprIDPDBullet;
      mask_index = mskBullet1;
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      speed = 15 + random_range(0, 2);
      damage = 6;
      image_angle = direction;
      team = other.team;
      creator = other;
            on_hit = script_ref_create(popobullet_hit);
      on_draw = script_ref_create(popobullet_draw);
      on_destroy = script_ref_create(popobullet_die);
      on_wall = script_ref_create(popobullet_wall);
      on_anim = muzzleflashevent;
      typ = 1;
    }
    }
    wait(0.25);
	}



#define popobullet_wall

sound_play_pitchvol(sndHitWall,1,1);
         with instance_create(x,y,BulletHit)
  {
   sprite_index = sprIDPDBulletHit;
  };
    instance_create(x, y, Dust)
instance_destroy();
    
#define popobullet_hit

if (!projectile_canhit(other)) exit;

projectile_hit(other, damage, force, direction);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + 1, typ_amax[1]);
}

instance_destroy();

#define popobullet_die

         with instance_create(x,y,BulletHit)
  {
   sprite_index = sprIDPDBulletHit;
  };

//gives the projectile its glow and transparency
#define popobullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.9);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

//Yokin's thing to make muzzleflash work
#define muzzleflashevent
  image_speed = 0;
    image_index = image_number - 1