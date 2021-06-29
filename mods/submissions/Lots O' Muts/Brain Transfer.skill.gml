#define init
global.sprButton = sprite_add("Sprites/Main/Brain Transfer.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Brain Transfer Icon.png", 1, 8, 8)

#define skill_name
	return "Brain Transfer";
	
#define skill_text
	return "@wReroll@s all#weapon mutations";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;

#define skill_avail
	return GameCont.wepmuts >= 3 && (!instance_is(self, CustomObject) && !instance_is(self, CustomProp)) || instance_exists(Loadout);

#define skill_tip
	return "Refreshing";
	
#define skill_take
	sound_play(sndMutOpenMind);
	var rerolledMuts = 1;
	var wepskills=[]
	var modskills = mod_get_names("skill");
	with([mut_long_arms, mut_boiling_veins, mut_shotgun_shoulders, mut_recycle_gland, mut_laser_brain, mut_bolt_marrow]){
		array_push(wepskills,self);
	}
	with(modskills){
		if(is_string(self) && mod_script_exists("skill", self, "skill_wepspec") && mod_script_call("skill", self, "skill_wepspec")){
			array_push(wepskills,self);
		}
	}
	with(wepskills){
		if(skill_get(self) > 0){
			rerolledMuts += skill_get(self);
			skill_set(self, 0);
		}
	}
	GameCont.skillpoints += rerolledMuts;