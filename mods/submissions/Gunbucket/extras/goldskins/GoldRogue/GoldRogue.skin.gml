#define init
global.spr_idle = sprite_add("idle.png", 10, 12, 12);
global.spr_walk = sprite_add("walk.png", 6, 12, 12);
global.spr_hurt = sprite_add("hurt.png", 3, 12, 12);
global.spr_dead = sprite_add("dead.png", 6, 12, 12);
global.spr_sit1 = sprite_add("sit1.png", 3, 12, 12);
global.spr_sit2 = sprite_add("sit2.png", 1, 12, 12);
global.mapicon  = sprite_add("mapicon.png", 1, 10, 10);
global.loadout  = sprite_add("loadout.png", 1, 16, 16);
global.portrait = sprite_add("portrait.png", 1, 40, 243);
// You can add additional sprites here the same way via sprite_add,
// first argument is path to image, second is number of frames to split in (horizontally),
// third and fourth are X and Y offset for origin (rotation center).
with (instances_matching(Player, "bskin", mod_current)) scr_sprites();

#define skin_name
return "GOLD ROGUE";

#define skin_race
return 12/* rogue */;

#define scr_sprites
spr_idle = global.spr_idle;
spr_walk = global.spr_walk;
spr_hurt = global.spr_hurt;
spr_dead = global.spr_dead;
spr_sit1 = global.spr_sit1;
spr_sit2 = global.spr_sit2;

#define skin_sprite(q)
switch (q) {
	// You can replace character-specific sprites here, e.g.:
	// case sprMutant9HeadlessIdle: return global.spr_idle;
	// sprite names can be found via http://yal.cc/r/17/ntt/sprites/
	default: return -1;
}

#define create
scr_sprites();

#define skin_button
sprite_index = global.loadout;

#define skin_portrait
return global.portrait;

#define skin_mapicon
return global.mapicon;
