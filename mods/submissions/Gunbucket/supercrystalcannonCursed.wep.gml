//?yeht era hguoht eromyna snoitidnoc lamron t'nera eseht ,worg ot emit gnol yrev a ekat dluow snoitidnoc lamron rednu slatsyrc fo tnuoma siht

#define init
global.sprite = sprite_add_weapon("sprites/sprSuperCrystalCannonCursed.png",3,7)
global.sprLargeCrystalBullet = sprite_add("sprites/sprLargeCrystalBulletCursed.png",2,13,7)
global.mskLargeCrystalBullet = sprite_add("sprites/mskLargeCrystalBullet.png",0,13,7)
global.sprSmallCrystalBullet = sprite_add("sprites/sprSmallCrystalBulletCursed.png",0,13,13)
global.mskSmallCrystalBullet = sprite_add("sprites/mskSmallCrystalBullet.png",0,13,13)
global.sprSmallCrystalBulletHit = sprite_add("sprites/sprSmallCrystalBulletHitCursed.png",4,0,0)
#define weapon_name
return "Cursed Super Crystal Cannon";

#define weapon_sprt
return global.sprite;


#define weapon_type
return 2;

#define weapon_auto
return false;

#define weapon_load
return 100;

#define weapon_cost
return 18;

#define weapon_swap
return sndSwapShotgun;

//yokin made this! thank you!
#define weapon_area
     // Cursed Chest Exclusive:
    if(("curse" in self && curse > 0) || ("curse" in other && other.curse > 0)){
        return 14;
    }
    
    return -1;

#define weapon_text
return "@q@q@(color:16745694)HELP US";

//the projectile here is the Huge crystal bullet
#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlakCannon);
  with instance_create(x + lengthdir_x(20,gunangle),y + lengthdir_y(20,gunangle),CustomProjectile)
{
  sprite_index = global.sprLargeCrystalBullet;
  image_xscale = 1.5;
  image_yscale = image_xscale;
  mask_index = global.mskLargeCrystalBullet;
  speed = 10;
  friction = 0;
  direction = other.gunangle + (random_range(-10, 10) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "HUGE CRYSTAL BULLET"];
  damage = 9;
  force = 3;
  typ = 1;
    on_wall = script_ref_create(hugecrystal_wall);
  on_hit = script_ref_create(largecrystal_hit);
  on_destroy = script_ref_create(hugecrystal_die);
   on_draw = script_ref_create(largecrystal_draw);
   on_step = script_ref_create(largecrystal_step);
             on_anim = event
    }
	}
  wait(4);
}




#define hugecrystal_die
 sound_play(sndExplosionS);
for (i = 0; i < 300; i += 40)
repeat(1)
{
 with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprLargeCrystalBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskLargeCrystalBullet;
  speed = 10;
  friction = 0;
 direction = other.direction + other.i + random_range(-10,10);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "LARGE CRYSTAL BULLET"];
  damage = 9;
  force = 3;
  typ = 1;
    on_wall = script_ref_create(largecrystal_wall);
  on_hit = script_ref_create(largecrystal_hit);
  on_destroy = script_ref_create(largecrystal_die);
   on_draw = script_ref_create(largecrystal_draw);
   on_step = script_ref_create(largecrystal_step);
             on_anim = event
    }
	}
	
#define hugecrystal_wall
with(other){
  instance_create(x, y, PortalClear);
  instance_destroy();
}
 instance_destroy();
 
//large crystal projectile stuff
#define largecrystal_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}
 instance_destroy();
#define largecrystal_hit
projectile_hit(other,damage,force);
instance_destroy();

#define largecrystal_step
with instance_create(x+random_range(-10,20),y+random_range(-10,20),PlasmaTrail)
{
  sprite_index = sprCurse;
}
#define largecrystal_draw
image_angle += (speed * 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.9);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//the projectile here is the small crystal bullet
#define largecrystal_die
sound_play(sndExplosionS);
for (i = 0; i < 300; i += 48)
repeat(1)
{
 with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprSmallCrystalBullet;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskSmallCrystalBullet;
  speed = 14;
  friction = 0;
 direction = other.direction + other.i + random_range(-1,1);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SMALL CRYSTAL BULLET"];
  damage = 5;
  force = 2;
  typ = 1;
    on_wall = script_ref_create(smallcrystal_wall);
  on_hit = script_ref_create(smallcrystal_hit);
  on_destroy = script_ref_create(smallcrystal_die);
   on_draw = script_ref_create(smallcrystal_draw);
      on_step = script_ref_create(smallcrystal_step);
    }
}

//small crystal projectile stuff
#define smallcrystal_wall
instance_destroy();

#define smallcrystal_die
    sound_play(sndCrystalPropBreak);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprSmallCrystalBulletHit;
  }
#define smallcrystal_hit
projectile_hit(other,damage,force);



#define smallcrystal_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.9);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

#define smallcrystal_step
with instance_create(x+random_range(-10,10),y+random_range(-10,10),PlasmaTrail)
{
  sprite_index = sprCurse;
}

#define event
  image_speed = 0;
    image_index = image_number - 1