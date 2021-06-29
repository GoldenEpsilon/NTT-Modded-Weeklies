//This can fire pretty much anything, this weapon will likely kill you
//there is almost definitely a way to organize/compress this better, but I dont know it so this file is over 1000 lines instead

#define init
//WORMHOLE SPRITES
global.sprite = sprite_add_weapon("sprites/sprUnstableWormholeGun.png",7,10)
global.sprWormholeGunHud = sprite_add("sprites/hudsprites/sprUnstableWormholeGunHud.png",1,1,3.5)
global.d = [true, true, true, true]

//Plasbouncer Sprites
global.mskPlasbouncer = sprite_add("sprites/mskPlasbouncer.png",0,12,12)
global.sprPlasbouncer = sprite_add("sprites/sprPlasbouncer.png",2,12,12)
global.sprPlasbounceImpact = sprite_add("sprites/sprPlasbounceImpact.png",7,16,16)
global.sprPlasbounceBulletHit = sprite_add("sprites/sprPlasbounceBulletHit.png",4,8,8)
global.sprPlasbounceTrail = sprite_add("sprites/sprPlasbounceTrail.png",3,4,4)
global.sprBigPlasbounceBall = sprite_add("sprites/sprPlasbounceBallBig.png",2,16,16)
global.mskBigPlasbounceBall = sprite_add("sprites/mskPlasbounceBallBig.png",0,16,16)
global.sprHugePlasbounceBall = sprite_add("sprites/sprPlasbounceBallHuge.png",2,24,24)
global.mskHugePlasbounceBall = sprite_add("sprites/mskPlasbounceBallHuge.png",0,24,24)

//Bouncesploder Sprites
global.mskBall = sprite_add("sprites/mskLargeCrystalBullet.png",0,12,12)
global.sprBouncesploderBall = sprite_add("sprites/sprBouncesploderBall.png",2,12,12)
global.sprPurpleExplosion = sprite_add("sprites/sprPurpleExplosion.png",9,24,24)
global.sprPurpleFire = sprite_add("sprites/sprPurpleFlame.png",8,4,6)
global.sprPurpleFireBig = sprite_add("sprites/sprPurpleFlameBig.png",8,6,8)

//Disc Nightmare
global.sprNightmareDisc = sprite_add("sprites/sprNightmareDisc.png",2,6,6)
global.sprDiscTrail = sprite_add("sprites/sprNightmareDiscTrail.png",2,4,4)

//Eliminator Missile
global.sprElimFlame = sprite_add("sprites/sprEliminatorMissleFlame.png",3,32,12);
global.sprEliminatorMissile = sprite_add("sprites/sprEliminatorMissile.png",1,6,8);

//Ultra Seeker
global.sprUltraSeeker = sprite_add("sprites/sprUltraSeeker.png",2,8,8)
global.sprUltraSeekerHit = sprite_add("sprites/sprUltraSeekerHit.png",4,0,0)

//Toxic Bubble
global.sprToxBubble = sprite_add("sprites/sprToxicBubble.png",1,6,6)
global.sprToxBubblePop = sprite_add("sprites/sprToxBubblePop.png",4,12,12)

//Super Party Ball
global.sprRainbowConfettiAnim = sprite_add("sprites/sprRainbowConfettiAnim.png",15,1,1)
global.sprRainbowConfettiLarge = sprite_add("sprites/sprRainbowConfettiLarge.png",15,1,1)
global.sprRainbowConfettiHuge = sprite_add("sprites/sprRainbowConfettiHuge.png",15,1,1)
global.mskConfettiBall = sprite_add("sprites/mskConfettiBall.png",0,-4,0.5)

#define weapon_name
return "UNSTABLE WORMHOLE";

#define weapon_sprt_hud
return global.sprWormholeGunHud;

#define weapon_sprt
return global.sprite;

#define weapon_type
return 5;

#define weapon_auto
return true;

#define weapon_load
return 30;

#define weapon_cost
return 5;

#define weapon_swap
return sndSwapEnergy;

#define weapon_area
return 21;

#define weapon_text
return "@(color:16745694)LIMITLESS POSSIBILITIES";

