//ION CANNON BUT VIABLE?? HOW!

#define init
global.sprite = sprite_add_weapon("sprites/sprIonCannonMk2.png",2,3)

#define weapon_name
return "ION CANNON MK2";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 80;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)DEATH FROM ABOVE";

#define weapon_fire
repeat(2)
{
  if instance_exists(self)
  {
    weapon_post(12, -8, 8);
if skill_get(17){
  sound_play_pitchvol(sndPlasmaBigUpg,1.2,1);
}else{
  sound_play_pitchvol(sndPlasmaBig,1.2,1);
}
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),IonBurst)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}
  wait(10);

    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),IonBurst)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
    }


  wait(10);

    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),IonBurst)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	
