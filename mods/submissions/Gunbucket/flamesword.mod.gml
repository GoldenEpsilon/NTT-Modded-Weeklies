//Huge thanks to karm for writing this for me, this file is for making the Flame Sword's Particles work correctly


#define init
  global.sprFlameSwordParticle = sprite_add("sprites/sprFlameSwordParticle.png", 4, 2, 7);

#macro distance 24        // setting up macros to make editing offsets easier (and also im lazy)
#macro steroids_offset 4  // offset when steroids hold it in his bwep
#macro wallcoll_offset 12 // offset for wall collision


#define draw
  with instances_matching(Player, "wep", "FlameSword"){ // do this for all players who are currently holding flame sword in their main hand
    var _dis = distance,            // distance away from the player
        _ang = wepangle + gunangle, // the weapons angle
        _shn = false, // explained further below
        _alp = place_free(x + lengthdir_x(_dis, _ang), y + wallcoll_offset + lengthdir_y(_dis, _ang)); // dont draw flame when inside of walls

    if gunshine >.46 && image_index < .54{
      _shn = true;
    }
    draw_set_fog(_shn, c_white, 1, 1);
    draw_sprite_ext(global.sprFlameSwordParticle, image_index, x + lengthdir_x(_dis, _ang), y + lengthdir_y(_dis, _ang), wepflip, 1, _ang - 90, c_white, _alp);
    draw_set_fog(false, c_white, 0, 0);
  }

  with instances_matching(instances_matching_ne(Player, "race", "steroids"), "bwep", "FlameSword"){ //do this for all players who are currently holding flame sword in their offhand and arent steroids (steroids in generel is a huge pain in the ass for weapon modding btw)
    var _dis = distance + 2,
        _ang =  270 - 164.5 * right, //this was done by trial and error
        _alp = place_free(x + lengthdir_x(_dis, _ang), y + wallcoll_offset + lengthdir_y(_dis, _ang));
    draw_sprite_ext(global.sprFlameSwordParticle, image_index, x + lengthdir_x(_dis + 6.5, _ang), y + lengthdir_y(_dis, _ang), bwepflip, 1, _ang - 90, merge_colour(c_white, c_black, .15), _alp);
  }

  with instances_matching(instances_matching(Player, "race", "steroids"), "bwep", "FlameSword"){ //this is for all 3 steroids player out there
    var _dis = distance,
        _ang = gunangle + bwepangle,
        _alp = place_free(x + lengthdir_x(_dis, _ang), y + wallcoll_offset - steroids_offset + lengthdir_y(_dis, _ang));
        draw_sprite_ext(global.sprFlameSwordParticle, image_index, x + lengthdir_x(_dis, _ang) + lengthdir_x(min(bwepflip, 0), _ang + 90), y - steroids_offset + lengthdir_y(_dis, _ang) + lengthdir_y(min(bwepflip, 0), _ang + 90), wepflip, 1, _ang - 90, c_white, _alp);
  }

  with instances_matching(WepPickup, "wep", "FlameSword"){ //do this for all dropped versions of the Flame Sword
    var _dis = distance, // distance away from the center
        _ang = rotation, // the weapons angle
        _shn = false;    // for wep shine, youll probably need a seperate sprite if you wanna make this look good
    if image_index >.98 && image_index < 1.02{
      _shn = true; // cumbersome way of checking for a certain animation frame because dropped weapons for some reason dont use image_speed for animating
    }


    draw_set_fog(_shn, c_white, 1, 1); // little trick to make sprites draw in full colours
    draw_sprite_ext(global.sprFlameSwordParticle, current_frame / 2, x + lengthdir_x(_dis, _ang), y + lengthdir_y(_dis, _ang), image_xscale, image_yscale, _ang - 90, image_blend, 1);
    draw_set_fog(false, c_white, 0, 0); // reset fog or it gets ugly
  }
  with instances_matching(ThrownWep, "wep", "FlameSword"){ //do this for all thrown Flame Swords
    var _dis = distance, // distance away from the center
        _ang = image_angle; // the weapons angle

    draw_sprite_ext(global.sprFlameSwordParticle, current_frame / 2, x + lengthdir_x(_dis, _ang), y + lengthdir_y(_dis, _ang), image_xscale, image_yscale, _ang - 90, image_blend, 1);
  }

