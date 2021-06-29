//half life video game in Nuccy Throne??? whaaaat

#define init
global.sprite = sprite_add_weapon("sprites/sprRebarBow.png",1,4)
global.sprRebarBolt = sprite_add("sprites/sprRebarBolt.png",2,8,8)
#define weapon_name
return "REBAR BOW";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 3;

#define weapon_auto
return true;

#define weapon_load
return 10;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapMachinegun;

#define weapon_area
return 8;

#define weapon_text
return "@(color:16745694)HEATED BARS";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
sound_play(sndCrossbow);
  with instance_create(x + lengthdir_x(-4,gunangle),y + lengthdir_y(-4,gunangle),CustomProjectile)
{
  sprite_index = global.sprRebarBolt;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskBolt;
  speed = 35;
  friction = 0;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "REBARBOLT"];
      length = 6;
    lastvictim = 2;
  	alarm1 = 999;
	prevx = x;
	prevy = y;
	jumpCD = 5
  damage = 30;
  typ = 1;

  on_hit = script_ref_create(rebarbolt_hit);
   on_draw = script_ref_create(rebarbolt_draw);
     on_destroy = script_ref_create(rebarbolt_die);
          on_anim = event
            		on_step = script_ref_create(Boltstep);
          	on_end_step = script_ref_create(BoltyBits);
          		on_wall = script_ref_create(Boltwall);
    }
	}
  wait(4);
}

  
//makes the projectile actually do damage and have bullethit effect
#define rebarbolt_hit

projectile_hit(other,damage,force);
         with instance_create(x,y,Flame)
  {
  team = other.team;
  creator = other;
  };
instance_destroy();

//gives the projectile its glow and transparency
#define rebarbolt_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);
    

//makes a thing when the projectile dissapears    
#define rebarbolt_die

         with instance_create(x,y,Flame)
  {
  	  team = other.team;
  creator = other;
  };

#define Boltstep
if image_index = 1{
	image_speed = 0
}
if speed > 0{
jumpCD -= 1

if image_index = 1{
with(instance_create(x,y,BoltTrail)) {
     image_angle = point_direction(x,y,other.prevx,other.prevy)
     image_xscale = point_distance(x,y,other.prevx,other.prevy);
     image_yscale = 1.5;
		}
	}
}
prevx = x
prevy = y
if alarm1 > 0{
alarm1 -= 1
}else{
instance_destroy()
}

//makes the bolt stick into the wall 
#define Boltwall
speed = 0;
alarm1 = 30;
mask_index = mskAlly;
move_contact_solid(direction, 32);
with(instance_create(x,y,BoltTrail)) {
     image_angle = point_direction(x,y,other.prevx,other.prevy)
     image_xscale = point_distance(x,y,other.prevx,other.prevy);
     image_yscale = 1.5;
		}
sound_play(sndBoltHitWall);
mask_index = mskNone;
  
#define event
  image_speed = 0;
    image_index = image_number - 1

//makes the projectile have a bolt trail and work with Bolt Marrow mut
#define BoltyBits
if ((speed > 0) && skill_get(mut_bolt_marrow))
{
    dir = instance_nearest(x, y, enemy)
	if instance_exists(dir){
    if (point_distance(x, y, dir.x, dir.y) < 24 * skill_get(mut_bolt_marrow))
    {
        x = (dir.x - hspeed_raw)
        y = (dir.y - vspeed_raw)
		}
    }
}
var _x1 = x,
    _y1 = y,
    _x2 = xprevious,
    _y2 = yprevious;
    
with(instance_create(x, y, BoltTrail)){
    image_xscale = point_distance(_x1, _y1, _x2, _y2);
    image_angle = point_direction(_x1, _y1, _x2, _y2);
}