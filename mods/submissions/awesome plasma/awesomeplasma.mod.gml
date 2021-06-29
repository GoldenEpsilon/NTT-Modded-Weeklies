#define step
	if(instance_exists(PlasmaBall)){
		var _inst = instances_matching_ne(PlasmaBall, "image_speed", 0);
		if(array_length(_inst)){
			with(_inst){
				if(image_index >= image_number - 1){
					event_perform(ev_other, ev_animation_end);
				}
			}
		}
	}