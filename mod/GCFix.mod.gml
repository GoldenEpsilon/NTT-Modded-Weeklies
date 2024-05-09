/*#define init
global.Collected = true;

#define step
if(gc_is_enabled()){
	gc_enable(false)
}
if (current_frame % 300 == 0) {
	global.Collected = false;
}
if(instance_exists(GenCont) || instance_exists(Menu)){
	if(!global.Collected){
		global.Collected = true;
		gc_collect()
	}
}else{
	global.Collected = false;
}

#define draw_pause
gc_enable(true)

#define cleanup
gc_enable(true)*/