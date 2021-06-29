//this might become more powerful than the SPC if you loop far enough
//borrowed some stuff from IGotGunz's Delta Plasma to get plasma working

#define init
global.sprite = sprite_add_weapon("sprites/sprEvolverPlasmaCannon.png",6,6)
global.sprplasma = sprite_add("sprites/sprEvolvePlasmaBall.png", 2, 12, 12);
global.sprplasmabig = sprite_add("sprites/sprEvolvePlasmaBallBig.png", 2, 16, 16);
global.sprplasmaexplo = sprite_add("sprites/sprEvolvePlasmaImpact.png", 7, 16, 16);
global.sprtrail = sprite_add("sprites/sprEvolvePlasmaTrail.png", 3, 4, 4);
global.sprEvolverPlasmaCannonHud = sprite_add("sprites/hudsprites/sprEvolverPlasmaCannonHud.png",1,1,3.5)

#define weapon_name
return "EVOLVER PLASMA CANNON";

#define weapon_sprt_hud(_wep)
     // Normal Outline:
    if(
        weapon_get_gold(_wep) != 0 ||
        weapon_get_rads(_wep) > 0  ||
        (instance_is(self, Player) && ((wep == _wep && curse > 0) || (bwep == _wep && bcurse > 0)))
    ){
        return global.sprite;
    }
    
     // Red Outline:
    return global.sprEvolverPlasmaCannonHud;

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return false;

#define weapon_load
return 100 + GameCont.hard * 2;

#define weapon_cost
return 30;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 18;

#define weapon_text
return "@(color:16745694)GROW! GROW! GROW!";

#define weapon_fire

repeat(1 + GameCont.hard/15)
{
  if instance_exists(self)
    weapon_post(4, -5, 5);
    sound_play(sndPlasmaBig);
    with instance_create(x,y,CustomProjectile)
    {
  		sprite_index = global.sprplasmabig;
  		mask_index = mskPlasma;
      team = other.team;
  		damage = 5;
  		force = 6;
  		image_xscale = 1 + (skill_get(17) * 0.3);
  		image_yscale = image_xscale;
  		image_index = 1;
  		image_speed = 0;
      direction = other.gunangle + (random_range(-3,3) * other.accuracy);
      speed = 7;
      typ = 1;
      creator = other;
      image_angle = direction;
      on_hit = script_ref_create(plasma_hit);
      on_step = script_ref_create(plasma_step);
      on_wall = script_ref_create(plasma_wall);
      on_draw = script_ref_create(plasma_draw);
      on_destroy = script_ref_create(bigplasma_destroy);
    }
  wait(2);
}
#define plasma_step
with instance_create(x+random_range(-4,4),y+random_range(-4,4),PlasmaTrail)
{
  sprite_index = global.sprtrail;
}
if speed < 8 speed += 0.05;
if image_xscale < 0.5 instance_destroy();

#define plasma_hit
projectile_hit(other,damage,force);
image_xscale -= 0.1;
image_yscale -= 0.1;
x -= lengthdir_x(speed * 1,direction);
y -= lengthdir_y(speed * 1,direction);

#define plasma_wall
	image_xscale -= 0.05
	image_yscale = image_xscale;
	if image_xscale <= 0.75{
		instance_destroy();
		exit;
	}

#define plasma_destroy
sound_play(sndPlasmaHit);
with instance_create(x,y,PlasmaImpact)
{
  team = other.team;
  sprite_index = global.sprplasmaexplo;
}

#define plasma_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

#define bigplasma_destroy
sound_play(sndPlasmaBigExplode);
repeat(1)
instance_create(x,y,PortalClear);
{
for (i = 0; i < 300; i += 32)
    with instance_create(x,y,CustomProjectile)
    {
  		sprite_index = global.sprplasma;
  		mask_index = mskPlasma;
      team = other.team;
  		damage = 5;
  		force = 6;
  		image_xscale = 1 + (skill_get(17) * 0.3);
  		image_yscale = image_xscale;
  		image_index = 1;
  		image_speed = 0;
    direction = other.direction + other.i + random_range(-20,20);
      speed = 7;
      typ = 1;
      creator = other;
      image_angle = direction;
      on_hit = script_ref_create(plasma_hit);
      on_step = script_ref_create(plasma_step);
      on_wall = script_ref_create(plasma_wall);
      on_draw = script_ref_create(plasma_draw);
      on_destroy = script_ref_create(plasma_destroy);
    }
}