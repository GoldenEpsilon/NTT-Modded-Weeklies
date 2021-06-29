//RUN JUMP GUN

#define init
global.sprite = sprite_add_weapon("sprites/sprJumpGun.png",3,4)
global.sprJumpBullet = sprite_add("sprites/sprJumpBullet.png",2,12,12)
global.sprJumpBulletHit = sprite_add("sprites/sprJumpBulletHit.png",4,12,12)
#define weapon_name
return "Jumpgun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 3;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapMachinegun;

#define weapon_area
return 12;

#define weapon_text
return "@(color:16745694)THE SUN ROTS";

#define weapon_fire

repeat(2)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play_pitchvol(sndMinigun,1.3,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprJumpBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskHeavyBullet;
  speed = 13;
  friction = 0;
  direction = other.gunangle + (random_range(-3, 3) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "JUMP BULLET"];
  damage = 3; //actually does 6 damage, dont know whats up with that
  typ = 1;
  bombtimer = 10;

    on_wall = script_ref_create(jumpbullet_wall);
  on_hit = script_ref_create(jumpbullet_hit);
   on_draw = script_ref_create(jumpbullet_draw);
   on_step = script_ref_create(jumpbullet_step);
     on_destroy = script_ref_create(jumpbullet_die);
       on_anim = event
    }
    	wait(2);
}
}



#define jumpbullet_wall
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprJumpBulletHit;
  };
  instance_destroy();
//makes the projectile actually do damage and have bullethit effect
#define jumpbullet_hit
if (!projectile_canhit(other)) exit;

projectile_hit(other, damage, force, direction);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + weapon_cost(), typ_amax[1]);
}
projectile_hit(other,damage,force);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprJumpBulletHit;
  };
instance_destroy();

//gives the projectile its glow and transparency
#define jumpbullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);


#define jumpbullet_step
bombtimer -= 1;
if bombtimer < 1 instance_destroy();



//makes a particle effect when the projectile dissapears    
#define jumpbullet_die
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprJumpBulletHit;
  };
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1