//Particle stuff
#define prt_create
	{
	with(instance_create(x, y, CustomObject))
		{
		direction = argument0
		sprite_index = sprLaserCharge
		image_angle = random(360)
		image_speed = 0.4
		speed = argument2
		time = argument1
		on_step = prtStep
		
		return self
		}
	}
	
#define step
	{
	var ws = current_time_scale * 4
	if(argument0)
		{
		if(wkick > 0)
			{wkick -= ws}
		if(speed && global.d[@index])
			{
			if(fork())
				{
				var i = index
				wait(5)
				if(instance_exists(self))
					{prt_create(random(360), 30, random(1))}
				global.d[@i] = true
				}
			else{
				global.d[@index] = false
				exit
				}
			}
		}
	else{
		if(bwkick > 0)
			{bwkick -= ws}
		}
	}

#define prtStep
	{
	if(time)
		{
		time -= current_time_scale
		exit
		}
	instance_destroy()
	}
	
	
	
//this is the weapon actually doing its thing
#define weapon_fire


score = choose(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50);

//regular bullet
repeat(30)
{
  if instance_exists(self)
  {
  	  if score = 1
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndMachinegun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Bullet1)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.2);
    }
  }
  }
}

//bouncer bullet
repeat(25)
{
  if instance_exists(self)
  {
  	  if score = 2
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndBouncerSmg);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),BouncerBullet)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 8;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.3);
    }
  }
  }
}

//Heavy Bullet
repeat(18)
{
  if instance_exists(self)
  {
  	  if score = 3
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHeavyMachinegun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HeavyBullet)
    {
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.3);
    }
  }
  }
}

//Ultra Bullet
repeat(12)
{
  if instance_exists(self)
  {
  	  if score = 4
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndUltraPistol);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),UltraBullet)
    {
      direction = other.gunangle + (random_range(15, -15) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.3);
    }
  }
  }
}

//Shells
repeat(18)
{
  if instance_exists(self)
  {
  	  if score = 5
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndDoubleShotgun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Bullet2)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Flame Shells
repeat(18)
{
  if instance_exists(self)
  {
  	  if score = 6
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndDoubleFireShotgun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),FlameShell)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Ultra Shells
repeat(10)
{
  if instance_exists(self)
  {
  	  if score = 7
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndUltraShotgun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),UltraShell)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Slug
repeat(8)
{
  if instance_exists(self)
  {
  	  if score = 8
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndSuperSlugger);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Slug)
    {
      direction = other.gunangle + (random_range(16, -16) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Heavy Slug
repeat(5)
{
  if instance_exists(self)
  {
  	  if score = 9
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHeavySlugger);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HeavySlug)
    {
      direction = other.gunangle + (random_range(16, -16) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Bolt
repeat(10)
{
  if instance_exists(self)
  {
  	  if score = 10
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndCrossbow);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Bolt)
    {
      direction = other.gunangle + (random_range(26, -26) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Heavy Bolt
repeat(6)
{
  if instance_exists(self)
  {
  	  if score = 11
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHeavyCrossbow);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HeavyBolt)
    {
      direction = other.gunangle + (random_range(16, -16) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Toxic Bolt
repeat(8)
{
  if instance_exists(self)
  {
  	  if score = 12
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndCrossbow);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),ToxicBolt)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Splinter
repeat(14)
{
  if instance_exists(self)
  {
  	  if score = 13
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndSplinterGun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Splinter)
    {
      direction = other.gunangle + (random_range(26, -26) * other.accuracy);
      speed = 13 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Ultra Bolt
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 14
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndUltraCrossbow);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),UltraBolt)
    {
      direction = other.gunangle + (random_range(6, -6) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Disc
repeat(16)
{
  if instance_exists(self)
  {
  	  if score = 15
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndDiscgun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Disc)
    {
      direction = other.gunangle + (random_range(16, -16) * other.accuracy);
      speed = 8;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//IDPD Bullet
repeat(20)
{
  if instance_exists(self)
  {
  	  if score = 16
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndRogueRifle);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),IDPDBullet)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.1);
    }
  }
  }
}

//IDPD Plasma
repeat(10)
{
  if instance_exists(self)
  {
  	  if score = 17
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndEliteShielderFire);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),PopoPlasmaBall)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(2);
    }
  }
  }
}

