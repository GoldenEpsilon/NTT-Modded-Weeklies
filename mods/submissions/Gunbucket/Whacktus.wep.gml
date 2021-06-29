//Mufina sent an image of something that was basically this weapon and I wanted to make it so thank you Mufina!
//splinter projectiles lag behind to stop iFrames from making this weapon do basically nothing


#define init
global.sprite = sprite_add_weapon("sprites/sprWhacktus.png",5,5)

#define weapon_name
return "WHACKTUS";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 0;

#define weapon_melee
return true;

#define weapon_auto
return false;

#define weapon_load
return 30;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapHammer;

#define weapon_area
return 3;

#define weapon_text
return "@(color:14986093)THIS IS WHY NO ONE LOVES YOU.@s@(color:16745694)#BECAUSE OF THE WHACKTUS?@s@(color:14986093)#YEAH.";

#define weapon_fire

sound_play(sndScrewdriver);
weapon_post(0, 4, 12);
  with instance_create(x+lengthdir_x(skill_get(13)*17,gunangle),y+lengthdir_y(skill_get(13)*17,gunangle),Slash)
  {
    direction = other.gunangle;
      image_angle = direction;
    speed = 2 * (skill_get(13) + 2);
      team = other.team;
      creator = other;
          damage = 12;
      
    }
        wepangle = -wepangle;
motion_add(gunangle, 3.5);

      wait(1);
      {
  if instance_exists(self)
  {
for(i = -10; i < 10; i += 10)
{
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),Splinter)
  {
    direction = other.gunangle + (other.i * other.accuracy);
    speed = 16
    image_angle = direction;
    team = other.team;
    damage = 2;
    creator = other;
  }
}
  }
      }
