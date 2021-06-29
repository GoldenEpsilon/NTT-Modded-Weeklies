//WOOOO FIRE WEAPON!

#define init
global.sprite = sprite_add_weapon("sprites/sprUltraDragon.png",5,7)
global.sprUltraFire = sprite_add("sprites/sprUltraFire.png",7,8,8);
global.sprUltraDragonHud = sprite_add_weapon("sprites/hudsprites/sprUltraDragonHud.png",1,3.5,);

#define weapon_name
return "ULTRA DRAGON";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprUltraDragonHud;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 15;

#define weapon_rads
return 18

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapDragon;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)DONT FORGET TO FEED HIM";

#define weapon_fire
sound_play(sndDragonLoop);
repeat(15){
  if instance_exists(self){
  {
  	repeat(13){
    weapon_post(6, -8, 8);
    with instance_create(x+lengthdir_x(10,gunangle),y+lengthdir_y(10,gunangle),Flame)
    {
    	move_contact_solid(other.gunangle, 6);
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 12 ;
      image_angle = direction;
      	sprite_index = global.sprUltraFire;
      damage = 7;
      team = other.team;
      creator = other;

    }
  }
  }
wait(1)
}
}
      
audio_stop_sound(sndDragonLoop);

