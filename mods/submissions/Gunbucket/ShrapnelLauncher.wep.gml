//splinter grenade basically

#define init
global.sprite = sprite_add_weapon("sprites/sprShrapnelLauncher.png",4,3)
global.sprShrapnelNade = sprite_add("sprites/sprShrapnelNade.png",0,4,4)
global.sprblink = sprite_add("sprites/sprShrapnelNadeBlink.png",2,4,4)
global.mskShrapnelNade = sprite_add("sprites/mskShrapnelNade.png",0,4,4)

#define weapon_name
return "SHRAPNEL LAUNCHER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 30;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 5;

#define weapon_text
return "@(color:16745694)WAR WOUNDS";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play_pitchvol(sndClusterLauncher,1.2,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprShrapnelNade;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskShrapnelNade;
  speed = 13;
  friction = 0.5;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SHRAPNEL BOMB"];
  damage = 5;
  force = 50;
  typ = 1;
  bombtimer = 50;
    on_wall = script_ref_create(shrapnel_wall);
  on_hit = script_ref_create(shrapnel_hit);
  on_destroy = script_ref_create(shrapnel_die);
   	on_step = script_ref_create(bombstep);
   	    on_end_step = script_ref_create(reflect_endstep);
    }
	}
  wait(4);
}

#define shrapnel_wall
sound_play_pitchvol(sndGrenadeHitWall,1,1);
    with instance_create(x, y, Dust)
    instance_create(x,y,Dust);
    move_bounce_solid(true);
    speed -= 4;
	if speed < 0 speed = 0;

#define shrapnel_hit
projectile_hit(other,damage,force);
  instance_destroy();

#define bombstep
bombtimer -= 1;
if bombtimer < 11 sprite_index = global.sprblink;
if bombtimer < 1 || place_meeting(x,y,Explosion) || place_meeting(x,y,PopoExplosion) || place_meeting(x,y,SmallExplosion) instance_destroy();

#define shrapnel_die
sound_play(sndExplosionS);
sound_play(sndClusterOpen);



for (i = 0; i < 300; i += 40)
repeat(1)
{
 with instance_create(x,y,Splinter)
{
  image_xscale = 1;
  image_yscale = image_xscale;
  speed = 14;
  friction = 0;
 direction = other.direction + other.i + random_range(-20,20);
  image_angle = direction;
  hitid = [sprite_index, "SPLINTER"];
  team = other.team
  creator = other;
  damage = 5;
  force = 2;
  typ = 1;
    }
}
{
 with instance_create(x,y,SmallExplosion)
{
}
}

#define reflect_endstep

//Yokin's Reflect Code
if(place_meeting(x, y, projectile)){
    var _inst = instances_meeting(x, y, [Slash, GuitarSlash, BloodSlash, EnergySlash, EnergyHammerSlash, LightningSlash, CustomSlash]);
    if(array_length(_inst)) with(_inst){
        if(place_meeting(x, y, other)){
            event_perform(ev_collision, Grenade);
            if(!instance_exists(other)) exit;
        }
    }
}

#define instances_meeting(_x, _y, _obj)
    /*
        Returns all instances whose bounding boxes overlap the calling instance's bounding box at the given position
        Much better performance than manually performing 'place_meeting(x, y, other)' on every instance
    */
    
    var _tx = x,
        _ty = y;
        
    x = _x;
    y = _y;
    
    var _inst = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
    
    x = _tx;
    y = _ty;
    
    return _inst;
