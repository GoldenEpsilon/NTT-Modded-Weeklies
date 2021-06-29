//sploosh sploosh sploosh

#define init
global.sprite = sprite_add_weapon("sprites/sprMaelstorm.png",10,8)
global.sprBubbleBullet = sprite_add("sprites/sprMaelstormBullet.png",17,12,12)
global.mskBubbleBullet = sprite_add("sprites/mskMaelstormBullet.png",1,12,12)
global.sprMaelstormAOE = sprite_add("sprites/sprMaelstormAOE.png",6,8,8)
global.mskMaelstormAOE = sprite_add("sprites/mskMaelstormAOE.png",1,8,8)
global.sprMaelstormBulletHit = sprite_add("sprites/sprMaelstormBulletHit.png",4,12,12)
global.sprMaelstormTrail = sprite_add("sprites/sprMaelstormTrail.png",3,4,4)
global.sprMaelstormTrail2 = sprite_add("sprites/sprMaelstormTrail2.png",3,4,4)

//sounds
global.sndMaelstormFire = sound_add("sounds/sndMaelstormFire.ogg");
global.sndMaelstormHit = sound_add("sounds/sndMaelstormHit.ogg");

#define weapon_name
return "MAELSTORM";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 6;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapBow;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)SMELLS LIKE SHRIMP";

#define weapon_fire

{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(global.sndMaelstormFire);
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprBubbleBullet;
      mask_index = global.mskBubbleBullet;
      direction = other.gunangle + (random_range(7, -7) * other.accuracy);
      speed = 6;
      damage = 7;
      image_angle = direction;
      team = other.team;
      creator = other;
      
      on_draw = bubblebullet_draw;
      on_destroy = bubblebullet_die;
      on_step = bubblebullet_step;
    old_active_frame = current_frame;
    }
}
}

#define bubblebullet_step

with instance_create(x+random_range(-2,2),y+random_range(-2,2),PlasmaTrail)
{
  sprite_index = global.sprMaelstormTrail;
  image_angle = random_range(0,360);
}

if current_frame > old_active_frame + 5{
    old_active_frame = current_frame;
    with instance_create(x+random_range(-8,8),y+random_range(-8,8),PlasmaTrail)
{
  sprite_index = global.sprMaelstormTrail2;
  image_angle = random_range(0,360);
}
}
#define bubblebullet_die
//creates the AOE effect of the bullet impact (similar to plasma impacts)
  
  //bullethit
           with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprMaelstormBulletHit;
  }
  
   //sound
   sound_play(global.sndMaelstormHit);
    
    //aoe damage    
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprMaelstormAOE;
      mask_index = global.mskMaelstormAOE;
      speed = 0;
      damage = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
      
      bombtimer = 12;
      on_hit = maelstormAOE_hit;
      on_wall = maelstormAOE_wall;
      on_step = maelstormAOE_step;
      on_draw = maelstormAOE_draw;
    }

#define bubblebullet_draw
image_angle += 2
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.3*image_xscale, 1.3*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);






//AOE scripts
#define maelstormAOE_wall
// do nothing

#define maelstormAOE_step
bombtimer -= 1;
if bombtimer < 1 instance_destroy();

#define maelstormAOE_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}

#define maelstormAOE_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 0.4);
draw_set_blend_mode(bm_normal);