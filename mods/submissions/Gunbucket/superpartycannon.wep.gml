//this wep was Mufina's idea, thank you!
//this can also be used as a decent base for SPC-Like weapons
//I really REALLY like this weapon, its so confetti! don't spam it though it'll probably crash your game

#define init
global.sprite = sprite_add_weapon("sprites/sprSuperPartyCannon.png",2,6)
global.sprRainbowConfettiAnim = sprite_add("sprites/sprRainbowConfettiAnim.png",15,1,1)
global.sprRainbowConfettiLarge = sprite_add("sprites/sprRainbowConfettiLarge.png",15,4,4)
global.sprRainbowConfettiHuge = sprite_add("sprites/sprRainbowConfettiHuge.png",15,8,8)
global.mskConfettiBall = sprite_add("sprites/mskConfettiBall.png",0,-4,0.5)

#define weapon_name
return "SUPER PARTY CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 90;

#define weapon_cost
return 19;

#define weapon_swap
return sndSwapFlame;

#define weapon_area
return 16;

#define weapon_text
return "@(color:16745694)DANCE DANCE DANCE";

//makes the big party ball
#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprRainbowConfettiHuge;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskConfettiBall;
  speed = 5;
  friction = 0;
  direction = other.gunangle
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "SUPER PARTY BALL"];
  damage = 45;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(partyball_wall);
  on_hit = script_ref_create(partyball_hit);
  on_destroy = script_ref_create(partyball_die);
   on_draw = script_ref_create(partyball_draw);
      on_step = script_ref_create(partyball_step);
}
}
  wait(4);
}

#define partyball_wall
instance_destroy();

#define partyball_hit
projectile_hit(other,damage,force);
instance_destroy();

//makes the little party balls
#define partyball_die
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
for (i = 0; i < 360; i += 24)
repeat(1)
  with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprRainbowConfettiLarge;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskConfettiBall;
  speed = 5;
    direction = other.direction + other.i + random_range(-1,1);
  friction = 0;
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "LARGE PARTY BALL"];
  damage = 25;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(partyball_wall);
  on_hit = script_ref_create(partyball_hit);
  on_destroy = script_ref_create(ConfettiSmall_die);
   on_draw = script_ref_create(partyball_draw);
        on_step = script_ref_create(partyball_step);
}

#define ConfettiSmall_die
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 24)
repeat(1)
{
 with instance_create(x,y,ConfettiBall)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 10;
  }
}

//confetti trail wooo
#define partyball_step
with instance_create(x+random_range(-5,5),y+random_range(-5,5),Confetti)
{
}

#define partyball_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_normal);