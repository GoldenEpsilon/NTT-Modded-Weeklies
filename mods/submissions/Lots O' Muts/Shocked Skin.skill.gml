#define init
global.sprButton = sprite_add("Sprites/Main/Shocked Skin.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Shocked Skin Icon.png", 1, 8, 8)
global.sprShellShock = sprite_add("Sprites/ShellShock.png", 3, 12, 12)

#define skill_name
	return "Shocked Skin";
	
#define skill_text
	return "@wShells@s burst#on @wImpact@s";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;
	
#define skill_wepspec
	return 1;

#define skill_tip
	return "Shock absorption";
	
#define skill_take
	sound_play(sndMutTriggerFingers)
	
#define step
script_bind_step(custom_step, -1);
#define custom_step
instance_destroy();

with(Player){
	with(instances_matching([Bullet2, FlameShell, HeavySlug, UltraShell, Slug], "team", team)){
		if(array_length(instance_rectangle_bbox(bbox_left+hspeed, bbox_top+vspeed, bbox_right+hspeed, bbox_bottom+vspeed, instances_matching_ne(hitme, "team", team)))){
			with(instance_create(x+hspeed,y+vspeed,CustomProjectile)){
				duplicators = true;
				damage = skill_get(mod_current);
				timer = 12;
				team = other.team;
				direction = other.direction;
				force = 2;
				image_speed = 0.2;
				speed = 0;
				sprite_index = global.sprShellShock;
				hitid = [sprite_index, "Shell Shock"];
				mask_index = mskSmallExplosion;
				on_wall = shockWall;
				on_hit = shockHit;
				on_step = shockStep;
			}
		}
	}
}
with(instances_matching_ne(CustomProjectile, "ShockedSkin", 1)){
	ShockedSkin = 1;
	if("name" in self && is_string(name) && (string_count("shell", string_lower(name)) > 0 || string_count("slug", string_lower(name)) > 0)){
		ShockedSkin = 0;
		if(array_length(instance_rectangle_bbox(bbox_left+hspeed, bbox_top+vspeed, bbox_right+hspeed, bbox_bottom+vspeed, instances_matching_ne(hitme, "team", team)))){
			with(instance_create(x+hspeed,y+vspeed,CustomProjectile)){
				duplicators = true;
				damage = skill_get(mod_current);
				timer = 12;
				team = other.team;
				direction = other.direction;
				force = 2;
				image_speed = 0.2;
				speed = 0;
				sprite_index = global.sprShellShock;
				hitid = [sprite_index, "Shell Shock"];
				mask_index = mskSmallExplosion;
				on_wall = shockWall;
				on_hit = shockHit;
				on_step = shockStep;
			}
		}
	}
}

#define shockWall
#define shockHit
projectile_hit(other, damage, force, direction);
with(other){move_contact_solid(other.direction, other.force);}
#define shockStep
timer--;
if(timer < 0 && instance_exists(self)){
	instance_destroy();
}

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing "place_meeting()" with every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);