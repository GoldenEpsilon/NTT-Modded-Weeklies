//spears are meant to be longer-range higher dps melees, but with much lower protection against projectiles and such
//yokin should me i've been doing lengthdir wrong this whole time, oops!
//good base for spear-type melee weps
//funny evangelion

#define init
global.sprite = sprite_add_weapon("sprites/sprLonginusSpear.png",15,5)
global.sprLonginusSpearHud = sprite_add_weapon("sprites/hudsprites/sprLonginusSpearHud.png",1,3.5,);
global.sprLonginusShank = sprite_add("sprites/sprLonginusShank.png",2,-5,8)
global.mskLonginusShank = sprite_add("sprites/mskLonginusShank.png",2,-5,8)
global.sprATField = sprite_add("sprites/sprLonginusATField.png",6,16,16)

#define weapon_name
return "SPEAR OF LONGINUS";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprLonginusSpearHud;

#define weapon_type
return 0;

#define weapon_melee
return false;

#define weapon_auto
return false;

#define weapon_load
return 55;

#define weapon_cost
return 0;

#define weapon_swap
return sndSwapSword;

#define weapon_area
return 20;

#define weapon_text
return "@(color:16745694)IT ALL COMES TUMBLING DOWN";

#define weapon_fire

repeat(1)
{
  if instance_exists(self)
  {
    weapon_post(-24, -8, 8);
    sound_play_pitchvol(sndScrewdriver,0.7,1);
    sound_play_pitchvol(sndUltraPistol,0.7,0.7);
    motion_add(gunangle, 2.5);
  with instance_create(x+lengthdir_x(25,gunangle),y+lengthdir_y(25,gunangle),CustomSlash)
    {
      direction = other.gunangle + (random_range(1, -1) * other.accuracy);
      image_xscale = 1;
      image_yscale = image_xscale;
      sprite_index = global.sprLonginusShank
      image_speed = 0.35;
      speed = 1.7 * (skill_get(13) * 5);
      image_angle = direction;
      damage = 35
      candeflect=false;
      team = other.team;
      creator = other;
      on_draw = script_ref_create(longshank_draw);
      on_hit = longshank_hit;
    }
}
}

#define longshank_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}

with instance_create(x + random_range(4, -4),y + random_range(4, -4),MeatExplosion)
{
    sprite_index = global.sprATField;
}


#define longshank_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.99);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);