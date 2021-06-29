//IM A PIRATE LEGEND!!!!!!!!!!!!!!!!

#define init
global.sprite = sprite_add_weapon("sprites/sprGhostCutlass.png",4,6)
global.sprEctoSlash = sprite_add("sprites/sprEctoSlash.png",3,0,24)
global.sprGhostCutlassHud = sprite_add_weapon("sprites/hudsprites/sprGhostCutlassHud.png",1,3.5,);

#define weapon_name
return "GHOST CUTLASS";

#define weapon_sprt
return global.sprite;

#define weapon_sprt_hud
return global.sprGhostCutlassHud;


#define weapon_type
return 0;

#define weapon_melee
return true;

#define weapon_auto
return false;

#define weapon_load
return 40;

#define weapon_cost
return 1;

#define weapon_swap
return sndSwapSword;

#define weapon_area
return 9;

#define weapon_text
return "@(color:16745694)YARRR!";

#define weapon_fire

sound_play(sndScrewdriver);
weapon_post(0, 4, 12);
  with instance_create(x+lengthdir_x(0,gunangle),y+lengthdir_y(0,gunangle),Slash)
  {
    direction = other.gunangle;
            speed = 1.3 * (skill_get(13) * 5);
      image_angle = direction;
      team = other.team;
      creator = other;
          damage = 16;
      
    }
            wepangle = -wepangle;
motion_add(gunangle, 3.5);
      wait(4.5);
sound_play_pitchvol(sndBloodLauncher,0.8,1);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomSlash)
    {
              sprite_index = global.sprEctoSlash;
      direction = other.gunangle
      image_xscale = 1;
      image_yscale = image_xscale;
      image_speed = 0.4;
      speed = 1.5 * (skill_get(13) + 2.5);
      image_angle = direction;
      damage = 12
      team = other.team;
      creator = other;
      on_draw = script_ref_create(ghostprojectile_draw);
      on_hit = script_ref_create(ghostsword_hit);
    }

    
#define ghostprojectile_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.5);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

#define ghostsword_hit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}