//Hyper Slug
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 18
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHyperSlugger);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HyperSlug)
    {
      direction = other.gunangle + (random_range(6, -6) * other.accuracy);
      speed = 8;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Flak Bullet
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 19
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndFlakCannon);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),FlakBullet)
    {
      direction = other.gunangle + (random_range(6, -6) * other.accuracy);
      speed = 12;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Super Flak Bullet
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 20
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndSuperFlakCannon);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),SuperFlakBullet)
    {
      direction = other.gunangle + (random_range(13, -13) * other.accuracy);
      speed = 12;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Plasma
repeat(18)
{
  if instance_exists(self)
  {
  	  if score = 21
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndPlasmaRifle);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),PlasmaBall)
    {
      direction = other.gunangle + (random_range(16, -16) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(2);
    }
  }
  }
}

//Plasma Big
repeat(2)
{
  if instance_exists(self)
  {
  	  if score = 22
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndPlasmaBig);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),PlasmaBig)
    {
      direction = other.gunangle + (random_range(12, -12) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Plasma Huge
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 23
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndPlasmaHuge);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),PlasmaHuge)
    {
      direction = other.gunangle + (random_range(2, -2) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Grenade
repeat(7)
{
  if instance_exists(self)
  {
  	  if score = 24
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndGrenade);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Grenade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 10 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Grenade
repeat(5)
{
  if instance_exists(self)
  {
  	  if score = 25
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHyperLauncher);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HyperGrenade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 4 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Nuke
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 26
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndNukeFire);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Nuke)
    {
      direction = other.gunangle + (random_range(2, -2) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//rocket
repeat(5)
{
  if instance_exists(self)
  {
  	  if score = 27
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndRocket);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Rocket)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 4 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Lightning Ball
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 28
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndLightningCannon);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),LightningBall)
    {
      direction = other.gunangle + (random_range(18, -18) * other.accuracy);
      speed = 12;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Seeker
repeat(7)
{
  if instance_exists(self)
  {
  	  if score = 29
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndSeekerShotgun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Seeker)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 12
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Blood Grenade
repeat(5)
{
  if instance_exists(self)
  {
  	  if score = 30
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndBloodLauncher);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),BloodGrenade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 4 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Blood Ball
repeat(2)
{
  if instance_exists(self)
  {
  	  if score = 31
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndBloodCannon);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),BloodBall)
    {
      direction = other.gunangle + (random_range(12, -12) * other.accuracy);
      speed = 4;
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Cluster Grenade
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 32
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndClusterLauncher);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),ClusterNade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 8 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Heavy Grenade
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 33
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndHeavyNader);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),HeavyNade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 8 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Toxic Grenade
repeat(5)
{
  if instance_exists(self)
  {
  	  if score = 34
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndToxicLauncher);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),ToxicGrenade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 8 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Flare
repeat(7)
{
  if instance_exists(self)
  {
  	  if score = 35
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndFlare);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Flare)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 6 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Flame Ball
repeat(2)
{
  if instance_exists(self)
  {
  	  if score = 36
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndFlameCannon);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),FlameBall)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 4 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Ultra Grenade
repeat(3)
{
  if instance_exists(self)
  {
  	  if score = 37
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndUltraGrenade);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),UltraGrenade)
    {
      direction = other.gunangle + (random_range(20, -20) * other.accuracy);
      speed = 12 + random_range(0,4);
      image_angle = direction;
      team = other.team;
      creator = other;
    }
  }
  }
}

//Confetti
repeat(25)
{
  if instance_exists(self)
  {
  	  if score = 38
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndConfettiGun);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),ConfettiBall)
    {
      direction = other.gunangle + (random_range(25, -25) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.2);
    }
  }
  }
}

//Devastator
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 39
  {
     	motion_add(gunangle,-0.5);
  	    weapon_post(3, -8, 8);
    sound_play(sndDevastator);
    with instance_create(x + lengthdir_x(5,gunangle),y + lengthdir_y(5,gunangle),Devastator)
    {
      direction = other.gunangle + (random_range(2, -2) * other.accuracy);
      speed = 16;
      image_angle = direction;
      team = other.team;
      creator = other;
        wait(0.2);
    }
  }
  }
}

//MODDED PROJECTILES PAST THIS POINT



