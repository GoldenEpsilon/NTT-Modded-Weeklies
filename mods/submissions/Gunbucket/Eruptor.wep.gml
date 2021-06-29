//I should really be working on my data.win resprite, at the time of writing this Volcano is hardly finished at all, well at least this wep should be pretty fun

#define init
global.sprite = sprite_add_weapon("sprites/sprEruptor.png",12,5)

#define weapon_name
return "Eruptor";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 10;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapFlame;


#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)FURY OF THE MOUNTAINS";

#define weapon_fire

motion_add(gunangle,-3);
  weapon_post(6, -8, 8);
  sound_play(sndFlameCannon);
  //FlameBall
repeat(1)
{
  if instance_exists(self)
  {
    with instance_create(x,y,FlameBall,)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
}
//FlameShells
repeat(6)
{
  if instance_exists(self)
  {
    with instance_create(x,y,FlameShell,)
    {
      direction = other.gunangle + (random_range(40, -40) * other.accuracy);
      speed = 11 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
}
//Flames
repeat(3)
{
  if instance_exists(self)
  {
repeat(6)
{
  if instance_exists(self)
  {
    with instance_create(x+lengthdir_x(10,gunangle),y+lengthdir_y(10,gunangle),Flame)
    {
    	move_contact_solid(other.gunangle, 6);
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 5 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;

    }
  }
  wait(1)
  }
  }
}