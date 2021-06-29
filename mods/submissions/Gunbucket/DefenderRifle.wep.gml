//elite defenders arent as good as elite snipers apparently

#define init
global.sprite = sprite_add_weapon("sprites/sprDefenderRifle.png",5,5)

#define weapon_name
return "DEFENDER RIFLE";

#define weapon_laser_sight
return true;

#define weapon_sprt
return global.sprite;

#define weapon_type
return 1;

#define weapon_auto
return true;

#define weapon_load
return 2.5;

#define weapon_cost
return 4;

#define weapon_swap
return sndSniperTarget;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)THIS IS YOUR TOWN";

#define weapon_fire

sound_play(sndSniperFire);
weapon_post(4, -8, 8);

repeat(3)
{
  if instance_exists(self)
  {
    with instance_create(x,y,Bullet1)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      speed = 18;
      damage = 5;
      image_angle = direction;
      team = other.team;
      creator = other;
      image_yscale = 0.7;
    }
}
wait(0.4);
}
