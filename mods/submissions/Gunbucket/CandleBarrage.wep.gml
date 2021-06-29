//roman candles are awesome

#define init
global.sprite = sprite_add_weapon("sprites/sprCandleBarrage.png",9,7)
global.sprCandleSmoke = sprite_add("sprites/sprCandleSmoke.png",5,12,12)
global.sprCandleTrail = sprite_add("sprites/sprCandleTrail.png",3,4,4)
//Blue
global.sprCFireBlue = sprite_add("sprites/sprCandleFireBlue.png",7,8,8)
global.sprCHitBlue = sprite_add("sprites/sprCandleHitBlue.png",4,8,8)
global.sprCandleBlue = sprite_add("sprites/sprCandleBlue.png",3,26,6)
//Purple
global.sprCFirePurple = sprite_add("sprites/sprCandleFirePurple.png",7,8,8)
global.sprCHitPurple = sprite_add("sprites/sprCandleHitPurple.png",4,8,8)
global.sprCandlePurple = sprite_add("sprites/sprCandlePurple.png",3,26,6)
//Green
global.sprCFireGreen = sprite_add("sprites/sprCandleFireGreen.png",7,8,8)
global.sprCHitGreen = sprite_add("sprites/sprCandleHitGreen.png",4,8,8)
global.sprCandleGreen = sprite_add("sprites/sprCandleGreen.png",3,26,6)
//Yellow
global.sprCFireYellow = sprite_add("sprites/sprCandleFireYellow.png",7,8,8)
global.sprCHitYellow = sprite_add("sprites/sprCandleHitYellow.png",4,8,8)
global.sprCandleYellow = sprite_add("sprites/sprCandleYellow.png",3,26,6)
//Red
global.sprCFireRed = sprite_add("sprites/sprCandleFireRed.png",7,8,8)
global.sprCHitRed = sprite_add("sprites/sprCandleHitRed.png",4,8,8)
global.sprCandleRed = sprite_add("sprites/sprCandleRed.png",3,26,6)
#define weapon_name
return "CANDLE BARRAGE";

#define weapon_sprt
return global.sprite;

#define weapon_type
return 4;

#define weapon_auto
return true;

#define weapon_load
return 8;

#define weapon_cost
return 2;

#define weapon_swap
return sndSwapFlame;

#define weapon_area
return 14;

#define weapon_text
return "@(color:16745694)BE NICE TO IT";

#define weapon_fire

{
  if instance_exists(self)
  {
repeat(5){
score = choose(1,2,3,4,5)

//Blue Candle

{if score = 1
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprCandleBlue
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
       speed = 11 + irandom(2);
        damage = 9;
      image_speed = 0.5;
      image_angle = direction;
      team = other.team;
      creator = other;
      typ = 1;
      on_hit = script_ref_create(CandleHit);
      on_draw = script_ref_create(CandleDraw);
      on_step = script_ref_create(CandleStep);
      on_wall = script_ref_create(CandleWall);
      on_destroy = script_ref_create(CandleDieBlue);
      
    }
}
}
}

//Purple Candle
{if score = 2
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprCandlePurple
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
       speed = 11 + irandom(2);
        damage = 9;
      image_speed = 0.5;
      image_angle = direction;
      team = other.team;
      creator = other;
      typ = 1;
      on_hit = script_ref_create(CandleHit);
      on_draw = script_ref_create(CandleDraw);
      on_step = script_ref_create(CandleStep);
      on_wall = script_ref_create(CandleWall);
      on_destroy = script_ref_create(CandleDiePurple);
      
    }
}
}
}
//Green Candle
{if score = 3
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprCandleGreen
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
       speed = 11 + irandom(2);
        damage = 9;
      image_speed = 0.5;
      image_angle = direction;
      team = other.team;
      creator = other;
      typ = 1;
      on_hit = script_ref_create(CandleHit);
      on_draw = script_ref_create(CandleDraw);
      on_step = script_ref_create(CandleStep);
      on_wall = script_ref_create(CandleWall);
      on_destroy = script_ref_create(CandleDieGreen);
      
    }
}
}
}
//Yellow Candle
{if score = 4
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprCandleYellow
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
       speed = 11 + irandom(2);
        damage = 9;
      image_speed = 0.5;
      image_angle = direction;
      team = other.team;
      creator = other;
      typ = 1;
      on_hit = script_ref_create(CandleHit);
      on_draw = script_ref_create(CandleDraw);
      on_step = script_ref_create(CandleStep);
      on_wall = script_ref_create(CandleWall);
      on_destroy = script_ref_create(CandleDieYellow);
      
    }
}
}
}
//Red Candle
{if score = 5
{
  if instance_exists(self)
  {
    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
  with instance_create(x+lengthdir_x(15,gunangle),y+lengthdir_y(15,gunangle),CustomProjectile)
    {
      sprite_index = global.sprCandleRed
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
       speed = 11 + irandom(2);
      damage = 9;
      image_speed = 0.5;
      image_angle = direction;
      team = other.team;
      creator = other;
      typ = 1;
      on_hit = script_ref_create(CandleHit);
      on_draw = script_ref_create(CandleDraw);
      on_step = script_ref_create(CandleStep);
      on_wall = script_ref_create(CandleWall);
      on_destroy = script_ref_create(CandleDieRed);
      
    }
}
}
}
}
}




wait(0.8);
}
#define CandleHit
projectile_hit(other, damage)
instance_destroy();

#define CandleWall
instance_destroy();

#define CandleStep

  with instance_create(x+random_range(-1,1),y+random_range(-1,1),Smoke){
  	sprite_index = global.sprCandleSmoke
  	image_xscale = 0.5;
  	image_yscale = image_xscale;
  }
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprCandleTrail
  }
  with instance_create(x+random_range(-1,1),y+random_range(-1,1),PlasmaTrail){
  	sprite_index = global.sprCandleTrail
  }

#define CandleDraw
//need dis for da glow
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

//these are all the same but with different colors
#define CandleDieBlue
    sound_play_pitchvol(sndExplosionS,1,1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
	with instance_create(x,y,BulletHit){
		sprite_index = global.sprCHitBlue}
		
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,Flame)
  {
  	sprite_index = global.sprCFireBlue
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 4;
  }
}


#define CandleDiePurple
    sound_play_pitchvol(sndExplosionS,1,1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
	with instance_create(x,y,BulletHit){
		sprite_index = global.sprCHitPurple}
		
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,Flame)
  {
  	sprite_index = global.sprCFirePurple
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 4;
  }
}


#define CandleDieGreen
    sound_play_pitchvol(sndExplosionS,1,1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
	with instance_create(x,y,BulletHit){
		sprite_index = global.sprCHitGreen}
		
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,Flame)
  {
  	sprite_index = global.sprCFireGreen
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 4;
  }
}

#define CandleDieYellow
    sound_play_pitchvol(sndExplosionS,1,1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
	with instance_create(x,y,BulletHit){
		sprite_index = global.sprCHitYellow}
		
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,Flame)
  {
  	sprite_index = global.sprCFireYellow
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 4;
  }
}

#define CandleDieRed
    sound_play_pitchvol(sndExplosionS,1,1.5);
sound_play (asset_get_index("sndConfetti" + string(irandom_range(1, 9))))
	with instance_create(x,y,BulletHit){
		sprite_index = global.sprCHitRed}
		
for (i = 0; i < 360; i += 32)
repeat(1)
{
 with instance_create(x,y,Flame)
  {
  	sprite_index = global.sprCFireRed
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 4;
  }
}