//ZAP ZAP ZAP ZAP

#define init
global.sprite = sprite_add_weapon("sprites/sprCrystalLaserGunCursed.png",3,7)
global.sprCrystalLaser = sprite_add("sprites/sprCrystalLaser.png",0,2,3)
global.sprCrystalLaserHud = sprite_add_weapon("sprites/hudsprites/sprCrystalLaserHud.png",1,3.5,);

#define weapon_name
return "Cursed Crystal Laser Gun";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprCrystalLaserHud;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 40;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
     // Cursed Chest Exclusive:
    if(("curse" in self && curse > 0) || ("curse" in other && other.curse > 0)){
        return 7; 
    }
    
    return -1;

#define weapon_text
return "@q@(color:16745694)FREE US";

#define weapon_fire

weapon_post(6, -8, 2);
if skill_get(17){
sound_play(sndLaserUpg);
}else{
sound_play(sndLaser);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),EnemyLaser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprCrystalLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle;
	image_yscale = 1.6 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 3;
}
}
for (i = 0; i < 28; i += 7)
{
wait(1)

}
weapon_post(6, -8, 2);
if skill_get(17){
sound_play(sndLaserUpg);
}else{
sound_play(sndLaser);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),EnemyLaser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprCrystalLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle;
	image_yscale = 1.6 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 3;
}
}
for (i = 0; i < 28; i += 7)
{
wait(1)

}
weapon_post(6, -8, 2);
if skill_get(17){
sound_play(sndLaserUpg);
}else{
sound_play(sndLaser);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),EnemyLaser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprCrystalLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle;
	image_yscale = 1.6 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 3;
}
}
for (i = 0; i < 28; i += 7)
{
wait(1)

}
weapon_post(6, -8, 2);
if skill_get(17){
sound_play(sndLaserUpg);
}else{
sound_play(sndLaser);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),EnemyLaser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprCrystalLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle;
	image_yscale = 1.6 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 3;
}
}
for (i = 0; i < 28; i += 7)
{
wait(1)

}