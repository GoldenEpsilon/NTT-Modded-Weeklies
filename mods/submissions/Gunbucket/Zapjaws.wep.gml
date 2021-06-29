#define init
global.sprRipJaws = sprite_add("sprites/sprZapjaws.png",1,4,5.5);
global.sprJawShank = sprite_add("sprites/sprlightningshank.png",2,-5,8);
global.sprRipJawsHud = sprite_add_weapon("sprites/hudsprites/sprzapjawshud.png",1,3.5,);

#define weapon_name
return "ZAPJAWS";

#define weapon_sprt
return global.sprRipJaws;

#define weapon_sprt_hud
return global.sprRipJawsHud;

#define weapon_type
return 0;

#define weapon_auto
return false;

#define weapon_load
return 32;

#define weapon_cost
return 0;

#define weapon_swap
return sndSwapHammer;

#define weapon_area
return 13;

#define weapon_melee
return 1

#define weapon_text
return "@(color:16745694)TASER TEETH";

#define weapon_fire
sound_play_pitchvol(sndHitMetal,random_range(0.1, 0.4),0.2)
sound_play_pitch(sndLightningHammer,random_range(.8,1.5))
sound_play_pitchvol(sndConfetti7,random_range(0.7,1.6),0.35)
sound_play(sndHammer)
weapon_post(8,25,15)
for (var i = -30; i <= 30; i += 10) {
    with instance_create(x + lengthdir_x(skill_get(13)* 20+sqrt(400-13*abs(i))-10, gunangle),y + lengthdir_y(skill_get(13)* 20+sqrt(400-13*abs(i))-10, gunangle),CustomSlash){
 

            sprite_index = global.sprJawShank;
            damage = 16;
            force = 8;
            motion_add(other.gunangle + (i * other.accuracy), 3 + (skill_get(13) * 2))
            image_speed=.2
            image_angle = direction
            candeflect = 0;
            projectile_init(other.team, (instance_is(other, FireCont) ? other.creator : other));
            lightningcharge=1+(skill_get(17));
            on_hit = script_ref_create(lshankhit);

    }
}          
wepangle = -wepangle
motion_add(gunangle,4)


#define lshankhit
var _team = team
var _ang = direction
with(other){
if nexthurt <= current_frame{
projectile_hit(self,other.damage,other.force)
  }
}
if (lightningcharge>0){
lightningcharge-=1;
with instance_create(x,y,Lightning)
{
  move_contact_solid(other.direction, 40);
  alarm0 = 1;
  ammo = 4;
  image_angle = other.direction + (random_range(-10, 10));
  damage= 7;
  team = other.team;
  creator = other
  with instance_create(x,y,LightningSpawn){
 image_angle = other.image_angle;
damage=other.damage;
	}
    }
}