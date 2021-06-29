//evolver weapons power up based on what stage you're on, potentially could get laggy deeploop but maybe not!
//Yokin showed me how to give weapons custom colored sprites on the hud, thank you!
#define init
global.sprite = sprite_add_weapon("sprites/sprEvolverRifle.png",3,2)
global.sprEvolveBullet = sprite_add("sprites/sprEvolveBullet.png",2,6,8)
global.mskBullet = sprite_add("sprites/mskBullet.png",2,6,8)
global.sprEvolveBulletHit = sprite_add("sprites/sprEvolveBulletHit.png",4,8,8)
global.sprEvolverRifleHud = sprite_add("sprites/hudsprites/sprEvolverRifleHud.png",1,1,3.5)
#define weapon_name
return "EVOLVER RIFLE";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud(_wep)
     // Normal Outline:
    if(
        weapon_get_gold(_wep) != 0 ||
        weapon_get_rads(_wep) > 0  ||
        (instance_is(self, Player) && ((wep == _wep && curse > 0) || (bwep == _wep && bcurse > 0)))
    ){
        return global.sprite;
    }
    
     // Red Outline:
    return global.sprEvolverRifleHud;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 20;

#define weapon_cost
return round(6 + GameCont.hard/10);

#define weapon_swap
return sndSwapMachinegun;

#define weapon_area
return 8;

#define weapon_text
return "@(color:16745694)GROW AND CHANGE";

#define weapon_fire

repeat(1 + GameCont.hard/2)
{
    weapon_post(6, -8, 8);
    sound_play(sndMachinegun);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprEvolveBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskBullet;
  speed = 13;
  friction = 0;
  direction = other.gunangle + (random_range(-7, 7) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "EVOLVING BULLET"];
  damage = 1.5;
  typ = 1;

    on_wall = script_ref_create(evobullet_wall);
  on_hit = script_ref_create(evobullet_hit);
   on_draw = script_ref_create(evobullet_draw);
     on_destroy = script_ref_create(evobullet_die);
       on_anim = event
    }
  wait(0.5);
}


//makes the projectile die when it hits a wall
#define evobullet_wall
         instance_destroy();
  {
  };
  
//makes the projectile actually do damage and have bullethit effect
#define evobullet_hit
if (!projectile_canhit(other)) exit;

projectile_hit(other, damage);

if (skill_get(mut_recycle_gland) && instance_exists(creator) && instance_is(creator, Player) && random(100) < 40) {
  with (creator) ammo[1] = min(ammo[1] + weapon_cost(), typ_amax[1]);
}
projectile_hit(other,damage);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEvolveBulletHit;
  };
instance_destroy();

//gives the projectile its glow and transparency
#define evobullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//makes a particle effect when the projectile dissapears    
#define evobullet_die
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprEvolveBulletHit;
  };
  
//Yokin's thing to make muzzleflash work
#define event
  image_speed = 0;
    image_index = image_number - 1