#define init
global.sprButton = sprite_add("Sprites/Main/Compressing Fist.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Compressing Fist Icon.png", 1, 8, 8)

#define skill_name
	return "Compressing Fist";
	
#define skill_text
	return "1.5x @wammo usage@s,#1.5x @wdamage@s";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;

#define skill_tip
	return "Fused ammo is surprisingly effective";
	
#define skill_take
	sound_play(sndMutHammerhead);
	
#define step
with(Player){
	compOldAmmo = [];
	for(var i = 0; i < array_length(ammo); i++){
		array_push(compOldAmmo, real(ammo[i]));
	}
	compOldReload = reload;
	compOldBReload = breload;
	compOldWep = wep;
}
script_bind_step(custom_step, -6);
#define custom_step
with(Player){
	if("compAmmoRemainder" not in self){
		compAmmoRemainder = [];
		for(var i = 0; i < array_length(ammo); i++){
			array_push(compAmmoRemainder, 0);
		}
	}
	if("compOldAmmo" in self){
		for(var i = 0; i < array_length(ammo); i++){
			if(ammo[i] < compOldAmmo[i]){
				var val = (ammo[i] - compOldAmmo[i])/2 + compAmmoRemainder[i];
				ammo[i] += floor(val) * skill_get(mod_current);
				compAmmoRemainder[i] = val - floor(val) * skill_get(mod_current)
				if(ammo[i] < 0){ammo[i] = 0;}
			}
		}
		if(reload > compOldReload && wep == compOldWep && (is_string(wep) || is_object(wep) || wep > 0) && weapon_get_cost(wep) == 0){
			reload *= 1.5 * skill_get(mod_current);
		}
		if(breload > compOldBReload && wep == compOldWep && (is_string(bwep) || is_object(wep) || bwep > 0) && weapon_get_cost(bwep) == 0){
			breload *= 1.5 * skill_get(mod_current);
		}
	}
}
with(instances_matching(instances_matching_ne(projectile,"comp_fist",true),"team",2)){
	if(!(skill_get("powderedgums") && object_index == HyperSlug)){
		damage = floor(damage * 1.5 * skill_get(mod_current));
	}
	comp_fist = true;
}
instance_destroy();