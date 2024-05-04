#define properties

//- [MUTATIONS] ------------------------------------------------------------------------------------------------
	
	//Banned mutations
	global.bannedMuts			= [];
	
	//Starter mutations
	global.starterMuts			= [];
	
//--------------------------------------------------------------------------------------------------------------





//- [WEAPONS] --------------------------------------------------------------------------------------------------
	
	//baseline check for banning weapon drops (saves extra processing time if no weapons are banned)
	global.banWeapons			= false
	
	//Banned mutations
	global.allowedAmmoTypes		= [
		true,	//TYPELESS
		true,	//BULLET
		true,	//SHELL
		true,	//BOLT
		true,	//EXPLOSIVE
		true	//ENERGY
	];
	
	//Toggle appirance of melee wepaons. 0 = normal, -1 = no melee, 1 = melee only
	global.meleeToggle			= 0;
	
//--------------------------------------------------------------------------------------------------------------





//- [ENVIROMENT] ------------------------------------------------------------------------------------------------
	
	//makes all levels dark
	global.fullDark				= false;
	
//--------------------------------------------------------------------------------------------------------------







#define init
	properties();
	global.modifiresCont = cont_create();

#define cleanup
//clear cont
	if instance_exists(global.modifiresCont){
		instance_delete(global.modifiresCont);
	}

//unban mutations if they were banned and in the list
	if array_length(global.bannedMuts) {
		with global.bannedMuts {
			if !skill_get_active(self) skill_set_active(self,true);
		}
	}

#define game_start
//Ban mutations
	if array_length(global.bannedMuts) {
		with global.bannedMuts {
			if skill_get_active(self) skill_set_active(self,false);
		}
	}

//set starter mutations
	if array_length(global.starterMuts) {
		with global.starterMuts {
			var _a = is_array(self);
			var _skill = (_a ? self[@0] : self);
			var _value = (_a ? self[@1] : 1);
			
			if is_real(_skill) || mod_exists("skill",_skill) skill_set(_skill,_value);
		}
	}

#define step
//cont
	if !instance_exists(global.modifiresCont) global.modifiresCont = cont_create();

//make stages dark
	if global.fullDark && instance_exists(TopCont) && !TopCont.darkness {
		TopCont.darkness = true;
	}

#define true_step
	if global.banWeapons && instance_exists(WepPickup) {
		var untagged = instances_matching(WepPickup,"modifireTagged",null);
		if array_length(untagged) with untagged {
			modifireTagged = true;
			//reroll weapon
			if roll && !global.allowedAmmoTypes[@weapon_get_type(wep)] {
				var _seed = weapon_get_seed(wep);
				wep = weapon_decide_seeded(_seed,0,GameCont.hard,weapon_get_gold(wep),-1);
			}
			
			//if no weapons are available, make an ammo chest instead
			if wep == wep_screwdriver && (global.meleeToggle == -1 || global.allowedAmmoTypes[@0] == false){
				instance_create(x,y,AmmoChest);
				instance_delete(self);
			}
		}
	}


#define end_step


#define cont_create
	with instance_create(0,0,CustomObject) {
		name			= "WeekliesModifiresCont";
		persistent		= true;
		on_step 		= script_ref_create(true_step);
		on_end_step 	= script_ref_create(end_step);
		return self;
	}

#define weapon_decide_seeded(_seed, min_hard, max_hard, _gold, _exclude)
    /*
    Choose a random weapon from the weapon drop pool, respecting drop conditions
    Modified to respect ammo types
    */
    if (UberCont.hardmode){
        max_hard = ceil((max_hard - 16) / 3 + 2);
    }
    
    max_hard += player_count_race(char_robot);
    min_hard += 5 * ultra_get(char_robot, 1);
    max_hard = max(0, max_hard);
    min_hard = min(min_hard, max_hard);
    
    var _chosen = wep_screwdriver;
    /*
    if ("wep" in self && wep != wep_none){
        _chosen = wep;
    }
    
    else if (_gold > 0){
        _chosen = choose(wep_golden_wrench, wep_golden_machinegun, wep_golden_shotgun, wep_golden_crossbow, wep_golden_grenade_launcher, wep_golden_laser_pistol);
        
        if (GameCont.loops > 0 && choose(true, false)){
            _chosen = choose(wep_golden_plasma_gun, wep_golden_slugger, wep_golden_splinter_gun, wep_golden_screwdriver, wep_golden_bazooka, wep_golden_assault_rifle);
        }
    }
    */
    
    var _list = ds_list_create();
    var weapon_count = weapon_get_list(_list, min_hard, max_hard);
    
	var _lastSeed = random_get_seed();
	random_set_seed(GameCont.baseseed + _seed);
	random_set_seed(ceil(random(100000) * random(100000)));
    
    ds_list_shuffle(_list);
    
    random_set_seed(_lastSeed);
    
    for (var i = 0; weapon_count > i; i ++){
        var _wep = _list[| i];
        
        var _valid = !(
        	!(global.allowedAmmoTypes[@weapon_get_type(_wep)]) ||
        	(_wep == _exclude || (is_array(_exclude) && array_find_index(_exclude, _wep) >= 0)) 	|| 
        	((_gold > 0 && !weapon_get_gold(_wep)) || (_gold < 0 && weapon_get_gold(_wep)))
        );
        
        
        if (_valid){
        	//melee toggle
        	if global.meleeToggle != 0 {
        		switch global.meleeToggle {
        			case -1: if  weapon_is_melee(_wep) _valid = false;
        			case  1: if !weapon_is_melee(_wep) _valid = false;
        		}
        	}
        	
            switch(_wep){
                case wep_super_disc_gun: _valid = ("curse" in self && curse > 0); break;
                case wep_golden_nuke_launcher:
                case wep_golden_disc_gun: _valid = (UberCont.hardmode); break;
                case wep_gun_gun: _valid = (crown_current == crwn_guns); break;
            }
            
            if (_valid){
                _chosen = _wep;
                break;
            }
        }
    }
    
    ds_list_destroy(_list);
    return _chosen;
    
#define weapon_get_seed(_wep)
	var w = is_real(_wep) ? _wep : real(string_digits(string_sha1(_wep)));
	var seed = w * GameCont.hard * GameCont.baseseed; //SO awesome
	while seed > 100000 {seed *= 0.1}
	seed = floor(seed);
	return seed;
	
#define seeded_random(_seed, _min, _max, _irandom)
	//Returns a random value from min to max, seeded to the given seed without affecting the overall random seed (if _irandom is true uses irandom)
	//thanks gepsi!
	var _lastSeed = random_get_seed();
	random_set_seed(GameCont.baseseed + _seed);
	random_set_seed(ceil(random(100000) * random(100000)));
	
	var rand;
	if(_irandom){
	    rand = _min+irandom(_max-_min);
	}else{
	    rand = _min+random(_max-_min);
	}
	random_set_seed(_lastSeed);
	return rand;
	