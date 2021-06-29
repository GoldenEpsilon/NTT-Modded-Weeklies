//I didn't realize this was an undertale reference until it was too late

#define init
global.sprite = sprite_add_weapon("sprites/sprMegaLaserPrism.png",1,7)
global.sprRainbowLaser = sprite_add("sprites/sprRainbowLaser.png",14,2,3)
global.sprMegaLaserPrismHud = sprite_add_weapon("sprites/hudsprites/sprMegaLaserPrismHud.png",1,3.5,);

#define weapon_name
return "Mega Laser Prism";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprMegaLaserPrismHud;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 40;

#define weapon_cost
return 16;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 16;

#define weapon_text
return "@(color:16745694)HOLD ON TO YOUR HOPES AND DREAMS";

#define weapon_fire

weapon_post(6, -8, 2);
if skill_get(17){
  sound_play_pitchvol(sndPlasmaHuge,2,1);
}else{
  sound_play_pitchvol(sndPlasmaHuge,1.5,1);
}
  if instance_exists(self)
  {
with instance_create(x + lengthdir_x(3,gunangle),y + lengthdir_y(3,gunangle),Laser)
{
	alarm0 = 2 + (skill_get(17));
	  sprite_index = global.sprRainbowLaser;
      mask_index = mskLaser;
	image_angle = other.gunangle;
	image_yscale = 15 + (skill_get(17) * 0.6);
	team = other.team
	creator = other;
	damage = 7;
}
}
for (i = 0; i < 28; i += 7)
{
wait(1)

}