//plasbouncer
repeat(10)
{
  if instance_exists(self)
  {
  	  	  if score = 40
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndBouncerSmg,0.7,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprPlasbouncer;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskPlasbouncer;
  speed = 16;
  friction = 0;
  direction = other.gunangle + (random_range(-16, 16) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "PLASBOUNCER"];
  damage = 4;
  typ = 1;

    on_wall = script_ref_create(plasbounce_wall);
  on_hit = script_ref_create(plasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(plasbounce_die);
     on_step = script_ref_create(plasbounce_step);
       on_anim = event
   }
wait(0.2);
	}
}
}

//big plasbouncer
repeat(2)
{
  if instance_exists(self)
  {
  	 	  	  if score = 41
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndPlasmaBig,0.7,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprBigPlasbounceBall;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskBigPlasbounceBall;
  speed = 9;
  friction = 0;
  direction = other.gunangle + (random_range(-2, 2) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "BIG PLASBOUNCER"];
  damage = 8;
  typ = 1;

    on_wall = script_ref_create(bigplasbounce_wall);
  on_hit = script_ref_create(plasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(bigplasbounce_die);
     on_step = script_ref_create(bigplasbounce_step);
       on_anim = event
   }

	}
}
}

//Huge Plasbouncer
repeat(1)
{
  if instance_exists(self)
  {
  	  	 	  	  if score = 42
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndPlasmaHuge,0.7,1);
  with instance_create(x + lengthdir_x(0,gunangle),y + lengthdir_y(0,gunangle),CustomProjectile)
{
  sprite_index = global.sprHugePlasbounceBall;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskHugePlasbounceBall;
  speed = 9;
  friction = 0;
  direction = other.gunangle + (random_range(-2, 2) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "HUGE PLASBOUNCER"];
  damage = 16;
  typ = 1;

    on_wall = script_ref_create(hugeplasbounce_wall);
  on_hit = script_ref_create(hugeplasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(hugeplasbounce_die);
     on_step = script_ref_create(hugeplasbounce_step);
       on_anim = event
   }

	}
}
}

//bouncesploder
repeat(1)
{
  if instance_exists(self)
  {
  	  	  	 	  	  if score = 43
  {
    weapon_post(6, -8, 8);
sound_play_pitchvol(sndBouncerSmg,0.7,1);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(10,gunangle),CustomProjectile)
{
  sprite_index = global.sprBouncesploderBall;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = global.mskBall;
  speed = 16;
  friction = 0;
  direction = other.gunangle + (random_range(-10, 10) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "BOUNCESPLODER"];
  damage = 10;
  typ = 1;
  bombtimer = 75;

    on_wall = script_ref_create(bouncesplode_wall);
  on_hit = script_ref_create(bouncesplode_hit);
   on_draw = script_ref_create(bouncesplode_draw);
     on_destroy = script_ref_create(bouncesplode_die);
     on_step = script_ref_create(bsplode_step);
       on_anim = event
   }

	}
}
}

//disc nightmare
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 44
  {
    weapon_post(6, -8, 8);
    sound_play(sndFlameCannon);
  with instance_create(x + lengthdir_x(10,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = global.sprNightmareDisc;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskDisc;
  speed = 5;
  friction = 0;
  direction = other.gunangle + (random_range(-1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "DISC NIGHTMARE"];
  damage = 50;
  force = 50;
  typ = 1;
    on_wall = script_ref_create(ndisc_wall);
  on_hit = script_ref_create(ndisc_hit);
  on_destroy = script_ref_create(ndisc_die);
  on_step = script_ref_create(ndisc_step);
    }
	}
}
}

//eliminator missile
{
  if instance_exists(self)
  {
  	  	  if score = 45
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
      
      on_draw = ElimMissileDraw;
      on_step = ElimMissileStep;
      on_destroy = ElimMissileDie;
      
    }
}
}
}

