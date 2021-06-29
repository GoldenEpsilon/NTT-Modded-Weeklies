//shhh its a terraria weapon (big secret!)

#define init
global.sprite = sprite_add_weapon("sprites/sprCrystalStormCursed.png",6,7)
global.sprCrystalShard = sprite_add("sprites/sprCrystalShardCursed.png",2,6,8)
global.sprCrystalShardHit = sprite_add("sprites/sprCrystalShardHitCursed.png",4,8,8)

#define weapon_name
return "CURSED CRYSTAL STORM";

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
return sndSwapBow;

#define weapon_area
     // Cursed Chest Exclusive:
    if(("curse" in self && curse > 0) || ("curse" in other && other.curse > 0)){
        return 11; 
    }
    
    return -1;

#define weapon_text
return "@(color:16745694)HELP";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndMinigun);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),CustomProjectile)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 13;
      image_angle = direction;
      team = other.team;
      creator = other;
      sprite_index = global.sprCrystalShard;
      mask_index = mskBouncerBullet;
      damage = 3;
      
      on_hit = script_ref_create(crystalshard_hit);      
      on_wall = script_ref_create(crystalshard_wall);      
      on_step = script_ref_create(crystalshard_step);
      on_destroy = script_ref_create(crystalshard_die);
      on_draw = script_ref_create(crystalshard_draw);
      on_anim = muzzleflashevent;
      
      shardbouncecount = 0;
      typ = 1;
    }
}
}

#define crystalshard_hit
projectile_hit(other,damage,force);
  instance_destroy();

#define crystalshard_wall

	move_bounce_solid(true);
    instance_create(x, y, Dust)

    shardbouncecount +=1;

#define crystalshard_die

    sound_play(sndCrystalPropBreak);
         with instance_create(x,y,BulletHit)
  {
   sprite_index = global.sprCrystalShardHit;
  };

#define crystalshard_step
      image_angle = direction;
      with instance_create(x+random_range(-5,5),y+random_range(-5,5),PlasmaTrail)
{
  sprite_index = sprCurse;
  image_xscale = 0.5;
  image_yscale = image_xscale;
}

if shardbouncecount > 3  instance_destroy();

//gives the projectile its glow and transparency
#define crystalshard_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define muzzleflashevent
  image_speed = 0;
    image_index = image_number - 1