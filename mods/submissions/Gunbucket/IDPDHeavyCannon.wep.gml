
//recreation of Captain's big balls (LastBall)
//she has massive balls

#define init
global.sprite = sprite_add_weapon("sprites/sprPopoHeavyCannon.png",5,5)

#define weapon_name
return "BULLORB CANNON";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 70;

#define weapon_cost
return 8;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 15;

#define weapon_text
return "@(color:16745694)POWERFUL ORBS";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndNothing2Ball);
    with instance_create(x,y,CustomProjectile){
    {
      sprite_index = sprLastBall;
      mask_index = mskExploder;
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 7;
      damage = 40;
      image_angle = direction;
      image_speed = 0.3;
      team = other.team;
      creator = other;
      ballhitcount = 0;
      typ = 1;
            on_hit = script_ref_create(capsbigballs_hit);
    	    on_draw = script_ref_create(capsbigballs_draw);
    		on_destroy = script_ref_create(capsbigballs_die);
    		on_wall = script_ref_create(capsbigballs_wall);
    		on_step = script_ref_create(capsbigballs_step);
    } } } }
    
#define capsbigballs_step
if ballhitcount > 2 instance_destroy();

    
//this is a recreation of the LastBall projectile's explosion
//there is DEFINITELY a better way to do this, but fuck you
#define capsbigballs_die
sound_play(sndExplosionS);
with instance_create(x,y,PlasmaImpact)
{
	sprite_index = sprPopoPlasmaImpact;
}

repeat(1)
{
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 12;
  } } } 
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 11;
  } } 
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 10;
  } } 
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 9;
  } }  
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 8;
  } }  
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 7;
  } } 
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 6;
  } } 
for (i = 0; i < 360; i += 32)
{
 with instance_create(x,y,IDPDBullet)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i;
    image_angle = direction;
    speed = 5;
  } } 

  
//makes projectile hit enemy then be destroyed    
#define capsbigballs_hit
projectile_hit(other, damage)
ballhitcount +=1;

//makes projectile be destroyed when hitting wall
#define capsbigballs_wall
instance_create(x,y,PortalClear)
instance_destroy();

//need dis for da glow
#define capsbigballs_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);
