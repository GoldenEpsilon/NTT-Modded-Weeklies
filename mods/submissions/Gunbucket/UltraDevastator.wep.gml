//I had to recode the devastator basically so if you want to make a weapon thats basically the devasator with different sprites and/or projectiles this can work as a base

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraDevastator.png",1,6)
global.sprUltraPlasmaImpact = sprite_add("sprites/sprUltraPlasmaImpact.png",7,16,16)
global.mskUDevProjectile = sprite_add("sprites/mskUDevProjectile.png",1,16,16)

#define weapon_name
return "ULTRA DEVASTATOR";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 80;

#define weapon_cost
return 14;

#define weapon_rads
return 80;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)ULTIMATE DEVASTATION";

#define weapon_fire

repeat(3)
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
      direction = other.gunangle + (random_range(8, -8) * other.accuracy);
      damage = 1;
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
      sprite_index = global.sprUltraPlasmaImpact;
      mask_index = global.mskUDevProjectile;
      
          on_wall = script_ref_create(udev_wall);
          on_destroy = script_ref_create(udev_die);
            on_hit = script_ref_create(udev_hit);
            on_draw = script_ref_create(udev_draw);
            on_step = script_ref_create(udev_step);
    }

	}
}


#define udev_wall
sound_play_pitchvol(sndDevastatorExplo,0.7,1);
with(other){
with instance_create(x,y,PortalClear){
	  image_xscale = 1.5;
  image_yscale = image_xscale;
}
}
instance_destroy();

//makes explosion when it hits wall
#define udev_die
         with instance_create(x,y,PlasmaImpact)
  {
  	  sprite_index = global.sprUltraPlasmaImpact;
          team = other.team;
      creator = other;
  };
  
//makes the main projectile not destroy itself on enemies
#define udev_hit
projectile_hit(other,damage,force); 

//actually makes the devastator do the devastaty thing
#define udev_step
with instance_create(x+random_range(-30,30),y+random_range(-30,30),PlasmaImpact)
{
  sprite_index = global.sprUltraPlasmaImpact;
  damage = 15;
}
  
//gives the projectile its glow and transparency
#define udev_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.6*image_xscale, 1.6*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);