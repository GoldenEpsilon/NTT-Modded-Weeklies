//scp funee

#define init
global.sprite = sprite_add_weapon("sprites/sprMicroHID.png",5,6)
global.sprMicroLightning = sprite_add("sprites/sprMicroLightning.png",3,12,12)

#define weapon_name
return "TESLA BLASTER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 3;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)MICROWAVE MEAL";

#define weapon_fire

repeat(10)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndLightningPistol);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),CustomProjectile)
    {
      direction = other.gunangle + (random_range(5, -5) * other.accuracy);
      speed = 10 + random_range(0,3);
      image_angle = random_range(0,3);
      image_speed = 0.3;
      image_xscale = 1 + (skill_get(17) * 0.2);
      image_yscale = image_xscale;
      damage = 1;
      team = other.team;
      creator = other;
      sprite_index = global.sprMicroLightning
      mask_index = mskFlakBullet;
      teslatimer = 10;
      
      on_draw = TeslaDraw;
      on_step = TeslaStep;
      on_hit = TeslaHit;
      on_destroy = TeslaDie;
    }
}
wait(0.1);
}

#define TeslaHit
projectile_hit(other,damage,force);
with instance_create(x,y,Lightning) {
	      team = other.team;
      creator = other;
}

#define TeslaDie
         with instance_create(x,y,BulletHit)
  {
    sprite_index = sprLightningHit;
  };
  

#define TeslaStep
teslatimer -= 1;
if teslatimer < 1 instance_destroy()

#define TeslaDraw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);
