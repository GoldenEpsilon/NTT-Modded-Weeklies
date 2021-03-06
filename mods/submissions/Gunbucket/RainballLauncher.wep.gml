//pretty much took the shrapnel grenade and made a laser version

#define init
global.sprite = sprite_add_weapon("sprites/sprRainballLauncher.png",5,6)
global.sprLaserNade = sprite_add("sprites/sprRainbowLaserNade.png",14,12,12)
global.sprblink = sprite_add("sprites/sprRainbowLaserNadeBlink.png",2,12,12)
global.sprRainbowLaser = sprite_add("sprites/sprRainbowLaserSmall.png",10,2,3)
global.sprRainbowImpact = sprite_add("sprites/sprRainbowPlasmaImpact.png",7,16,16)
global.mskShrapnelNade = sprite_add("sprites/mskShrapnelNade.png",0,4,4)

#define weapon_name
return "RAINBALL LAUNCHER";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 90;

#define weapon_cost
return 10;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 15;

#define weapon_text
return "@(color:16745694)BOOGIE BOMB";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play_pitchvol(sndClusterLauncher,1.2,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprLaserNade;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskShrapnelNade;
  speed = 13;
  friction = 0.5;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "RAINBOW LASER BOMB"];
  damage = 1;
  force = 0;
  typ = 1;
  bombtimer = 100;
    on_wall = script_ref_create(rainball_wall);
  on_hit = script_ref_create(rainball_hit);
  on_destroy = script_ref_create(rainball_die);
   	on_step = script_ref_create(rainballbombstep);
    on_end_step = script_ref_create(reflect_endstep);
    old_active_frame = current_frame;
    }
	}
  wait(4);
}

#define rainball_wall
sound_play_pitchvol(sndGrenadeHitWall,1,1);
    with instance_create(x, y, Dust)
    instance_create(x,y,Dust);
    move_bounce_solid(true);
    speed -= 4;
	if speed < 0 speed = 0;

#define rainball_hit
instance_create(x, y, Dust);

#define rainballbombstep
bombtimer -= 1;

if current_frame > old_active_frame + 5{
    old_active_frame = current_frame;
if bombtimer < 50
{
	if skill_get(17){
  sound_play_pitchvol(sndLaserUpg,0.7,1);
}else{
  sound_play_pitchvol(sndLaser,0.7,1);
}

for (i = 0; i < 300; i += 60)
repeat(1)
{
 with instance_create(x,y,Laser)
{
	alarm0 = 2 + (skill_get(17));
  sprite_index = global.sprRainbowLaser;
  image_angle = other.i + random_range(-40,40)
  image_yscale = 4 + (skill_get(17) * 0.6);
  hitid = [sprite_index, "LASER"];
  team = other.team
  creator = other;
    }
}
}
}

if bombtimer < 50 sprite_index = global.sprblink;
if bombtimer < 1  instance_destroy();

#define rainball_die
if skill_get(17){
  sound_play_pitchvol(sndPlasmaUpg,0.7,1);
}else{
  sound_play_pitchvol(sndPlasma,0.7,1);
}
 with instance_create(x,y,PlasmaImpact)
{
	  sprite_index = global.sprRainbowImpact;
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
