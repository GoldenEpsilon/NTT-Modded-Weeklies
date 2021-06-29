// B L O O N 

#define init
global.sprite = sprite_add_weapon("sprites/sprEliminatorLauncher.png",4,9)
global.sprElimFlame = sprite_add("sprites/sprEliminatorMissleFlame.png",3,32,12);
global.sprEliminatorMissile = sprite_add("sprites/sprEliminatorMissile.png",1,6,8);
global.sprEliminatorMissileHud = sprite_add_weapon("sprites/hudsprites/sprEliminatorMissileHud.png",1,4,);

#define weapon_name
return "ELIMINATOR LAUNCHER";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprEliminatorMissileHud;

#define weapon_type
return 4;

#define weapon_auto
return false;

#define weapon_load
return 44;

#define weapon_cost
return 3;

#define weapon_swap
return sndSwapExplosive;

#define weapon_area
return 11;

#define weapon_text
return "@(color:16745694)NO MORE MOABS";

#define weapon_fire

{
  if instance_exists(self)
  {
    weapon_post(6, -8, 8);
    sound_play(sndNukeFire);
    with instance_create(x,y,CustomProjectile)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      speed = 11;
      image_angle = direction;
      team = other.team;
      creator = other;
      mask_index = mskNuke;
      sprite_index = global.sprEliminatorMissile;
      image_yscale = other.right
      
      on_draw = ElimMissileDraw;
      on_step = ElimMissileStep;
      on_destroy = ElimMissileDie;
      
    }
}
}

#define ElimMissileDie
sound_play(sndNukeExplosion);
for (i = 0; i < 360; i += 56)
{
 instance_create(x,y,GreenExplosion)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
  }
}

#define ElimMissileStep
{
  instance_create(x+random_range(-1,1),y+random_range(-1,1),Smoke);
}

#define ElimMissileDraw
{
	draw_sprite_ext(global.sprElimFlame, -1, x - lengthdir_x(0,image_angle), y - lengthdir_y(0,image_angle), 1, 1.2, image_angle, c_white, image_alpha);
	draw_set_blend_mode(bm_add);
	draw_sprite_ext(global.sprElimFlame, 0, x, y, 1.8 * image_xscale, 1.8 * image_yscale, image_angle, c_white, 0.2);
}
draw_set_blend_mode(bm_normal);
draw_self();