//IDPD Heavy Cannon
repeat(1)
{
  if instance_exists(self)
  {
  	  if score = 46
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
}

repeat(4)
{
  if instance_exists(self)
  {
  	  	  if score = 47
  {
  	sound_play_pitchvol(sndSeekerPistol,0.7,1);
sound_play_pitchvol(sndUltraCrossbow,1.2,1);
    with instance_create(x,y,CustomProjectile)
    {
      sprite_index = global.sprUltraSeeker;
      mask_index = mskSeeker;
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 9;
      image_angle = direction;
      damage = 18;
      team = other.team;
      creator = other;
      target=noone;
      angle=16;
      USeekerWallCount = 0;
      
      on_step = script_ref_create(UltraSeekerStep);
      on_wall = script_ref_create(UltraSeekerWall);
      on_destroy = script_ref_create(UltraSeekerDie);
      on_anim = muzzleflashevent;
    }
}
}
}

repeat(1)
{
  if instance_exists(self)
  {
  	  	  	  if score = 48
  {
    weapon_post(6, -8, 8);
    sound_play(sndVanWarning);
  with instance_create(x + lengthdir_x(45,gunangle),y + lengthdir_y(6,gunangle),CustomProjectile)
{
  sprite_index = sprVanDrive;
  image_xscale = 1;
  image_yscale = image_xscale;
  mask_index = mskVan;
  speed = 9;
  friction = 0;
  direction = other.gunangle + (random_range(1, 1) * other.accuracy);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "VAN LAUNCHED"];
  damage = 20;
  force = 50;
  typ = 1;
  bombtimer = 30;
    on_wall = script_ref_create(vandrill_wall);
  on_hit = script_ref_create(vandrill_hit);
  on_destroy = script_ref_create(vandrill_die);
   	on_step = script_ref_create(vanstep);
    }
	}
}
}

//toxbubble
repeat(10)
{
  if instance_exists(self)
  {
  	  	  	  	  if score = 49
  {
  	sound_play_pitchvol(sndOasisShoot,1,2);
sound_play(sndOasisHorn);
    with instance_create(x,y,CustomProjectile)
    {
      direction = other.gunangle + (random_range(10, -10) * other.accuracy);
      speed = 4 + random_range(0,2);
      friction = 0.05;
      image_angle = direction + random_range(0,4);
      image_xscale = 0.1 + random_range(1.3,0.7);
      image_yscale = image_xscale;
      team = other.team;
      creator = other;
      mask_index = mskDisc;
      sprite_index = global.sprToxBubble;
      toxbombtimer = 60;
      
      on_wall = ToxBubbleWall;
      on_destroy = ToxBubbleDie;
      on_step = ToxBubbleStep;
      on_draw = ToxBubbleDraw;
    }
}
wait(0.2);
}
}

//party!!!
repeat(1)
{
  if instance_exists(self)
  {
  	  	  	  	  	  if score = 50
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
}












//projectile define stuff

//plasbouncers
//huge ball go bwoosh
#define hugeplasbounce_die
repeat(1)
{
sound_play_pitchvol(sndPlasmaBigExplode,0.5,1);
  for (i = 0; i < 300; i += 80)
    with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprBigPlasbounceBall;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskBigPlasbounceBall;
  speed = 9;
  friction = 0;
  direction = other.direction + other.i + random_range(-20,20);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "BIG PLASBOUNCER"];
  damage = 8;
  typ = 1;

    on_wall = script_ref_create(bigplasbounce_wall);
  on_hit = script_ref_create(plasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(bigplasbounce_die);
     on_step = script_ref_create(bigplasbounce_step);
       on_anim = event
   }

	}

//makes huge plasbounce ball break a lot of walls
#define hugeplasbounce_wall
sound_play_pitchvol(sndBouncerBounce,0.5,1.5);

	image_xscale -= 0.04
	image_yscale = image_xscale;
	
	move_bounce_solid(true);
    with instance_create(x, y, BulletHit)
    {
  sprite_index = global.sprPlasbounceBulletHit;
    }
with(other){
instance_create(x,y,PortalClear);
}
#define hugeplasbounce_step

with instance_create(x+random_range(-25,25),y+random_range(-25,25),PlasmaTrail)
{
  sprite_index = global.sprPlasbounceTrail;
}
with instance_create(x+random_range(-25,25),y+random_range(-25,25),PlasmaTrail)
{
  sprite_index = global.sprPlasbounceTrail;
}

if image_xscale < 0.65 instance_destroy();

#define hugeplasbounce_hit

projectile_hit(other,damage,force);

