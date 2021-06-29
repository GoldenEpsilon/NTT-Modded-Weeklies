
//dragonite gun dragonite gun dragonite gun dragonite gun dragonite gun dragonite gun 
//sani showed me that for lasers to have inaccuracy you change their image_angle,
//lasers are evil

#define init
global.sprite = sprite_add_weapon("sprites/sprHyperBeamCannon.png",10,7)
global.sprHyperBeamLaser = sprite_add("sprites/sprHyperBeamLaser.png",6,2,3)
#define weapon_name
return "Hyperbeam Cannon";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 90;

#define weapon_cost
return 18;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 17;

#define weapon_text
return "@(color:16745694)IT WAS SUPER EFFECTIVE!";

#define weapon_fire
  sound_play_pitchvol(sndLaserCannonCharge,2,1);
  wait(8);
  {
repeat(20)
{
	        if instance_exists(self)
  {
weapon_post(7, -8, 2);
if skill_get(17){
  sound_play_pitchvol(sndLaserCannon,2,1);
}else{
  sound_play_pitchvol(sndLaserCannon,1.5,1);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),EnemyLaser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprHyperBeamLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle + (random_range(-15, 15) * other.accuracy);
	image_yscale = 5 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 2;
}
}
for (i = 0; i < 28; i += 7)
{
}
  wait(1.5);
}
}
}