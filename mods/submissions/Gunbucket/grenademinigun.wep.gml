//this is actually probably the safest grenade wep to use, I made it so it doesn't blow you up like the gatling bazooka

#define init
global.sprite = sprite_add_weapon("sprites/sprGrenadeMinigun.png",2,3)

#define weapon_name
return "Grenade Minigun";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 4;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)BOOM BOOM BOOM";

#define weapon_fire

repeat(3)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndGrenadeRifle);
    with instance_create(x,y,CustomProjectile)
    {
    	sprite_index = sprMininade;
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
      bombtimer = 15;
      
         on_step = script_ref_create(mininade_step);
     on_destroy = script_ref_create(mininade_die);
        on_wall = script_ref_create(mininade_wall);
    }
      
	}
  wait(1.5);
}

#define mininade_step
bombtimer -= 1;
if bombtimer < 1 instance_destroy();

#define mininade_die
         with instance_create(x,y,SmallExplosion)
  {
  	    sound_play(sndExplosionS);
  };
  
#define mininade_wall
instance_destroy();