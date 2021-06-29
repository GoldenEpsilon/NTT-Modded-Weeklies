//toxic time

#define init
global.sprite = sprite_add_weapon("sprites/sprToxicBubbler.png",5,5)
global.sprToxBubble = sprite_add("sprites/sprToxicBubble.png",1,6,6)
global.sprToxBubblePop = sprite_add("sprites/sprToxBubblePop.png",4,12,12)

#define weapon_name
return "Toxic Bubbler";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 30;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 8;

#define weapon_text
return "@(color:16745694)TOXIC SHOCK";

#define weapon_fire

weapon_post(3, -8, 8);
sound_play_pitchvol(sndOasisShoot,1,2);
sound_play(sndOasisHorn);
    
repeat(5)
{
  if instance_exists(self)
  {
    with instance_create(x,y,CustomProjectile)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 4 + random_range(0,2);
      friction = 0.05;
      image_angle = direction + random_range(0,4);
      image_xscale = 0.1 + random_range(1.3,0.7);
      image_yscale = image_xscale;
      team = other.team;
      creator = other;
      mask_index = mskDisc;
      sprite_index = global.sprToxBubble;
      toxbombtimer = 60;
      
      on_wall = ToxBubbleWall;
      on_destroy = ToxBubbleDie;
      on_step = ToxBubbleStep;
      on_draw = ToxBubbleDraw;
    }
}
wait(0.2);
}

#define ToxBubbleWall
	move_bounce_solid(true);
	
#define ToxBubbleStep
toxbombtimer -= 1;
if toxbombtimer < 1 instance_destroy();

#define ToxBubbleDie
  with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprToxBubblePop;
  }
sound_play(sndToxicBarrelGas);
for (i = 0; i < 360; i += 28)
{
 with instance_create(x,y,ToxicGas)
  {
    direction = other.direction + other.i + random_range(-65,65);
    speed = 1 + random_range(0,1);
  }
}

#define ToxBubbleDraw
image_angle += (speed * 0.7);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.6*image_xscale, 1.6*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);