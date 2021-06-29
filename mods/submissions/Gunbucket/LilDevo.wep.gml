//I had to recode the devastator basically so if you want to make a weapon thats basically the devasator with different sprites and/or projectiles this can work as a base

#define init
global.sprite = sprite_add_weapon("sprites/sprLilDevo.png",-1,3)
global.mskUDevProjectile = sprite_add("sprites/mskUDevProjectile.png",1,16,16)
global.sprSmallPlasmaImpact = sprite_add("sprites/sprSmallPlasmaImpact.png",7,8,8)

#define weapon_name
return "LIL DEVO";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 20;

#define weapon_cost
return 4;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 8;

#define weapon_text
return "@(color:16745694)JUST A LITTLE DEVASTATION";

#define weapon_fire

repeat(1)
{
    motion_add(gunangle,-5);
if skill_get(17){
  sound_play_pitchvol(sndDevastatorUpg,0.7,1);
}else{
  sound_play_pitchvol(sndDevastator,0.7,1);
}
  if instance_exists(self)
  {
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),CustomProjectile)
    {
      direction = other.gunangle + (random_range(3, -3) * other.accuracy);
      damage = 1;
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
      sprite_index = global.sprSmallPlasmaImpact;
      mask_index = global.mskUDevProjectile;
      
          on_wall = script_ref_create(ldev_wall);
          on_destroy = script_ref_create(ldev_die);
            on_hit = script_ref_create(ldev_hit);
            on_draw = script_ref_create(ldev_draw);
            on_step = script_ref_create(ldev_step);
    }

	}
}


#define ldev_wall
sound_play_pitchvol(sndDevastatorExplo,0.7,1);
with(other){
with instance_create(x,y,PortalClear)
{
	  image_xscale = 0.6;
  image_yscale = image_xscale;
}
}
instance_destroy();

//makes explosion when it hits wall
#define ldev_die
         with instance_create(x,y,PlasmaImpact)
  {
          team = other.team;
      creator = other;
  }
  
//makes the main projectile not destroy itself on enemies
#define ldev_hit
projectile_hit(other,damage,force); 

//actually makes the devastator do the devastaty thing
#define ldev_step
repeat(1)
  if instance_exists(self)

with instance_create(x+random_range(-5,5),y+random_range(-5,5),PlasmaImpact)
  {
      sprite_index = global.sprSmallPlasmaImpact;
      damage = 5;
  }
//gives the projectile its glow and transparency
#define ldev_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.6*image_xscale, 1.6*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);