//pretty much took the shrapnel grenade and made a laser version

#define init
global.sprite = sprite_add_weapon("sprites/sprHeavyLaserNader.png",6,4)
global.sprHLaserNade = sprite_add("sprites/sprHeavyLaserNade.png",0,4,4)
global.sprHLaserBlink = sprite_add("sprites/sprHeavyLaserNadeBlink.png",2,4,4)
global.mskHLaserNade = sprite_add("sprites/mskHeavyLaserNade.png",0,4,4)

#define weapon_name
return "HEAVY LASER LAUNCHER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 45;

#define weapon_cost
return 4;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)LASER LIGHT SHOW";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play_pitchvol(sndClusterLauncher,0.8,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprHLaserNade;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskHLaserNade;
  speed = 13;
  friction = 0.5;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "HEAVY LASER BOMB"];
  damage = 5;
  typ = 1;
  bombtimer = 50;
    on_wall = script_ref_create(shrapnel_wall);
  on_hit = script_ref_create(shrapnel_hit);
  on_destroy = script_ref_create(shrapnel_die);
   	on_step = script_ref_create(bombstep);
    on_end_step = script_ref_create(reflect_endstep);
    }
	}
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
if bombtimer < 11 sprite_index = global.sprHLaserBlink;
if bombtimer < 1 || place_meeting(x,y,Explosion) || place_meeting(x,y,PopoExplosion) || place_meeting(x,y,SmallExplosion) instance_destroy();

#define shrapnel_die
if skill_get(17){
  sound_play_pitchvol(sndLaserUpg,0.5,1);
}else{
  sound_play_pitchvol(sndLaser,0.5,1);
}

for (i = 0; i < 360; i += 36)
repeat(1)
{
 with instance_create(x,y,Laser)
{
	alarm0 = 2 + (skill_get(17));
  image_angle = other.i + random_range(-20,20)
  image_yscale = 2.5 + (skill_get(17) * 0.6);
  hitid = [sprite_index, "LASER"];
  team = other.team
  creator = other;
    }
}
{
 with instance_create(x,y,PlasmaImpact)
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