image_xscale -= 0.05;
image_yscale -= 0.05;
x -= lengthdir_x(speed * 1,direction);
y -= lengthdir_y(speed * 1,direction);
	
         with instance_create(x,y,BulletHit)
  {
   sprite_index = global.sprPlasbounceBulletHit;
  };


//big ball explode woooo
#define bigplasbounce_die
repeat(1)
{
sound_play_pitchvol(sndPlasmaBigExplode,0.5,1);
  for (i = 0; i < 300; i += 32)
    with instance_create(x,y,CustomProjectile)
{
  sprite_index = global.sprPlasbouncer;
  image_xscale = 1 + (skill_get(17) * 0.2);
  image_yscale = image_xscale;
  mask_index = global.mskPlasbouncer;
  speed = 16;
  friction = 0;
  direction = other.direction + other.i + random_range(-20,20);
  image_angle = direction;
  team = other.team;
  creator = other;
  hitid = [sprite_index, "PLASBOUNCER"];
  damage = 4;
  typ = 1;

    on_wall = script_ref_create(plasbounce_wall);
  on_hit = script_ref_create(plasbounce_hit);
   on_draw = script_ref_create(plasbounce_draw);
     on_destroy = script_ref_create(plasbounce_die);
     on_step = script_ref_create(plasbounce_step);
       on_anim = event
   }

	}



//makes big plasbounce ball break walls
#define bigplasbounce_wall
sound_play_pitchvol(sndBouncerBounce,0.5,1.5);

	image_xscale -= 0.04
	image_yscale = image_xscale;
	
	move_bounce_solid(true);
    with instance_create(x, y, BulletHit)
    {
  sprite_index = global.sprPlasbounceBulletHit;
    }
with instance_create(x,y,PortalClear)
{
	image_xscale = 0.7;
	image_yscale = image_xscale;
}

#define bigplasbounce_step

with instance_create(x+random_range(-15,15),y+random_range(-15,15),PlasmaTrail)
{
  sprite_index = global.sprPlasbounceTrail;
}

if image_xscale < 0.65 instance_destroy();


//small plasbouncer stuff

//makes the projectile bounce when it hits a wall
#define plasbounce_wall

sound_play_pitchvol(sndBouncerBounce,0.7,1);

	image_xscale -= 0.03
	image_yscale = image_xscale;
	
	move_bounce_solid(true);
    with instance_create(x, y, BulletHit)
    {
  sprite_index = global.sprPlasbounceBulletHit;
    }
  
//makes the projectile actually do damage and have bullethit effect
#define plasbounce_hit

projectile_hit(other,damage,force);

image_xscale -= 0.1;
image_yscale -= 0.1;
x -= lengthdir_x(speed * 1,direction);
y -= lengthdir_y(speed * 1,direction);
	
         with instance_create(x,y,BulletHit)
  {
   sprite_index = global.sprPlasbounceBulletHit;
  };


//gives the projectile its glow and transparency
#define plasbounce_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//makes a particle effect when the projectile dissapears    
#define plasbounce_die

sound_play_pitchvol(sndPlasmaHit,0.7,1);
         with instance_create(x,y,PlasmaImpact)
  {
   sprite_index = global.sprPlasbounceImpact;
  };
  
#define event
  image_speed = 0;
    image_index = image_number - 1
    
#define plasbounce_step

with instance_create(x+random_range(-5,5),y+random_range(-5,5),PlasmaTrail)
{
  sprite_index = global.sprPlasbounceTrail;
}

if image_xscale < 0.5 instance_destroy();

//Bouncesploder



//makes the projectile die when it hits a wall
#define bouncesplode_wall

sound_play_pitchvol(sndBouncerBounce,0.3,2);
	move_bounce_solid(true);
    with instance_create(x, y, Explosion)
    {
  sprite_index = global.sprPurpleExplosion;
    }
  
//makes the projectile actually do damage and have bullethit effect
#define bouncesplode_hit

projectile_hit(other,damage);
         with instance_create(x,y,Explosion)
  {
   sprite_index = global.sprPurpleExplosion;
  };


//gives the projectile its glow and transparency
#define bouncesplode_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.7*image_xscale, 1.7*image_yscale, image_angle, image_blend, 0.2);
draw_set_blend_mode(bm_normal);

//makes a particle effect when the projectile dissapears    
#define bouncesplode_die

