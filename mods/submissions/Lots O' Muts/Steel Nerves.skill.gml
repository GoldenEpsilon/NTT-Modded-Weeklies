#define init
global.sprButton = sprite_add("Sprites/Main/Steel Nerves.png", 1, 12, 16)
global.sprIcon = sprite_add("Sprites/Icons/Steel Nerves Icon.png", 1, 8, 8)

#define skill_name
	return "Steel Nerves";
	
#define skill_text
	return "You can only take damage#up to 1/2 your max HP per hit";

#define skill_button
	sprite_index = global.sprButton;
	
#define skill_icon
	return global.sprIcon;

#define skill_tip
	return "You've got nerves of steel.";
	
#define skill_take
	sound_play(sndMutStrongSpirit);
	
#define skill_lose
with(Player){
	if(fork()){
		repeat(5){
			if(instance_exists(self) && "changedCanDie" in self && changedCanDie){
				candie = 1;
				changedCanDie = 0;
			}
			wait(0);
		}
	}
}
	
#define step
script_bind_begin_step(custom_step1, 0);
script_bind_end_step(custom_step2, 0);

#define custom_step1
with Player {
	if("steelNerves" not in self){
		nervesMax = maxhealth;
		steelNerves = nervesMax/2;
	}
	if(maxhealth > nervesMax){
		steelNerves += (maxhealth - nervesMax)/2;
		nervesMax = maxhealth;
	}
	OldHealth = my_health;
	if(my_health > 0 && candie == 1){
		candie = 0;
		changedCanDie = 1;
	}
}
instance_destroy();
#define custom_step2
with Player {
	if("steelNerves" in self && "changedCanDie" in self && "OldHealth" in self){
		if (my_health < OldHealth){
			my_health = min(max(my_health, ceil(OldHealth-steelNerves)), maxhealth);
		}
		var nervesTemp = my_health - OldHealth;
		steelNerves += nervesTemp;
		if(fork()){
			wait(2);
			if(instance_exists(self)){
				steelNerves -= nervesTemp;
			}
			exit;
		}
		if(changedCanDie){
			candie = 1;
			changedCanDie = 0;
		}
	}
}
instance_destroy();