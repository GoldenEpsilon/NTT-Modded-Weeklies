//JUMPING! IS USELESS!

#define init
global.sprite = sprite_add_weapon("sprites/sprQuadLaserGun.png",2,4)
global.sprQuadLaser = sprite_add("sprites/sprQuadLaser.png",4,6,6)
global.sprQuadLaserHit = sprite_add("sprites/sprQuadLaserHit.png",4,8,8)

#define weapon_name
return "QUAD LASER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 150;

#define weapon_cost
return 5;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 12;

#define weapon_text
return "@(color:16745694)NOTHING CAN STOP THE QUAD LASER!";

#define weapon_fire

    weapon_post(3, -8, 8);
    sound_play(sndPlasmaHugeUpg);

{
  if instance_exists(self)
  {

    with instance_create(x,y,CustomProjectile)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 1;
      image_angle = direction;
      team = other.team;
      creator = other;
      mask_index = mskDisc;
      damage = 6;
      image_xscale = 1 + (skill_get(17) * 0.2);
      image_yscale = image_xscale;
      image_speed = 0.6;
      sprite_index = global.sprQuadLaser;
      typ = 1;
      
      on_destroy = QuadLaserDie;
      on_draw = QuadLaserDraw;
      on_hit = QuadLaserHit;
    }
}
}

#define QuadLaserHit
projectile_hit(other,damage);

#define QuadLaserDie
   with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprQuadLaserHit;
  };
  
#define QuadLaserDraw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);