sound_play_pitchvol(sndExplosion,0.7,1);
         with instance_create(x,y,Explosion)
  {
   sprite_index = global.sprPurpleExplosion;
  };
  
    
#define bsplode_step

with instance_create(x+random_range(-7,7),y+random_range(-7,7),PlasmaTrail)
{
  sprite_index = global.sprPurpleFire;
}
with instance_create(x+random_range(-7,7),y+random_range(-7,7),PlasmaTrail)
{
  sprite_index = global.sprPurpleFireBig;
}

bombtimer -= 1;
if bombtimer < 1 instance_destroy();

//Nightmare Disc
#define ndisc_wall
instance_destroy();

#define ndisc_hit
projectile_hit(other,damage,force);
instance_destroy();

#define ndisc_die
sound_play(sndExplosionS);
for (i = 0; i < 360; i += 3)
repeat(1)
{
 with instance_create(x,y,Disc)
  {
    team = other.team;
    creator = other.creator;
    direction = other.direction + other.i + random_range(-1,1);
    speed = 15;
  }
}

#define ndisc_step

with instance_create(x+random_range(-3,3),y+random_range(-3,3),PlasmaTrail)
{
  sprite_index = global.sprDiscTrail;
}

//Eliminator Missile
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

#define UltraSeekerWall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}
USeekerWallCount +=1;

#define UltraSeekerHit
instance_destroy();

#define UltraSeekerDie
    sound_play(sndSeekerPistol);
         with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprUltraSeekerHit;
  }

#define UltraSeekerStep

image_angle = direction;
if target = noone && instance_exists(enemy){
	var nearest = enemy;
	if distance_to_object(nearest) < 100{
	with enemy if point_distance(other.x, other.y, x, y) < point_distance(other.x, other.y, nearest.x, nearest.y)
	&& !collision_line(other.x, other.y, x, y, Wall, 0, 0) nearest = self;
	if !collision_line(x, y, nearest.x, nearest.y, Wall, 0, 0) target = nearest;
}
}
angle += 0.1 * current_time_scale;
if instance_exists(target) direction += clamp(angle_difference(point_direction(x, y, target.x, target.y), direction), -angle, angle) * (0.4 + (skill_get(21) * 0.3));
with(instance_create(x, y, BoltTrail)) {
	sprite_index = sprUltraBoltTrail;
     image_angle = other.direction;
     image_xscale = other.speed;
     image_yscale = 1.5;
}

if USeekerWallCount > 1 instance_destroy();

#define muzzleflashevent
  image_speed = 0;
    image_index = image_number - 1
    
    
//van    
#define vandrill_wall
with(other){
  instance_create(x, y, FloorExplo);
  instance_destroy();
}

#define vandrill_hit
projectile_hit(other,damage,force);

#define vanstep
with instance_create(x+random_range(-20,20),y+random_range(-20,20),BlueFlame)
{
  sprite_index = sprBlueFlameBig;
}
bombtimer -= 1;
if bombtimer < 1 || place_meeting(x,y,Explosion) || place_meeting(x,y,PopoExplosion) instance_destroy();

#define vandrill_die
sound_play(sndExplosionCar);
for (i = 0; i < 1; i += 1)
repeat(3)
{
 with instance_create(x + random_range(-10,10),y + random_range(-10,10),PopoExplosion)
  {
    direction = other.direction + other.i + random_range(-10,10);
    speed = 1;
  }
}

//Tox Bubble
#define ToxBubbleWall
	move_bounce_solid(true);
	
#define ToxBubbleStep
toxbombtimer -= 1;
if toxbombtimer < 1 instance_destroy();

#define ToxBubbleDie
  with instance_create(x,y,BulletHit)
  {
    sprite_index = global.sprToxBubblePop;
  }
sound_play(sndToxicBarrelGas);
for (i = 0; i < 360; i += 28)
{
 with instance_create(x,y,ToxicGas)
  {
    direction = other.direction + other.i + random_range(-65,65);
    speed = 1 + random_range(0,1);
  }
}

#define ToxBubbleDraw
image_angle += (speed * 0.7);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.6*image_xscale, 1.6*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

//party!!
#define partyball_wall
instance_destroy();

#define partyball_hit
projectile_hit(other,damage,force);
instance_destroy();

//makes the little party balls
#define partyball_die
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