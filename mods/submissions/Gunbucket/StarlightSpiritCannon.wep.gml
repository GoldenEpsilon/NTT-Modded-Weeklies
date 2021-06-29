//visually based off Ori games, this also works as a good base for making weps that follow cursor like nukes (look in the on_step)

#define init
global.sprite = sprite_add_weapon("sprites/sprSpiritStarlightCannon.png",6,7)
global.sprSpiritTrail = sprite_add("sprites/sprSpiritTrail.png",3,4,4)
global.sprSpiritStar = sprite_add("sprites/sprSpiritStar.png",2,12,12)
global.mskSpiritStar = sprite_add("sprites/mskSpiritStar.png",1,12,12)
global.sprSpiritStarLarge = sprite_add("sprites/sprSpiritStarLarge.png",2,16,16)
global.mskSpiritStarLarge = sprite_add("sprites/mskSpiritStarLarge.png",1,16,16)
global.sprSpiritStarImpact = sprite_add("sprites/sprSpiritStarImpact.png",7,16,16)

#define weapon_name
return "STARLIGHT SPIRIT CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 60;

#define weapon_cost
return 10;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 16;

#define weapon_text
return "@(color:16745694)STARRY NIGHT";

#define weapon_fire

    weapon_post(3, -8, 8);
   {
  if instance_exists(self)
  { 
repeat(1)
{
  if instance_exists(self)
  {
    sound_play_pitchvol(sndPlasmaMinigun,1,1);
    with instance_create(x + lengthdir_x(15,gunangle),y + lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprSpiritStarLarge;
      mask_index = global.mskSpiritStarLarge;
      direction = other.gunangle + (random_range(30, -30) * other.accuracy);
      speed = 3;
      damage = 10;
      image_angle = direction;
      team = other.team;
      creator = other;
      
            starhitcount = 0;
      
     on_step = script_ref_create(LargeSpiritStarStep);
	  on_hit = script_ref_create(SpiritStarHit);
      on_wall = script_ref_create(LargeSpiritStarWall);
      on_draw = script_ref_create(SpiritStarDraw);
      on_destroy = script_ref_create(LargeSpiritStarDie);
      on_anim = muzzleflashevent;

}
    }
    }
    wait(1);
	}
}


#define LargeSpiritStarDie
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaImpact){
	sprite_index = global.sprSpiritStarImpact;
}
    sound_play_pitchvol(sndPlasmaBig,1.1,0.9);
for (i = 0; i < 360; i += 24)
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprSpiritStar;
      mask_index = global.mskSpiritStar;
    direction = other.direction + other.i + random_range(-1,1);
      speed = 9;
      damage = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
      
            starhitcount = 0;
      
     on_step = script_ref_create(SpiritStarStep);
	  on_hit = script_ref_create(SpiritStarHit);
      on_wall = script_ref_create(SpiritStarWall);
      on_draw = script_ref_create(SpiritStarDraw);
      on_destroy = script_ref_create(SpiritStarDie);
            on_anim = muzzleflashevent;
    }

#define LargeSpiritStarStep
 if instance_exists(creator)
  {
var _x = mouse_x[creator.index]
var _y = mouse_y[creator.index]
}
if instance_exists(creator) {
	motion_add(point_direction(x,y,_x,_y),.5)
	image_angle = direction
	speed = 6
}

  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprSpiritTrail
  	image_xscale = 1.5;
  	image_yscale = image_xscale;
  }
    with instance_create(x+random_range(-15,15),y+random_range(-15,15),PlasmaTrail){
  	sprite_index = global.sprSpiritTrail
  }

if starhitcount > 5 instance_destroy();

#define LargeSpiritStarWall
instance_create(x,y,PortalClear)
instance_destroy();

#define SpiritStarStep
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprSpiritTrail
  }

if starhitcount > 5 instance_destroy();


#define SpiritStarDie
with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaImpact){
	sprite_index = global.sprSpiritStarImpact;
}
    sound_play_pitchvol(sndPlasma,1.1,0.9);

#define SpiritStarHit
projectile_hit(other,damage,force);


starhitcount +=1;
  
#define SpiritStarWall
instance_destroy();

#define SpiritStarDraw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define muzzleflashevent
  image_speed = 0;
    image_index = image_number - 1