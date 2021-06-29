//another lazy minigun wep, miniguns are fun ok!?

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraSeekerPistol.png",1,2)
global.sprUltraSeeker = sprite_add("sprites/sprUltraSeeker.png",2,8,8)
global.sprUltraSeekerHit = sprite_add("sprites/sprUltraSeekerHit.png",4,0,0)

#define weapon_name
return "Ultra Seeker Pistol";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 3;

#define weapon_auto
return true;

#define weapon_load
return 10;

#define weapon_cost
return 2;

#define weapon_rads
return 12;

#define weapon_swap
return sndSwapBow;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)NOWHERE TO RUN";

#define weapon_fire

    weapon_post(4, -8, 8);
sound_play_pitchvol(sndSeekerPistol,0.7,1);
sound_play_pitchvol(sndUltraCrossbow,1.2,1);
    
repeat(4)
{
  if instance_exists(self)
  {
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprUltraSeeker;
      mask_index = mskSeeker;
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 9;
      image_angle = direction;
      damage = 18;
      team = other.team;
      creator = other;
      target=noone;
      angle=16;
      USeekerWallCount = 0;
      
      on_step = script_ref_create(UltraSeekerStep);
      on_wall = script_ref_create(UltraSeekerWall);
      on_destroy = script_ref_create(UltraSeekerDie);
      on_anim = muzzleflashevent;
    }
}
}

#define UltraSeekerWall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}
USeekerWallCount +=1;

#define UltraSeekerHit
instance_destroy();

#define UltraSeekerDie
    sound_play(sndSeekerPistol);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprUltraSeekerHit;
  }

#define UltraSeekerStep

image_angle = direction;
if target = noone && instance_exists(enemy){
	var nearest = enemy;
	if distance_to_object(nearest) < 100{
	with enemy if point_distance(other.x, other.y, x, y) < point_distance(other.x, other.y, nearest.x, nearest.y)
	&& !collision_line(other.x, other.y, x, y, Wall, 0, 0) nearest = self;
	if !collision_line(x, y, nearest.x, nearest.y, Wall, 0, 0) target = nearest;
}
}
angle += 0.1 * current_time_scale;
if instance_exists(target) direction += clamp(angle_difference(point_direction(x, y, target.x, target.y), direction), -angle, angle) * (0.4 + (skill_get(21) * 0.3));
with(instance_create(x, y, BoltTrail)) {
	sprite_index = sprUltraBoltTrail;
     image_angle = other.direction;
     image_xscale = other.speed;
     image_yscale = 1.5;
}

if USeekerWallCount > 1 instance_destroy();

#define muzzleflashevent
  image_speed = 0;
    image_index = image_number - 1