//MORE CLUSTERS! HOORAY!

#define init
global.sprite = sprite_add_weapon("sprites/sprClusterShotgun.png",5,6)

#define weapon_name
return "CLUSTER SHOTGUN";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 80;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 13;

#define weapon_text
return "@(color:16745694)CLUSTERCEPTION";

#define weapon_fire
motion_add(gunangle,-5);
repeat(3)
{
  if instance_exists(self)
  {
    weapon_post(12, -8, 8);
sound_play_pitchvol(sndGrenadeShotgun,0.7,1);
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),ClusterNade)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}
  wait(1.5);
repeat(2)
{
  if instance_exists(self)
  {
    with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),ClusterNade)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 9;
      image_angle = direction;
      team = other.team;
      creator = other;
    }

	}
}