// good base for Jolt Bullet weapons
// jolt weapons are basically just lightning weapons but they use bullets instead
// THESE ARE NOT IDPD RELATED! THESE BULLETS ARE BLUE BUT NOT IDPD BLUE!

#define init
global.sprite = sprite_add_weapon("sprites/sprJoltRevolver.png",-1,2)
global.sprJoltBullet = sprite_add("sprites/sprJoltBullet.png",2,6,8)
global.mskBullet = sprite_add("sprites/mskBullet.png",2,6,8)
global.sprJoltBulletShell = sprite_add("sprites/sprJoltBulletShell.png",1,1,2)

#define weapon_name
return "Jolt Revolver";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return false;

#define weapon_load
return 4;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapMachinegun;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)LIKE A FORK IN A SOCKET";

#define weapon_fire

    weapon_post(4, -4, 4);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprJoltBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskBullet;
  speed = 16;
  friction = 0;
  direction = other.gunangle + (random_range(-3, 3) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "JOLT BULLET"];
  damage = 2;
  typ = 1;
              lightningcharge=1+(skill_get(17));

    on_wall = script_ref_create(joltbullet_wall);
  on_hit = script_ref_create(joltbullet_hit);
   on_draw = script_ref_create(joltbullet_draw);
   on_wall = script_ref_create(joltbullet_wall);
     on_destroy = script_ref_create(joltbullet_die);
       on_anim = event
         wait(1.5);
        sound_play_pitchvol(sndPistol,1.2,1);
    }

//shell particles
with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Shell)
{
sprite_index = global.sprJoltBulletShell
motion_add(other.aimDirection+other.right*100+random(70)-25,2+random(3))
}

//makes the bullet destroy itself when it hits a wall (important!)
#define joltbullet_wall
sound_play_pitchvol(sndHitWall,random_range(1, 1.3),1);
instance_destroy();
  
//makes the projectile actually do damage and have bullethit effect
#define joltbullet_hit
if (!projectile_canhit(other)) exit;

projectile_hit(other, damage, force, direction);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + weapon_cost(), typ_amax[1]);
}
projectile_hit(other,damage,force);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = sprLightningHit;
  };
  if (lightningcharge>0){
lightningcharge-=1;
with instance_create(x,y,Lightning)
{
  move_contact_solid(other.direction, 4);
  alarm0 = 1;
  ammo = 4;
  image_angle = other.direction + (random_range(-1, 1));
  damage= 2;
  team = other.team;
  creator = other
  with instance_create(x,y,LightningSpawn){
 image_angle = other.image_angle;
damage=other.damage;
	}
    }
}
instance_destroy();

//gives the projectile its glow and transparency
#define joltbullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

    

//makes a particle effect when the projectile dissapears    
#define joltbullet_die
         with instance_create(x,y,BulletHit)
  {
    sprite_index = sprLightningHit;
  };
  
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1