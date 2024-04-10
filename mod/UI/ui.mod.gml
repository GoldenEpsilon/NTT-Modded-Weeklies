/* *  *   *   *  * *\
 *                 *
       UI TIME

list of things that make a weekly start

	starting weapons
	starting crowns
	charcters
	discription
	
	



	double check go button following to L1




    ~set up data
    "
    scoreboard = [{ name1:{},name2:{} },{...},{...}]
    
    "
	
	
    
 *                 *
\* *  *   *   *  * */

#macro debug false  	if debug trace("debug is on")
#macro moddedweeklies_mod_file "ModdedWeeklies"

#macro holdbackdelay 16;    /*  how long you have to hold to return to the main menu  */


global.game_size = [game_width,game_height]

/*  characters unlocked  */	
global.frog = false;
global.skel = false;
global.bdog = false;
/*  hide menu portraits  */
global.hideportraits = false;
		
	


//sprites
if global.hideportraits 
	sprite_replace(sprBigPortrait,"sprites/blank_strip3.png",3,0,0);


global.sprBackIntro = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAaQAAAAcCAYAAAAuosuZAAAACXBIWXMAAAsSAAALEgHS3X78AAAAG3RFWHRTb2Z0d2FyZQBDZWxzeXMgU3R1ZGlvIFRvb2zBp+F8AAACCklEQVR42u3dXW7CMBAA4XCiqvc/RNUTpU9IEQIa/2y8xt+8UmmQEDuyG5vbvu8bAKzEz9dt//7db1f6tm3brnLO6rsJEgAxih/WVwXi6LvC2dMnSACWi9EVK4hHV3QkPsEnSACWC9F9aEaF6d2w5hMkAAvH6N3rEcOarw5BAiBGfCl8ggRgyRj1Hqx87T5BApAuJM/+33PlAC0dpr1cq/sECcA0q52SMPUYovcw/uftGb+VfYIEYIoAlZ4f6r1C+s/P1+4TJADTxWrESkmU4n2CBGC6CNVGqWVrqtb37r328JWcBcruEyQA00SpNhAlEet12PPoq4lSj1VgSSQy+AQJwDJRihi4WSJYcoVPVp8gAWge3iMuDY0M0qy+x63C0kiM9gkSgCmiJEh1n8erzyajT5AANEdIkPh6+AQJWHTF0epreY+1vtoBuprvzFOFGX2CBCSLxNlHhkf7jlf8RDwS3WuAruiLDFKkT5CAZFGa5Rc/W4NU42sZoHz5fYIEJFodtW6ljPD1uDmh9sBq7SPVfDl9ggRUDN7oQI1eJZ3ZfmnZUvyEMzN8/X2CBCRcKb36wkf+5PaZv3uMUM8glTLqPju+OJ8gAYnj9+oLHBGm0ig9C1R0lPg+2ydIwARRGrVVGDXMWnwtIebL7RMkAEWD5hjHXqs0Pj5BAjBNILMfFOZr9wkSACAFf9jghAUDVL1aAAAAAElFTkSuQmCC"
, 15, 16, 16);
global.sprBackButton = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAKgAAAAeCAYAAAC42FXcAAAACXBIWXMAAAsSAAALEgHS3X78AAAAG3RFWHRTb2Z0d2FyZQBDZWxzeXMgU3R1ZGlvIFRvb2zBp+F8AAADBElEQVR42u2cW24kIQxF8YYmSva/homSDXk+ZpAIA8Y2vlBdhb9a6lYdbN/iYawmZk4aIyJOKSVmprTADu/wUkqJNAIlIv796+/nj2+8k0/g5bgT0S15UfEUBZrfggzLhkriU3h1zFGi2cWLjGdXoPkt+Pj+H4hI4hN4zJzF0foe5t9qXmQ8qTN4ERadwCfwRlupSMG0/Hv/4qU8mEDL/UPPEGK5M2+HOFuWRbqKF77Ea2Etc70dD+BpxHniqRCoBqYdiAa+g8fM6fONlvtXL68j+3wjaDxb4ylfFHT+3r9YzaN/G/cpsVin9B28cibzinTGP49IkfGUxjPaAkTkr+RLvHCB5o1yngFa4B28eqmdmUm9/nlnUlQ8ezNprjag85dnUokXtsS3lsOizAEXqYYXKVKvfzPLPSKe0nJflMXgIu3xzIekI9Ij0pUiNZWZWicyaYDSsrST1xPpSv/qg0JxYBiKFBHPgUjh+atE2p5BtdAfDzD81uskgieJdJV/xR6MNKUpbf3SG09vMR+Zv+FVp+ohwCQieS2RXsU/lEhH/kWLdDaew2aRsitF6lCxDPBKvKrLxyxSpH+zd+jeeGpLQCvyR4qbDi43572NekQCd/LKUsdV/Ito8vDG03stGp0/cYmvH5g3sPV3EQk8vNgZNMK/1h55dTyH3Uz16cta4tAkcAevnDHL07O1pIL0zyvQO+VPLDOVtxgoB3fz6h7NaIHO+OcR6N3yp6qDahoXIhzcwdM2Luzwb1agd8ifulAvDXSmDNPrMkLyrHutaJ7WP+GuHMJb7Z+7zCRBWxZVk2yJFMXribRlOUaWlygqnp6Sz478oXjmmySLeYrmM61wETc7I7O0wUXF01ry2ZE/FM98k6SBSA0N0SKd4XlESkShvNX+vRpPfZNkgXkK2B6RRvAsItWc9iOTiPLvlXimmyQJpKl9aZ3M+76eSBE8qQO+bAXzinN3PF+VR9a/vunZqOvb6+hVeKMu81f376o8tUCVy/OS//05vOfwwgR67BjC/gB49PQf8OwrGQAAAABJRU5ErkJggg=="
, 6, 16, 17);
global.sprLoadoutSplat = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAbQAAABFCAYAAAAijRNOAAAGb0lEQVR4nO3dW47jNhCFYXqQhfXSvLTe2eRhIjSjsSReinXj/wF5GaAtmbTqiBcpr693QTDfb+szAAB/flmfAAAAEgg0AEAKBBoAIAUCDQCQAoEGAEiBQAMApECgAQBSINAAACkQaACAFAg0AEAKBBoAIIV/rE8A2JXX96h+v8vvUkr5epeX9nG1j3nn++2/j840289bf5VSystrh+EaLyfOwfO1dy6YWoXLU5H0HGi1q3ArRbffjuNZ9iGBFhCBlkOUa+9TwdQoWNbhFiXQzqxGb1Y3QTUCLSCLQMvyO7Eqkp/6LGqbagVcfRyrPovaRwftmxHrUGMNDduxWiPKom63oy1XhM8xfSXxWbvS6isvCDRs5biAv9/lN8E2b3XBpG/k7BBuTDkGxJSjHK0LOtOU4xOrNTdpGaYcW2UJNkZo2Fo9rcWITcYOI4FssvQJD1Zje1/v8joXYdZuZBxt+ynk8MNrmxzXgsb5SRyHKceAmHJcT3q0ZjnluPPoaKYfNaccPTxLdkfrUYDZ645AC4hAi8fDGpr1luo7K6d7Rz/bwxqatz57GkFZnx+BFhCBFo+HQKt5K5Sl+NtM4iHQap7ap2VqUOLcen+nBFpABFo83gLt4KlIHjRGAS3TsN4CraY1BThzLmej59bzXQm0gAi0eLwGWil+129WjwKe7v49B1opvqb/RjZzDEwBPwYbgRYQgRaP50A7eCqQtd5i2XOed0XSe6AdetpndR/O7lJsOb+7YxBoARFo8UQItDOtdZJe0gX85vPC1EerEdLdZ6wOt0+fH6bD8INAiydioNU8hptUsGkH2qf1O4lNOjMBIjWq7f2bVvVnM0JLhkDz77xVXCPQ6mO2bHoY/fwWkhsARu7U77QWx6IQaHdm+200RFqPO7L2OhtsTwi0gCwCrRReC9XjHCiagfaJZL9Zr5MoFsul9dFq1Cs9khvdcbki3Ai0gCwDrUa4Xftwsf7VVpp3/94KYyky01xXnyNULFXqo9aNSO+xn0icm3SoEWgBWU85jkwL7apqK5VAOx2zPpbrLdyHkemuhSMBtfqoeSPSctwexxS31RRpjUALyDrQatbF04uGi3FZoF0VE4kiM0Pq7ttwunTZGtr5O1lfR6vWtiTXUlsQaAF5CrSa9UVppfHiWxpo/32ey7b2VCw9BNqVFRt5Zs5htRUjawItIK+BVjv/GL0W21kdF53alOMs6x2SM+7Od+Ac3NfHVVOVmsF26Nh9eon/wSeWkPhxepf1e9Wkbkxaptgk7NAnLWZnS7T6S/oY7u9A8LcII7Qd9E5fnf/Be5tqbSt3HEKh6mNPO2qvbWkJ1WH4g0DzIXug1bxs0VcWtj6uaMOFj0eICdthOyPQ1umdqsm4htZqxfZ8ZwXSdX3s2QzkrF2XYQ0NeGC9/V1Tz3c9nj8aPc7I32HM0afZ2/2X9QkAntyNHI7/6n/TOzM9Wb9XNl/v8trlRqsVIzTg5OluNnPB9/iA9k4knuW8e9B+5twiINCAC1mmaSS23hNq6z3dQPVMBUueVySuFz3xGZtC9AmEmummkKfzV3jrRkRm9bG3bVe8dSMiAi0gAm3eyDNWk0XBzS7H0e8xswkkKPP6uFl7T2PKEdtpLRJZi8noVGrW9vBs17WwUQQatkIx+LHhiCsFi9dSRUGgARtj7SU+bkx+8BwagEs86xQD/fQHIzQAj5jm0tO7Tb+2ez8xQgM2dH7rCXy4ehPNzM5UifOKghEakFxdDI8Cd6y73L1VIsgLhLcw0hc7rq0RaMBG6qB6KpK7FUMNT29cqUNodsPOjv3HlCO2km0KpmXq8LxhYMdC50XL748NHuMYoWE7maZiegofRTKXLO8alUSgAZs7psEojO1mdiJKHh//R6BhO5GKwdOiv9RnR2oTTzR3H9JHzwg0bCNiQbgbOUX8PlnMrknSd2uwKQRw7m6TAOti9tjE4QcjNCCIllDjzt9Ob6h96qvd3/Qxi0ADErnb+XZXcCmc+lq38NM37Qg0pLZrMegdLTDK82t0OnPHfiTQkNaOF7QEpr3kPb0hRPpYGsfxiEBDStkvaokCeX6W6tM7H7O3Yyvt585o9zEEGmBkJpR6/m7knX8UVFmt/UW7zyHQACNSD9fyVvz1Wvrqqr3ZjKOHQENK0XeH9Zz7eaQX+XtH0trO9IceAg1woqfwnQOborkG7RrLvxFE6+s0sg23AAAAAElFTkSuQmCC"
, 4, 109, 69);

global.mod_charselect = sprite_add("sprites/mod_charselect.png",1,0,0)
global.mod_mapicon = sprite_add("sprites/mod_mapicon.png",1,8,8)
global.mod_mutation = sprite_add("sprites/mod_mutation.png",1,8,8)
global.mod_ultra = sprite_add("sprites/mod_ultra.png",1,8,8)
	
//surfaces
global.menu_surf_art = 0
global.menu_surf_splat = 0		
global.menu_surf_splat2 = 0		
global.menu_surf_text = 0		

global.menu_opened = false
global.menu_opening = [0,16]     //  min/start,max
global.current_scoreboard = 0   //which tab is open

global.scoreboard_number_of_rows = 6    // number of rows displayed
global.scoreboard_opened = -4       //which row is opened, -4 = none
global.scoreboard_opening = [0,16]  //  min/start,max
global.scoreboard_position = [0,0,0]    //where each is scrolled


global.splash_opening = [0,64] //  min/start,max




#macro menu_opened global.menu_opened
#macro menu_opening global.menu_opening
#macro scoreboard_number_of_rows global.scoreboard_number_of_rows
#macro scoreboard_opened global.scoreboard_opened 
#macro scoreboard_opening global.scoreboard_opening
#macro scoreboard_anim scoreboard_opening[0]/scoreboard_opening[1]
#macro menu_anim menu_opening[0]/menu_opening[1]
#macro scoreboard_pos global.scoreboard_position

#macro splash_opening	global.splash_opening
#macro splash_anim	splash_opening[0]/splash_opening[1]

#macro scroll_interval current_frame mod 2 <= 0
    
//skin loadout icons
#macro topheight 64;
#macro botheight game_height-92;
#macro width game_width-136;
#macro fitskins ceil((botheight-topheight+1)/28);
//char select
#macro fitchar ceil(( (game_width-72)-8 )/17);//ceil(( (game_width-72)-8 )/17);
global.ntte = false
global.stack = 1
if debug
global.names = ["fish","eyes","crystal","melting","plant","yv","steroids","robot","chicken","rebel","horror","rogue","detonator"]



with instances_matching(CustomObject,"name","mod_ui_daily_button"){
    
    global.menu_opened = false
    instance_delete(id)
    
}

global.menu_surf_text = 0		






global.scoreboard = [
		{
		name: "Testing Bed",
    	p1 :{
    	        name : "", 
    	        race : 0,
    	        skin : 0,
    	        kills : 0,
    	        hard : 0,
    	        area : 0,
    	        subarea : 0,
    	        loop : 0,
    	        wep : 0,
    	        bwep : 0,
    	        crown : 0,
    	        mutations : [],
    	        time : 55032,
    	        color : c_red,
    	        killed_by : [mskNone,"???"],
    	        ultras: [
					  "Union",
					  [5, 1],
					  ["detonator", 0]
					]
    	        
    	    },
    	},{
    	},{
    	}
    ]

global.options = mod_script_call("mod", "ModdedWeeklies", "get_options");
				
//get information from file
update_scoreboard()


//characters
if !global.options.frog{
	race_set_active(15,0);
	with instances_matching(CampChar,"num",15) instance_delete(id);
	}
if !global.options.skeleton{
	race_set_active(14,0);
	with instances_matching(CampChar,"num",14) instance_delete(id);
	}
/*if !global.options.bigdog{
	race_set_active(13,0);
	with instances_matching(CampChar,"num",13) instance_delete(id);
    }
	else{
    race_set_active(13,1);
}*/


#define update_scoreboard
global.scoreboard = [[],[],[]]

if debug{
    
    for(var _s = 0;_s<array_length(global.scoreboard);_s++){
    
    var _array = []
    for(var i = 1;i<array_length(global.names);i++){
        
        var _kills = irandom(10000)
        var _hard = ceil(_kills/240)
        var _area = ceil((_kills/32) mod 7)
        if !irandom(5) _area = "undergrowth"
        var _race = i//1+irandom(11)
        if !irandom(10) _race = "detonator"
        var _muts = [1,2,3,4,5,6,choose("flamingpalms","compoundelbow","concentration","condensedmeat","powderedgums")]
        var _name = 
                {
                    name : global.names[i],//"p"+string(i), 
                    race : _race,
                    skin : irandom(1),
                    kills : _kills,
                    hard : _hard,
                    area : _area,
                    subarea : is_string(_area)? 1:_area mod 2 = 1 ? 1:(_hard mod 3 )+1,
                    loop : floor(_hard/16),
                    wep : irandom(101),
                    bwep : irandom(101),
                    crown : irandom(13),
                    mutations : array_shuffle(_muts),
                    time : 55032,
                    color : choose(c_red,c_aqua,c_lime,c_purple,c_dkgray,c_fuchsia,c_yellow,c_orange,c_blue),
                    killed_by : [sprBanditIdle,"bandit"]
                }
        _array[array_length(_array)]= _name
        }
    global.scoreboard[_s] = _array
    }
}

var does_the_mod_exist = mod_exists("mod",moddedweeklies_mod_file)

if does_the_mod_exist{
    
    global.scoreboard = [{},{},{}]

    global.scoreboard = 
        mod_script_call("mod",moddedweeklies_mod_file, "getScores", "Kills")
        //please sort them by kills/display order
}

//sort by kills

if debug
for(var s=0;s<array_length(global.scoreboard);s++)
global.scoreboard[s] = array_shuffle(global.scoreboard[s])//sort_array_by(global.scoreboard,kills)



#define go
game_restart();
instance_destroy();

#define force_quit
cleanup()
mod_loadtext("exit.txt");
instance_destroy();
#define game_start
cleanup()
with instances_matching_ne(BackFromCharSelect,"mod_ui",null) mod_ui = null
with instances_matching(CustomObject,"name","mod_ui_daily_button") instance_delete(id)
with instances_matching(CustomObject,"name","mod_ui_superbutton") instance_delete(id)
with instances_matching(CustomObject,"name","mod_ui_backbutton") instance_delete(id)
#define draw_gui_end

 

//scoreboard animations
if scoreboard_opened != -4{ //ease in
    if scoreboard_opening[0] < scoreboard_opening[1]
        scoreboard_opening[0] += ((scoreboard_opening[1]-scoreboard_opening[0])/4)*current_time_scale
    
}else{  //ease out
    if scoreboard_opening[0] > 0    
        scoreboard_opening[0] = max(0,scoreboard_opening[0]*(0.1*current_time_scale)) 
}
//menu animations
if menu_opened{ //ease in
    if menu_opening[0] < menu_opening[1]
        menu_opening[0] += ((menu_opening[1]-menu_opening[0])/5)*current_time_scale
    
}else{  //ease out
    if menu_opening[0] > 0
        menu_opening[0] = max(0,(menu_opening[0]-(max(0.02,menu_opening[0]*0.3)*current_time_scale))) 
}

//splash animations
if !menu_opened{ //ease in
    if splash_opening[0] < splash_opening[1]
        splash_opening[0] += ((splash_opening[1]-splash_opening[0])/1.5)*current_time_scale
    
}else{  //ease out
    if splash_opening[0] > 0
        splash_opening[0] = max(0,(splash_opening[0]-(max(0.02,splash_opening[0]*0.3)*current_time_scale))) 
}

#define draw

if GameCont.timer = 0{
	
	if global.game_size != [game_width,game_height]{
		reset_surfaces()
	}

    
    draw_set_projection(0, 0)
    draw_set_color(c_black)
    var xx = -240+(322*menu_anim)
    draw_rectangle(xx-200,36,xx-200+game_width*0.8,game_height-36,0)
    draw_sprite_ext(sprLoadoutOpen,floor(2+3*(menu_anim)),xx,game_height-36,-1,1,0,c_white,1)
    draw_sprite(global.sprLoadoutSplat,floor(3-(3*min(1,menu_anim*4))),game_width+64*(menu_anim),game_height-36)

    draw_reset_projection()

if debug
if button_pressed(0,"horn")
    update_scoreboard()

//if menu_opened{
  
if !surface_exists(global.menu_surf_text)
	global.menu_surf_text = surface_create(game_width,game_height)
  	
surface_set_target(global.menu_surf_text)
	draw_clear_alpha(c_silver,0)
	draw_set_projection(2, 0)
	with Menu{
		charsplat = 3
		for(var c = 0;c<3;c++)
			charx[c] = -10000
		visible = true
		event_perform(ev_draw,0)
		visible = false	
		}
	draw_set_valign(0)
	draw_reset_projection()
surface_reset_target()

draw_set_projection(0, 0)
  
  
    //var xx = game_width-36 +222-(222*menu_anim)
    //var yy = game_height-48
    
    //var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,game_width-64,game_height-67,game_width,game_height-37)
    
    //var _sprt = get_mapsprite(player_get_race_id(0),player_get_skin(0))
    //draw_sprite(_sprt[0],_sprt[1],xx-1*mouse_over,yy+1*mouse_over)
    
    
    
    var xx = 16 -game_width +(game_width*menu_anim);
    var yy = 48+8;
    
    //SCOREBOARD
    //if debug{
    //if button_check(0,"key1")
    //    scoreboard_pos[global.current_scoreboard] -=1
    //if button_check(0,"key2")
    //    scoreboard_pos[global.current_scoreboard] +=1
    //} 
    //scoreboard_pos[global.current_scoreboard] = clamp(scoreboard_pos[global.current_scoreboard],0,array_length(global.scoreboard[global.current_scoreboard])-scoreboard_number_of_rows )
    //
    scoreboard_pos[global.current_scoreboard] = round(scoreboard_pos[global.current_scoreboard])
    
    //if scoreboard_opened>(scoreboard_pos[global.current_scoreboard]+scoreboard_number_of_rows) or scoreboard_opened<scoreboard_pos[global.current_scoreboard]
    //    scoreboard_opened = -4
        for(var i = scoreboard_pos[global.current_scoreboard]  ;i<    (scoreboard_pos[global.current_scoreboard]+scoreboard_number_of_rows ) && i >= 0 && i < array_length(global.scoreboard[global.current_scoreboard])   ;i++){
        
        
	    draw_set_halign(0)
        
        
        
        var f = i-scoreboard_pos[global.current_scoreboard]
        
        var col2 = global.scoreboard[global.current_scoreboard][i].color
        var col = make_color_hsv(color_get_hue(col2),max(0,color_get_saturation(col2)*0.9),max(100,color_get_value(col2)*0.8))
        
        var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx,yy-1,xx+game_width*0.8,yy+7)
        var _opened = i=scoreboard_opened
        
        
        draw_set_color(c_black)
        if _opened
        draw_rectangle(0,yy-4*scoreboard_anim,-game_width+((game_width*4)*menu_anim),yy+38*scoreboard_anim,0)
        
        var xxx = 0
        var yyy = 0
        var _pointless_wiggle = ceil(sin(current_frame + f)/2)
        
        
        if mouse_over or scoreboard_opened = i{
        draw_set_color(col)
        draw_rectangle(xx-20,yy-1,xx+(game_width-17)*menu_anim,yy+7*menu_anim,0) 
        draw_line(xx-20,yy+8+_opened,xx+(game_width-17)*menu_anim,yy+8*menu_anim+_opened)
        draw_set_color(c_white)
            _pointless_wiggle= cos(current_frame + f)
            
            if button_pressed(0,"fire") and mouse_over
                if scoreboard_opened = i
                    scoreboard_opened = -4
                else{
                    scoreboard_opened = i
                    scoreboard_opening[0] = 0
                }
        }
        //character name
        if _opened{
            draw_set_halign(0)
            draw_set_color(col)
            if !is_string(global.scoreboard[global.current_scoreboard][i].race)
            var _text = string(race_get_name(global.scoreboard[global.current_scoreboard][i].race))
            else
                    _text = global.scoreboard[global.current_scoreboard][i].race
            if _text = "venuz" _text = "yung venuz"
                
        	draw_set_font(fntM)
            draw_text(xx-32+(34*scoreboard_anim)+_pointless_wiggle*0.3,yy+10,_text)
        }
       
        
        //bgun      //maybe second forloop to render all bweps first for less clipping
        xxx+= 4
        
        var _x = round(xx+xxx-5+((64*scoreboard_anim)*_opened))
        var _y = round(yy+(_pointless_wiggle*(scoreboard_opened!=i))+((26*scoreboard_anim)*_opened))
        var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-6,_y-16,_x+20,_y+12)
        var _sprt = weapon_get_sprt(global.scoreboard[global.current_scoreboard][i].bwep)
        if _sprt != 0
        draw_sprite_ext(_sprt,0,_x,_y+hover_over,1,1,45-((45*scoreboard_anim)*_opened),_opened ? c_white:c_silver,1)
        if hover_over and _opened and (scoreboard_anim > 0.9) and global.scoreboard[global.current_scoreboard][i].bwep != 0
        	script_bind_draw("ui_popup_draw",-1000,_x+8,_y-6,weapon_get_name(global.scoreboard[global.current_scoreboard][i].bwep))
            
        
        
        xxx-=32
        
        //mapicon
        var _sprt = get_mapsprite(global.scoreboard[global.current_scoreboard][i].race,global.scoreboard[global.current_scoreboard][i].skin)
        draw_sprite_ext(_sprt[0],_sprt[1],round(xx+((167*scoreboard_anim)*_opened)),round(yy+(_pointless_wiggle*!_opened)+((10*scoreboard_anim)*_opened)),1,1,0,_sprt[0]=global.mod_mapicon?col:c_white,1)
        
        //crown
        xxx+=48
        var _x = round(xx+xxx)
        var _y = round(yy+4+_pointless_wiggle+((22*scoreboard_anim)*_opened))
        var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-4,_y-4,_x+4,_y+4)
        var _sprt = get_crownsprite(global.scoreboard[global.current_scoreboard][i].crown)
        if global.scoreboard[global.current_scoreboard][i].crown != 0 and global.scoreboard[global.current_scoreboard][i].crown != 1
        draw_sprite_ext(_sprt,current_frame*0.4,_x,_y,1,1,0,c_white,1)
        if hover_over and _opened and (scoreboard_anim > 0.9) and global.scoreboard[global.current_scoreboard][i].crown != 1
        	script_bind_draw("ui_popup_draw",-1000,_x+8,_y-6,crown_get_name(global.scoreboard[global.current_scoreboard][i].crown))
        
        xxx+=-20
        //gun       // add melee weapon angle
        var _x = round(xx+xxx+((38*scoreboard_anim)*_opened))
        var _y = round(yy+4+(_pointless_wiggle*(scoreboard_opened!=i))+((22*scoreboard_anim)*_opened))
        var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-6,_y-16,_x+20,_y+12)
        var _sprt = weapon_get_sprt(global.scoreboard[global.current_scoreboard][i].wep)
        if _sprt != 0
        draw_sprite_ext(_sprt,0,_x,_y+hover_over,1,1,(45-45*_opened)*weapon_is_melee(global.scoreboard[global.current_scoreboard][i].wep)-15+((15*scoreboard_anim)*_opened),c_white,1)
        if hover_over and _opened and (scoreboard_anim > 0.9) and global.scoreboard[global.current_scoreboard][i].wep != 0
        	script_bind_draw("ui_popup_draw",-1000,_x+8,_y-6,weapon_get_name(global.scoreboard[global.current_scoreboard][i].wep))
            
        
        xxx+=24+16 + string_length(i+1)*4
        
        draw_set_color(c_gray)
        if scoreboard_opened = i or mouse_over
        draw_set_color(c_white)
        
        //ranking
        draw_set_halign(2)
        draw_set_font(fntM)
        var _x = round(xx+xxx+(0- 16*(scoreboard_anim*_opened)+_pointless_wiggle))
        var _y = yy
        draw_text(_x,_y,i+1)
        
        _pointless_wiggle*=1.5
        
        //name
	    draw_set_halign(0)
        var _text = string(global.scoreboard[global.current_scoreboard][i].name)
        
            
        if _opened
            draw_text(round(xx+xxx+8+_pointless_wiggle),yy,_text)
        else
        for (var k = 1;k<clamp(string_length(_text)+1,1,9);k++){
            draw_text(round(xx+xxx+_pointless_wiggle+(k*8)),yy,string_char_at(_text,k))  
        }
        //score
        xxx+=96
        yyy+=((8*scoreboard_anim))*_opened
        
	    _text =
            string(global.scoreboard[global.current_scoreboard][i].kills)
        
	    draw_set_halign(1)
	    
	    var _x = xx+xxx
	    var _y = yy+yyy
        var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-12,_y-12,_x+32,_y+12)
        if hover_over and _opened and (scoreboard_anim > 0.9) {
			var deathcause = global.scoreboard[global.current_scoreboard][i].killed_by;
			if(!is_array(deathcause)) {
				deathcause = killed_by(deathcause);
			}
			var vowel = string_lower(string_char_at(deathcause[1], 1));
			vowel = (vowel == "a" || vowel == "e" || vowel == "i" || vowel == "o" || vowel == "u") ? "n" : ""
        	script_bind_draw("ui_popup_draw",-1000,_x,_y,"killed by a" + vowel + " "+string(deathcause[1]))
        	draw_sprite(deathcause[0],current_frame*0.4,_x+122,_y)
        }
	    
        draw_text(xx+xxx,yy+yyy,_text)
        
        //area
	    draw_set_halign(2)
        xxx+=104
        
	    var _x = xx+xxx
	    var _y = yy+yyy
        var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-32,_y-12,_x,_y+12)
        //_text =
        //
        //    string(string(global.scoreboard[global.current_scoreboard][i].area)+"-"+string(global.scoreboard[global.current_scoreboard][0].subarea))
        
        //if global.scoreboard[global.current_scoreboard][i].loop != 0
        _text = area_get_name(global.scoreboard[global.current_scoreboard][i].area, 
        	global.scoreboard[global.current_scoreboard][i].subarea, 
        	global.scoreboard[global.current_scoreboard][i].loop, 
        	0, 
        	0)
        //string("L"+
        //    string(global.scoreboard[global.current_scoreboard][i].loop)
        //)+" "+ _text
        
       
        draw_text_nt(_x,_y,_text)
        
        if hover_over and _opened and (scoreboard_anim > 0.9){
        	//var _text = area_get_name(global.scoreboard[global.current_scoreboard][i].area)
        	script_bind_draw("ui_popup_draw",-1000,_x+64,_y,_text)
        }
        
        
        
        
        if _opened{
            xxx=0
            
            //charselect
        	
        	var _x = xx+xxx-32+(16*scoreboard_anim)
        	var _y = yy-1
        	//var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x,_y,_x+16,_y+24)
            var _sprt = get_charsprite(global.scoreboard[global.current_scoreboard][i].race)
            draw_sprite_ext(_sprt[0],_sprt[1],_x,_y,1,1,0,_sprt[0]=global.mod_charselect?col:c_white,1)
            var name = global.scoreboard[global.current_scoreboard][i].race
            
            //if hover_over
            //	script_bind_draw("ui_popup_draw",-1000,_x+12,_y-6,race_get_name(name))
            
            
            xxx+=48
            //mutations
            var muts = global.scoreboard[global.current_scoreboard][i].mutations
            if array_length(muts) > 0{
            var mx = 0
            var _ind = 0
            for(var m = 0;m<array_length(muts);m++){
            	
        		var _x = xx+xxx+12+((48+(18*m))*scoreboard_anim)
        		var _y = yy+30
        		var _name = skill_get_name(muts[m])
        		
        		var hover_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,_x-5,_y-5,_x+5,_y+5)
                if is_string(muts[m]){
                		//get the mods sprites
                	//_sprt = global.mod_mutation
                	//if mod_exists("skill",muts[m]) and mod_script_exists("skill",muts[m],"skill_icon"){
                	//_sprt = mod_script_call("skill",muts[m],"skill_icon")
                	//}
                	//else
                	//_ind = 0
                	
                	var _get = skill_get_icon(muts[m]);
                	if is_array(_get){
                		_sprt = _get[0];
                		_ind = _get[1];
                	} else{
	                	_sprt = global.mod_mutation
                	}
                	
                	draw_sprite(_sprt,_ind,_x,_y+hover_over)
                }
                else{
                	
                draw_sprite(sprSkillIconHUD,muts[m],_x,_y+hover_over)
                }
            	if hover_over and scoreboard_anim > 0.9
            		script_bind_draw("ui_popup_draw",-1000,_x,_y-4,_name)
            		
                
            }
                
            }
        }
        
        
        if scoreboard_opened = i
        yy+= 45
        else
        yy+=24-((5*	(scoreboard_opened!=-4  and !(scoreboard_opened>(scoreboard_pos[global.current_scoreboard]+scoreboard_number_of_rows)) and !(scoreboard_opened<scoreboard_pos[global.current_scoreboard]))	))
    }
    
    
    draw_reset_projection()
//}




if !surface_exists(global.menu_surf_art)
    global.menu_surf_art = surface_create(game_width,game_height);
surface_set_target(global.menu_surf_art)
    draw_clear_alpha(c_silver,0)
    draw_set_projection(2, 0)
    with Menu{
    	
    		charsplat = 0
            for(var c = 0;c<3;c++)
                charx[c] = floor(178-222*menu_anim)
            visible = true
        	event_perform(ev_draw,0)
        	visible = false
        	
        	
        	
    }
    
    draw_set_projection(0, 0)
    //draw_surface_ext(global.menu_surf_splat2,0,(game_height-72)/2,1,0.5,0,c_black,1)
    draw_reset_projection()
        
    
    

surface_reset_target()

    
    draw_set_projection(0, 0)
    
    var _open = 0
    with Loadout _open = ceil(1-(max(0,openanim)/4))
    
    draw_surface_part(global.menu_surf_art,0,36,game_width,game_height-72,0,36)	//-(game_width*1.2)*menu_anim
    draw_surface(global.menu_surf_text,-game_width*(menu_anim*1.2),(-14*floor((instance_number(CharSelect)-1)/fitchar))*_open)

    draw_reset_projection()
    
    	
//tabs
with Loadout{
	
    draw_set_projection(0, 0)
	draw_set_color(c_white)
	draw_set_halign(1)
	draw_set_valign(1)
	//var xx = 64 -game_width +(game_width*menu_anim);
	//var yy = 32;
	//var _text = "-daily-"
	//var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	//
	//if mouse_over and button_pressed(0,"fire"){
	//    //click
	//    global.current_scoreboard = 0
	//    scoreboard_opened = -4
	//}
	//var _active = global.current_scoreboard = 0
	//draw_set_color((mouse_over or _active)?c_white:c_silver)
	//draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	//
	//
	//xx+= max(string_length(_text)*8,64)
	//var _text = "-daily-#modded"
	//mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	//
	//if mouse_over and button_pressed(0,"fire"){
	//    //click
	//    global.current_scoreboard = 1
	//    scoreboard_opened = -4
	//}
	//var _active = global.current_scoreboard = 1
	//draw_set_color((mouse_over or _active)?c_white:c_silver)
	//draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	//var _text = "-daily-"   //jank to reset spacing without slicing the string
	//
	//
	//xx+= max(string_length(_text)*8,64)
	//var _text = "-weekly-#modded"
	//var _active = global.current_scoreboard = 2
	//mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	//
	//if mouse_over and button_pressed(0,"fire"){
	//    //click
	//    global.current_scoreboard = 2
	//    scoreboard_opened = -4
	//}
	//var _active = global.current_scoreboard = 2
	//draw_set_color((mouse_over or _active)?c_white:c_silver)
	//draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	
	
	draw_set_halign(0)
	draw_set_valign(1)
	draw_set_color(c_white)	
	   
	//scoreboard scroll buttons
	//var xx = 16 -game_width +(game_width*menu_anim);
	//var yy = 36;
	//var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-12,yy-12,xx+12,yy+12)
	//
	//if mouse_over and button_check(0,"fire"){
	//    //click
	//    scoreboard_pos[global.current_scoreboard] -=1
	//}
	//draw_set_color((mouse_over)?c_white:c_silver)
	//var _render = (scoreboard_pos[global.current_scoreboard] != 0)
	//draw_sprite_ext(sprLoadoutArrow,0,xx,yy-mouse_over,1,1,0,_render? ((mouse_over)?c_white:c_silver):c_dkgray,1)
	
	var yy= game_height-44
	var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-12,yy-12,xx+12,yy+12)
	
	if ((mouse_over and button_check(0,"fire")) or button_check(0,"sout")) and scroll_interval{
	    //click
	    sound_play(sndClickBack)
	    scoreboard_pos[global.current_scoreboard] += 1
	}
	var _render = (scoreboard_pos[global.current_scoreboard] != array_length(global.scoreboard[global.current_scoreboard])-scoreboard_number_of_rows)
	draw_sprite_ext(sprLoadoutArrow,1,xx,yy-mouse_over,1,1,0,_render? ((mouse_over)?c_white:c_silver):c_dkgray,1)
	
	
	scoreboard_pos[global.current_scoreboard] = clamp(scoreboard_pos[global.current_scoreboard],0,array_length(global.scoreboard[global.current_scoreboard])-scoreboard_number_of_rows )
	
	//if scoreboard_opened>(scoreboard_pos[global.current_scoreboard]+scoreboard_number_of_rows) or scoreboard_opened<scoreboard_pos[global.current_scoreboard]
	//    scoreboard_opened = -4
   
    draw_reset_projection()
}
    
    
    
    
    
}
#define draw_gui

with Menu
with Loadout{
if selected menu_opened = false
//daily button
if array_length(instances_matching(CustomObject,"name","mod_ui_daily_button"))<1{
    with instance_create(game_width-24,7,CustomObject){
        name = "mod_ui_daily_button";
        sprite_index = sprDailyChallengeOn;
        image_speed = 0;
        depth = 0;
        yoffset = 1;
        visible = 0
        image_alpha = 0.6;
        xstart = x
        ystart = y
        if fork(){
        while instance_exists(self){
            var hover = 0;
            x = game_width-24
            var _loadout = false
            with Loadout if selected _loadout = true
            
            //y = ystart - 210*menu_anim - 64*_loadout
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
                    	sound_play(menu_opened=true ? sndClickBack:sndClick)
                        menu_opened = menu_opened=true ? false:true
                        //exit;
                        
                    }
                    hover = 1;
                }
            }
            image_index = menu_opened
            if hover = 1{
                //image_speed = 0.4;
                image_blend = c_white;
                image_alpha = 1;
                yoffset = -1;
            }
            else{
    			//if image_index+image_speed>=image_number or image_index<4{
    			//	image_index = 0;
    			//	image_speed = 0;
    			//}
    			
                image_blend = c_silver;
                image_alpha = 0.6;
                yoffset = 0;
            }
            if _loadout{
            	image_blend = c_dkgray
            }
            
            
            wait 0;
        }
        exit;
        }
    }
}


//if menu_opening[0] != 0{
//    with Menu {
//        var _my = (game_height-32)-250*menu_anim
//        visible = 0
//        script_bind_draw(menu_draw,-1000,_my);
//        
//    }
//}


	//moveable camera
	//{
//	var move_campfire = false
//	for(var i = 0;i<3;i++){
//		if point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i],view_yview[i]+32,view_xview[i]+game_width,view_yview[i]+game_height-32)
//			and button_check(i,"fire") and !instance_exists(Spiral){
//
//				with Campfire{
//					mask_index = mskNone;
//					var dist = point_distance(mouse_x[i],mouse_y[i],xstart,ystart)*0.8
//					var dir = point_direction(xstart,ystart,mouse_x[i],mouse_y[i])
//					x = xstart+lengthdir_x(dist,dir)
//					y = ystart+lengthdir_y(dist,dir)
//				}
//			}
//		if player_get_race_id(i) = 0 and player_is_active(i)
//				move_campfire = true;
//		if button_pressed(i,"spec")
//		with instances_matching(Campfire,"mask_index",mskNone){
//			x= xstart
//			y= ystart
//			mask_index = -1;
//		}
//	}
//	if move_campfire = false
//	with instances_matching(Campfire,"mask_index",mskNone){
//		x= xstart
//		y= ystart
//		mask_index = -1;
//	}
//	  //timeout
//	//if move_campfire = false
//	//if fork(){
//	//	with instances_matching(Campfire,"mask_index",mskNone){
//	//		wait 24
//	//		if instance_exists(self) and mask_index = mskNone{
//	//			x= xstart
//	//			y= ystart
//	//			mask_index = -1;
//	//		}
//	//	}
//	//exit;
//	//}
//}
	



//GO button
if array_length(instances_matching(CustomObject,"name","mod_ui_superbutton"))<1{
    	
		//shuffle the wastelandkings
    	with instances_matching_le(CampChar,"num",4){
    		var _dist = 4
    		var _x = random_range(-_dist,_dist);
    		var _y = random_range(-_dist,_dist);
    		xstart += _x;
    		if num != 1
    			ystart += _y;
    		else
    			with LogMenu{
    				spr_shadow_x += _x;
    			}
    		y = ystart
    		x = xstart
    	}
    	//swap eyes and crystal
    	if !irandom(2){
    		with instances_matching(CampChar,"num",2){
    			with instances_matching(CampChar,"num",3){
    				var _x = x,
    				_y = y;
    				x=other.x;
    				y= other.y;
    				other.x=_x;
    				other.y=_y;
    				image_xscale = choose(1,-1);
    				other.image_xscale = choose(-1,1)
    			}
    		}	
    	}
    	//swap eyes and melting
    	if !irandom(2){
    		with instances_matching(CampChar,"num",4){
    			with instances_matching(CampChar,"num",3){
    				var _x = x,
    				_y = y;
    				x=other.x;
    				y= other.y;
    				other.x=_x;
    				other.y=_y;
    				image_xscale = -1;
    			}
    		}	
    	}
    	//swap crystal and melting
    	if !irandom(2){
    		with instances_matching(CampChar,"num",4){
    			with instances_matching(CampChar,"num",2){
    				var _x = x,
    				_y = y;
    				x=other.x;
    				y= other.y;
    				other.x=_x;
    				other.y=_y;
    				image_xscale = choose(-1,1)
    			}
    		}	
    	}
    	//swap melting and plant
    	if !irandom(5) and race_get_active(5){
    		with instances_matching(CampChar,"num",4){
    			with instances_matching(CampChar,"num",5){
    				var _x = x,
    				_y = y;
    				x=other.x;
    				y= other.y;
    				other.x=_x;
    				other.y=_y;
    			}
    		}	
    	}
    	//swap crystal and plant
    	if !irandom(5) and race_get_active(5){
    		with instances_matching(CampChar,"num",2){
    			with instances_matching(CampChar,"num",5){
    				var _x = x,
    				_y = y;
    				x=other.x;
    				y= other.y;
    				other.x=_x;
    				other.y=_y;
    			}
    		}	
    	}
    	
    	with CampChar{
    		xstart = x
    		ystart = y
    		//image_alpha = 0
    	}
    	
        with instance_create(10000,10000,CustomObject){
            name = "mod_ui_superbutton";
            sprite_index = sprGoButton;
            image_speed = 0;
            depth = 0;
            yoffset = 1;
            visible = false;
            image_alpha = 0.6;
            timer = 0;
            if fork(){
            while instance_exists(self){
                //with BackFromCharSelect{
                //    other.visible = visible
                //    with Loadout
                //        visible = other.visible
                //}
                timer ++
                
                if GameCont.area != 0 {
                    instance_delete(id)
                    exit
                    
                }
                
                if visible = false{
                	if timer > 12{
                		for(var p = 0;p<4;p++){
                			if player_get_race_id(p) != 0
                				visible = true; 
                		}
                	}
                }
                else{
                var hover = 0;
                for(var i=0;i<maxp;i++){
                    if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+game_width-sprite_get_width(sprGoButton)-10,view_yview[i]+game_height-31,view_xview[i]+game_width-10,view_yview[i]+game_height-31+sprite_get_height(sprGoButton)){
                        if button_pressed(i,"fire"){
                            script_bind_end_step(go,-1000);
                            exit;
                            
                        }
                        hover = 1;
                    }
                }
                if hover = 1{
                    image_speed = 0.4;
                    image_blend = c_white;
                    image_alpha = 1;
                    yoffset = -1;
                }
                else{
					if image_index+image_speed>=image_number or image_index<4{
						image_index = 0;
						image_speed = 0;
					}
                    image_blend = c_white;
                    image_alpha = 0.6;
                    yoffset = 0;
                }
                	
                }
                wait 0;
            }
            exit;
            }
        }
    }
//backbutton
with instances_matching(BackFromCharSelect,"mod_ui",null){
		if array_length(instances_matching(CustomObject,"name","mod_ui_backbutton"))=0
		
    	with instance_create(0,0,CustomObject){
    		name = "mod_ui_backbutton";
    		sprite_index = global.sprBackIntro;
    		image_alpha = 0.6;
            image_speed = 0.4;
            image_index = 0;
            depth = 0;
            visible = false;
            yoffset = 0;
    		holdcounter = 0;
    		holdcountermax = holdbackdelay;
    		if fork(){
    			while instance_exists(self){
    				if sprite_index = global.sprBackIntro{
    					image_speed = 0.4;
    					if image_index+image_speed>=image_number
    						sprite_index = global.sprBackButton;
    				}
    				else{
                    	var hover = 0;
                    	var pushing = false;
                    	for(var i=0;i<maxp;i++){
    						if point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i],view_yview[i],view_xview[i]+28,view_yview[i]+28  - 210*menu_anim){
	    						hover = 1;
	    						if button_check(i,"fire"){
	    							holdcounter += 1;
	    							pushing = true;
	    						}
    						}
    						if button_check(i,"spec"){
    							holdcounter += 1;
    							hover = 1;
	    						pushing = true;
    						}
	    					if player_is_local_nonsync(i) and holdcounter > holdcountermax{
	    						
								script_bind_step(force_quit,0)
	    						//global.enditall = true
	    						exit;
	    					}
	    				}
    					if hover{
    						image_speed = 0.4;
    						image_alpha = 1;
    						visible = false;
            				yoffset = -1*(!pushing);
    					}
    					else{
    						if image_index+image_speed>=image_number or image_index<2{
    							image_index = 0;
    							image_speed = 0;
    						}
    						image_alpha = 0.6;
            				yoffset = 0;
    					}
    					if pushing{
    						image_index = 0;
    						image_speed = 0;
    					}else{
    						holdcounter = max(holdcounter-(2),0);
    					}
    				}
    				wait 1;
    			}
    			exit;
    		}
    	}
    	ystart-=64
    	mod_ui = true
    } 

//draw buttons
with Loadout{
	//draw go button
	with instances_matching(CustomObject,"name","mod_ui_superbutton"){
	    if visible
		draw_sprite_ext(sprite_index,image_index,game_width-45,game_height-31+yoffset,1,1,0,image_blend,image_alpha);
	}
	//draw back button
	with instances_matching(CustomObject,"name","mod_ui_backbutton"){
	    x = 16;
	    y = 20;
		draw_sprite_ext(sprite_index,image_index,x  - 80*menu_anim,y+yoffset-32*menu_anim,1,1,360*(max(0,holdcounter-3)/(holdcountermax-3)),image_blend,image_alpha);
	}
	//draw daily button
	with instances_matching(CustomObject,"name","mod_ui_daily_button"){
		draw_sprite_ext(sprite_index,image_index,x,y+yoffset,1,1,0,image_blend,1);
	} 
}


//bigdog sprites		
with instances_matching(CampChar,"num",13){
    if "go_setsprites" not in self or go_setsprites = null{
        with instance_create(x,y,PortalClear){ image_xscale = 2; image_yscale = 2 }
        
        	spr_slct =  sprScrapBossSleep;
        	spr_to =    sprScrapBossIntro;
        	spr_from =  sprScrapBossHurt;
        	spr_menu =  sprScrapBossIdle;
        	spr_shadow = shd96;
        	sprite_index =  spr_slct;
        go_setsprites = true;
    }
} 
		
//respawn skeleton
if race_get_active(char_skeleton) and array_length(instances_matching(CampChar,"num",14))=0{
	with Campfire{
		with instance_create(x,y,CampChar){
			var _tries = 1000;
			while(_tries-- > 0){
				x = xstart;
				y = ystart;
				move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
				x = round(x);
				y = round(y);
				
				 // Safe:
				if(!collision_circle(x, y, 12, CampChar, true, true) && !place_meeting(x, y, TV) && !place_meeting(x, y, Campfire)){
					break;
				}
			}
			num = 14
			xstart=x ;
			ystart=y ;
		}
	}
}	
//respawn frog
if race_get_active(char_frog) and array_length(instances_matching(CampChar,"num",15))=0{
	with Campfire{
		with instance_create(x,y,CampChar){
			var _tries = 1000;
			while(_tries-- > 0){
				x = xstart;
				y = ystart;
				move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
				x = round(x);
				y = round(y);
				
				 // Safe:
				if(!collision_circle(x, y, 12, CampChar, true, true) && !place_meeting(x, y, TV) && !place_meeting(x, y, Campfire)){
					break;
				}
			}
			num = 15
			xstart=x ;
			ystart=y ;
        	spr_slct =  sprMutant15Walk;
        	spr_to =    sprMutant15Walk;
        	spr_from =  sprMutant15Walk;
        	spr_menu =  sprMutant15Walk;
        	sprite_index =  spr_menu;
        	direction = irandom(360)
		}
	}
}
//respawn bigdog
if race_get_active(char_bigdog) and array_length(instances_matching(CampChar,"num",13))=0{
	with Campfire{
		with instance_create(x,y,CampChar){
			var _tries = 1000;
			while(_tries-- > 0){
				x = xstart;
				y = ystart;
				move_contact_solid(random(360), random_range(32, 64) + random(random(64)));
				x = round(x);
				y = round(y);
				
				 // Safe:
				if(!collision_circle(x, y, 36, CampChar, true, true) && !place_meeting(x, y, TV) && !place_meeting(x, y, Campfire)){
					break;
				}
			}
			num = 13
			xstart=x ;
			ystart=y ;
		}
	}
}

//frog, dont walk through the fire
with instances_matching(CampChar,"num",char_frog){
	if instance_exists(Campfire)
		and distance_to_point(Campfire.xstart,Campfire.ystart)<24 and !irandom(2){
			direction = point_direction(x,y,Campfire.xstart,Campfire.ystart)-90
		}
}
	
//makes the first 4 races hidden if they are not unlocked
with Menu{
//mimics how the game handles others by only removing them on reloading the campfire
    if "hide_races" not in self{
		with instances_matching_le(CampChar,"num",4){
			if !race_get_active(num) instance_destroy();
		}
		hide_races = true;
	}

}
	
//tabs
with Loadout{
	
    //draw_set_projection(0, 0)
	draw_set_color(c_white)
    draw_set_font(fntM)
	draw_set_halign(1)
	draw_set_valign(1)
	var xx = 64 -game_width +(game_width*menu_anim);
	var yy = 32;
	var _text = "-daily-"
	var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	
	if mouse_over and button_pressed(0,"fire"){
	    //click
	    global.current_scoreboard = 0
	    scoreboard_opened = -4
	}
	var _active = global.current_scoreboard = 0
	draw_set_color((mouse_over or _active)?c_white:c_silver)
	draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	
	
	xx+= max(string_length(_text)*8,64)
	var _text = "-daily-#modded"
	mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	
	if mouse_over and button_pressed(0,"fire"){
	    //click
	    global.current_scoreboard = 1
	    scoreboard_opened = -4
	}
	var _active = global.current_scoreboard = 1
	draw_set_color((mouse_over or _active)?c_white:c_silver)
	draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	var _text = "-daily-"   //jank to reset spacing without slicing the string
	
	
	xx+= max(string_length(_text)*8,64)
	var _text = "-weekly-#modded"
	var _active = global.current_scoreboard = 2
	mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-24,yy-12,xx+24,yy+12)
	
	if mouse_over and button_pressed(0,"fire"){
	    //click
	    global.current_scoreboard = 2
	    scoreboard_opened = -4
	}
	var _active = global.current_scoreboard = 2
	draw_set_color((mouse_over or _active)?c_white:c_silver)
	draw_text(xx,yy-mouse_over-(button_pressed(0,"fire")*-2*_active*mouse_over),_text)
	
	
	draw_set_halign(0)
	draw_set_valign(1)
	draw_set_color(c_white)	
	   
	//scoreboard scroll buttons
	var xx = 16 -game_width +(game_width*menu_anim);
	var yy = 36;
	var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-12,yy-12,xx+12,yy+12)
	
	if ((mouse_over and button_check(0,"fire")) or button_check(0,"nort")) and scroll_interval{
	    //click
	    sound_play(sndClickBack)
	    scoreboard_pos[global.current_scoreboard] -=1
	}
	draw_set_color((mouse_over)?c_white:c_silver)
	var _render = (scoreboard_pos[global.current_scoreboard] != 0)
	draw_sprite_ext(sprLoadoutArrow,0,xx,yy-mouse_over,1,1,0,_render? ((mouse_over)?c_white:c_silver):c_dkgray,1)
	
	//yy= game_height-44
	//var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx-12,yy-12,xx+12,yy+12)
	//
	//if mouse_over and button_check(0,"fire"){
	//    //click
	//    scoreboard_pos[global.current_scoreboard] +=1
	//}
	//var _render = (scoreboard_pos[global.current_scoreboard] != array_length(global.scoreboard[global.current_scoreboard])-scoreboard_number_of_rows)
	//draw_sprite_ext(sprLoadoutArrow,1,xx,yy-mouse_over,1,1,0,_render? ((mouse_over)?c_white:c_silver):c_dkgray,1)
	
	
	scoreboard_pos[global.current_scoreboard] = clamp(scoreboard_pos[global.current_scoreboard],0,array_length(global.scoreboard[global.current_scoreboard])-scoreboard_number_of_rows )
	
	//if scoreboard_opened>(scoreboard_pos[global.current_scoreboard]+scoreboard_number_of_rows) or scoreboard_opened<scoreboard_pos[global.current_scoreboard]
	//    scoreboard_opened = -4
   
    draw_reset_projection()
}
}
#define ui_popup_draw(_x,_y,_text)
draw_set_projection(0,0)
draw_tooltip(_x,_y,_text)
draw_reset_projection()
	instance_delete(id)
#define menu_draw(_y)


with Menu{
	visible = 1
	var yy = game_height;
	game_height = (yy-(yy-_y))+32;
	draw_set_color(c_black);
	draw_rectangle(view_xview_nonsync,view_yview_nonsync+_y-4,view_xview_nonsync+game_width,view_yview_nonsync+yy,0);
	//trace(_y,yy,game_height);
	event_perform(ev_draw,0);
	game_height = yy;
	visible = 0;
}
instance_delete(id);


#define step

//stacking character select icons
if GameCont.timer = 0
with Loadout{
	//for(var i=0;i<maxp;i++){
    //	if player_is_local_nonsync(i){
    //		if button_pressed(i,"spec") {
    //			with Loadout{
    //				selected = 0
    //				with LoadoutCrown instance_destroy()
    //				with LoadoutWep instance_destroy()
    //				with LoadoutSkin instance_destroy()
    //				with LoadoutSelect instance_destroy()
    //			}
    //		}
    //	}
    //}





	//modded ones get a num
    with instances_matching(CharSelect,"ui_num",null){
        ui_num = array_length(instances_matching_lt(CharSelect,"id",id))
    }
    
	var lowestystart = noone;
	with instances_matching(CharSelect,"num",0)
		lowestystart = self;
    //var spacing = max(32-min(fitchar,instance_number(CharSelect)-(1*instance_number(CharSelect) = 13))-((320-game_width)/10),(22*(game_height/game_width)));
  
    	
    	//fitchar ceil(( (game_width-72)-8 )/(22*(game_height/game_width)))
    var spacing = 
    	max(
    		32-min(fitchar,instance_number(CharSelect)-(1*instance_number(CharSelect) = 13))	-((320-game_width)/24)
    		,
    		17
    		);
    
    with instances_matching(CharSelect,"visible",0) ystart = game_height*2;
	with instances_matching(CharSelect,"visible",1){
	
       ui_num = array_length(instances_matching_lt(CharSelect,"id",id));
		
    	xstart = (8)+(	((ui_num-(1*(ui_num>fitchar))) mod (fitchar-(1*(ui_num>fitchar))))+(1*(ui_num>=fitchar))	)*spacing;
    //	xstart = (8)+(	((num-(1*(num))) mod (fitchar-(1*(num>fitchar))))+(1*(num>=fitchar))	)*spacing;
    //	xstart = (8)+(	((num-(1*(num))) mod (fitchar-(1*(num>fitchar))))+(1*(num>=fitchar))	)*spacing;
    	ystart = (game_height-30) - (25)*( floor((ui_num-(1*(ui_num>fitchar)))/(fitchar-(1*(ui_num>fitchar)))	))*global.stack
					*min(1-(menu_anim*0.8),(1-((Loadout.openanim/5)*Loadout.selected)));
		//ystart = (game_height-30) - 25*( floor((num-(1*(num>fitchar)))/(fitchar-(1*(num>fitchar)))	));
		if ystart<lowestystart.ystart
			lowestystart = self;
		depth = -1100+(game_height-ystart)/5;
		
	}
	
    var maxnum = instance_number(CharSelect)
	//if global.stack = -1{
	//	if maxnum>fitchar
	//	with instances_matching(CharSelect,"visible",1){
	//		ystart -= (25-(12.5*(num=0)))*( floor((maxnum)/(fitchar)))*min(1-(menu_anim*0.8),(1-((Loadout.openanim/5)*Loadout.selected)));
	//		if ystart<lowestystart.ystart
	//			lowestystart = self;
	//		depth = -1100+(game_height-ystart)/5;;
	//	}
	//}
	//else 
	with instances_matching(CharSelect,"num",0)
		ystart -= (25-(12.5*(num=0)))*( floor((maxnum-1)/(fitchar)))*min(1-(menu_anim*0.8),(1-((Loadout.openanim/5)*Loadout.selected)));
    
    //redraw the menu
    //with lowestystart{
    //	if num > 0
    //	with Menu visible = 0;
    //	script_bind_draw(menu_draw,-1000,ystart);
    //}
    

	// skin buttons
	if !global.ntte{
	//script_bind_begin_step(begin_step,0);
	//-1099929800824324160 = the last depth that draws above all
	
		//ntte and having 2+ rows of skins crashes. my guess is ntte setting xstart every frame to account for the extra crowns, causing a infinite loop with this
		if selected {
		    
		    //loop through each column moving them to the next if they go below line
		    while array_length( instances_matching_lt(LoadoutSkin,"ystart",topheight) ) != 0
		        for(var i = game_width-134;i>0;i-=32){
		        if array_length( instances_matching_lt(instances_matching(LoadoutSkin,"xstart",i),"ystart",topheight) )!=0
		            with instances_matching(LoadoutSkin,"xstart",i){
		                if ystart>botheight{
		                    xstart -= 32;
		                    ystart -= (fitskins*28)+1;
		                }else
		                    ystart++;
		            }
		        }
		    //draw custom backsplat if needed
		    if array_length( instances_matching_lt(LoadoutSkin,"xstart",game_width-134) ) != 0{
		        var splashwidth = game_width-134;
		        for(var i = game_width-134;i>0;i-=32)
		            with instances_matching(LoadoutSkin,"xstart",i){
		                splashwidth = i;
		                //trace(xstart)
		                continue;
		            }
		        script_bind_draw(draw_splat,-1002,(game_width-134)-splashwidth-12)
		    }
		    else
		    if !instance_exists(LoadoutSkin){
		    	script_bind_draw(draw_splat,-1002,-50);
		    } 
		} 
	}
}
//drawing bg splat for skin icons
#define draw_splat(_w)
    with Loadout{
        //
        visible = 0;
        if openanim = 0 or "stretch" not in self stretch = 0;
        openanim = min(openanim+1,4);
        stretch = min(stretch+24-24*(stretch/_w),_w);
        var o = game_width/4;
        var w = -stretch;
        draw_sprite_stretched(sprLoadoutOpen,min(openanim,4),view_xview_nonsync+64+o,view_yview_nonsync+game_height/6.9,game_width-64,game_height-(game_height/3.4));
        draw_sprite_stretched(sprLoadoutOpen,min(openanim,4),view_xview_nonsync+64+w,view_yview_nonsync+game_height/6.9,game_width-64+stretch/3,game_height-(game_height/3.4));
    
        if fork(){
            wait 1;
            if !instance_exists(self) exit;
            visible = 1;
            exit;
        }
    }    
instance_delete(id);

#define begin_step
script_bind_end_step(begin_hide	,	10000);
script_bind_draw(end_unhide		,	-10010);




instance_delete(id);
	
#define begin_hide
draw_set_blend_mode(bm_normal) ;
draw_set_fog(0,c_black,1,1);
instance_delete(id);

#define end_unhide
if global.hidenumber>0{
	draw_set_fog(1,c_black,1,1);
	draw_set_blend_mode(bm_add);
	
}
draw_set_alpha(0);
instance_delete(id);
#define array_shuffle(list)
var _list = list;
for (var i = 0; i < array_length(_list); i++) 
	{
		var temp = _list[i];
		var randomIndex = random_range(i, array_length(_list));
		_list[i] = _list[randomIndex];
		_list[randomIndex] = temp;
	}
return _list;



#define get_mapsprite(race,skin)
var sprt = [sprMapIcon,0]
if is_string(race){
    sprt = [global.mod_mapicon,0]
    if mod_exists("race",race) and mod_script_exists("race",race,"race_mapicon"){
        sprt[0] = mod_script_call("race",race,"race_mapicon");
        sprt[1] = 0
        //i dont know how to make it use the skin if the sprite is or isnt a sprite strip
    }
	if race_get_id(race) > 0 && race_get_id(race) <= 16 {
		race = race_get_id(race)
	}
}
if !is_string(skin){
    if !is_string(race)
        sprt = [sprMapIcon,(race*2)+(skin)-2]
    else
    	sprt[1] = skin
}else if mod_exists("skin",skin){
    sprt[0] = mod_script_call("skin",skin,"skin_mapicon")
    sprt[1] = 0
}



return sprt;
#define get_charsprite(race)
var sprt = [sprCharSelect,0]
if is_string(race){
    sprt = [global.mod_charselect,0]
    if mod_exists("race",race){
        with instance_create(0,0,CustomObject){
            mod_script_call("race",race,"race_menu_button")
            sprt[0] = sprite_index
            instance_delete(id)
        }
        
        sprt[1] = 0
        //i dont know how to make it use the skin if the sprite is or isnt a sprite strip
    }
}else{
    sprt = [sprCharSelect,race]
}

return sprt;

#define get_crownsprite(_crown)
var c = sprCrown1Walk;
switch(_crown){
    case(1): c = sprCrown1Walk break;
    case(2): c = sprCrown2Walk break;
    case(3): c = sprCrown3Walk break;
    case(4): c = sprCrown4Walk break;
    case(5): c = sprCrown5Walk break;
    case(6): c = sprCrown6Walk break;
    case(7): c = sprCrown7Walk break;
    case(8): c = sprCrown8Walk break;
    case(9): c = sprCrown9Walk break;
    case(10): c = sprCrown10Walk break;
    case(11): c = sprCrown11Walk break;
    case(12): c = sprCrown12Walk break;
    case(13): c = sprCrown13Walk break;
    default: if mod_exists("crown",_crown)
            with instance_create(0,0,CustomObject){
                mod_script_call("crown",_crown,"crown_object")
                if "spr_walk" in self c = spr_walk
                else if "spr_idle" in self c = spr_idle
                else c = sprite_index
                
                instance_delete(id)
            }
            break;
}
return c;


   
#define _area_get_name(_area)
var a = _area
switch(_area){
	case(1):a = "desert" break;
	case(2):a = "sewers" break;
	case(3):a = "scrapyard" break;
	case(4):a = "crystal caves" break;
	case(5):a = "frozen city" break;
	case(6):a = "labs" break;
	case(7):a = "palace" break;
	case(100):a = "vault" break;
	case(101):a = "oasis" break;
	case(102):a = "pizza" break;
	case(103):a = "venuz" break;
	case(104):a = 
	string(choose("c","c","c","c","c","c","c","c","*","!","^","q","r","a","]","\","+"))+
	string(choose("r","r","r","r","r","r","r","r","q","4","^","q","r","a","]","\","+"))+
	string(choose("y","y","y","y","y","y","y","y","q","4","a","4","\","4",",",">","F"))+
	string(choose("s","s","s","s","s","s","s","s","q","4","a","4","-","*","\","+"))+
	string(choose("t","t","t","t","t","t","t","t","4","\","4",",",">","F","\","+"))+
	string(choose("a","a","a","a","a","a","a","a","q","4","a","4","\","4",",",">","F","-"))+
	string(choose("l","l","l","l","l","l","l","l","q","4","a","]","\","+"))+
	" "+
	string(choose("c","c","c","c","c","c","c","c","\","4",",",">","F","]","\","+"))+
	string(choose("a","a","a","a","a","a","a","a","q","-","*","!","^","q","r","a","]","\"))+
	string(choose("v","v","v","v","v","v","v","v","q","F","-","*","!","^"))+
	string(choose("e","e","e","e","e","e","e","e","q","-","*","!","^","q","r","a"))+
	string(choose("s","s","s","s","s","s","s","s","q","4","q","r","a","]","\","+"))
		 break;
	case(105):a = "jungle" break;
	case(106):a = "IDPD HQ" break;
	case(107):a = "venuz" break;
}
return a;
#define chat_command
if(argument0 = "fps"){
	if real(argument1) > 0{
		room_speed = real(argument1);
		current_time_scale = 30/room_speed;
	}
    return true;
}    
if(argument0 = "frog"){
    global.frog = global.frog ? false : true;
    if global.frog 
		race_set_active(15,1);
    else{
    	race_set_active(15,0);
    	with instances_matching(CampChar,"num",15) instance_delete(id);
    }
    return true;
}
if(argument0 = "skel"){
    global.skel = global.skel ? false : true;
    if global.skel 
		race_set_active(14,1);
    else{
    	race_set_active(14,0);
    	with instances_matching(CampChar,"num",14) instance_delete(id);
    }
    return true;
}
if(argument0 = "bdog" or argument0 = "bigdog" or argument0 = "dog"){
    global.bdog = global.bdog ? false : true;
    if global.bdog{
		race_set_active(13,1);
        with instance_create(-10000,-10000,ScrapBoss) instance_destroy()
    }
    else
    	race_set_active(13,0);
    return true;
}

if(argument0 = "portraits"){
    global.hideportraits = global.hideportraits ? false : true;
    if global.hideportraits 
		sprite_replace(sprBigPortrait,"sprites/blank_strip3.png",0,0,0);
    else{
    	sprite_restore(sprBigPortrait);
    }
    return true;
}


#define cleanup

sprite_restore(sprBackButton);
sprite_restore(sprBigPortrait);
//sprite_restore(sprLoadoutSplat);

with instances_matching_ne(BackFromCharSelect,"mod_ui",null) mod_ui = null

reset_surfaces();

#define reset_surfaces   
surface_destroy(global.menu_surf_art);
surface_destroy(global.menu_surf_splat);
surface_destroy(global.menu_surf_splat2);
surface_destroy(global.menu_surf_text);
surface_free(global.menu_surf_art)
surface_free(global.menu_surf_splat)
surface_free(global.menu_surf_splat2)
surface_free(global.menu_surf_text)

#define killed_by(_cause)
	/*
		Returns the death cause associated with a given index as an array containing [Sprite, Name]
	*/
	
	_cause = floor(_cause);
	
	 // Normal:
	var _loc = `CauseOfDeath:${_cause}`;
	switch(_cause){
		case   0 : return [sprBanditIdle,           loc(_loc, "bandit"                                              )];
		case   1 : return [sprMaggotIdle,           loc(_loc, "maggot"                                              )];
		case   2 : return [sprRadMaggot,            loc(_loc, "rad maggot"                                          )];
		case   3 : return [sprBigMaggotIdle,        loc(_loc, "big maggot"                                          )];
		case   4 : return [sprScorpionIdle,         loc(_loc, "scorpion"                                            )];
		case   5 : return [sprGoldScorpionIdle,     loc(_loc, "golden scorpion"                                     )];
		case   6 : return [sprBanditBossIdle,       loc(_loc, "big bandit"                                          )];
		case   7 : return [sprRatIdle,              loc(_loc, "rat"                                                 )];
		case   8 : return [sprRatkingIdle,          loc(_loc, "big rat"                                             )];
		case   9 : return [sprFastRatIdle,          loc(_loc, "green rat"                                           )];
		case  10 : return [sprGatorIdle,            loc(_loc, "gator"                                               )];
		case  11 : return [sprExploderIdle,         loc(_loc, "frog"                                                )];
		case  12 : return [sprSuperFrogIdle,        loc(_loc, "super frog"                                          )];
		case  13 : return [sprFrogQueenIdle,        loc(_loc, "mom"                                                 )];
		case  14 : return [sprMeleeIdle,            loc(_loc, "assassin"                                            )];
		case  15 : return [sprRavenIdle,            loc(_loc, "raven"                                               )];
		case  16 : return [sprSalamanderIdle,       loc(_loc, "salamander"                                          )];
		case  17 : return [sprSniperIdle,           loc(_loc, "sniper"                                              )];
		case  18 : return [sprScrapBossIdle,        loc(_loc, "big dog"                                             )];
		case  19 : return [sprSpiderIdle,           loc(_loc, "spider"                                              )];
		case  20 : return [sprBanditIdle,           loc(_loc, "new cave thing"                                      )];
		case  21 : return [sprLaserCrystalIdle,     loc(_loc, "laser crystal"                                       )];
		case  22 : return [sprHyperCrystalIdle,     loc(_loc, "hyper crystal"                                       )];
		case  23 : return [sprSnowBanditIdle,       loc(_loc, "snow bandit"                                         )];
		case  24 : return [sprSnowBotIdle,          loc(_loc, "snowbot"                                             )];
		case  25 : return [sprWolfIdle,             loc(_loc, "wolf"                                                )];
		case  26 : return [sprSnowTankIdle,         loc(_loc, "snowtank"                                            )];
		case  27 : return [sprLilHunter,            loc(_loc, "lil hunter"                                          )];
		case  28 : return [sprFreak1Idle,           loc(_loc, "freak"                                               )];
		case  29 : return [sprExploFreakIdle,       loc(_loc, "explo freak"                                         )];
		case  30 : return [sprRhinoFreakIdle,       loc(_loc, "rhino freak"                                         )];
		case  31 : return [sprNecromancerIdle,      loc(_loc, "necromancer"                                         )];
		case  32 : return [sprTurretIdle,           loc(_loc, "turret"                                              )];
		case  33 : return [sprTechnoMancer,         loc(_loc, "technomancer"                                        )];
		case  34 : return [sprGuardianIdle,         loc(_loc, "guardian"                                            )];
		case  35 : return [sprExploGuardianIdle,    loc(_loc, "explo guardian"                                      )];
		case  36 : return [sprDogGuardianWalk,      loc(_loc, "dog guardian"                                        )];
		case  37 : return [sprNothingOn,            loc(_loc, "throne"                                              )];
		case  38 : return [sprNothing2Idle,         loc(_loc, "throne II"                                           )];
		case  39 : return [sprBoneFish1Idle,        loc(_loc, "bonefish"                                            )];
		case  40 : return [sprCrabIdle,             loc(_loc, "crab"                                                )];
		case  41 : return [sprTurtleIdle,           loc(_loc, "turtle"                                              )];
		case  42 : return [sprMolefishIdle,         loc(_loc, "molefish"                                            )];
		case  43 : return [sprMolesargeIdle,        loc(_loc, "molesarge"                                           )];
		case  44 : return [sprFireBallerIdle,       loc(_loc, "fireballer"                                          )];
		case  45 : return [sprSuperFireBallerIdle,  loc(_loc, "super fireballer"                                    )];
		case  46 : return [sprJockIdle,             loc(_loc, "jock"                                                )];
		case  47 : return [sprInvSpiderIdle,        loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qs@qp@qi@qd@qe@qr"             )];
		case  48 : return [sprInvLaserCrystalIdle,  loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qc@qr@qy@qs@qt@qa@ql"          )];
		case  49 : return [sprMimicTell,            loc(_loc, "mimic"                                               )];
		case  50 : return [sprSuperMimicTell,       loc(_loc, "health mimic"                                        )];
		case  51 : return [sprGruntIdle,            loc(_loc, "grunt"                                               )];
		case  52 : return [sprInspectorIdle,        loc(_loc, "inspector"                                           )];
		case  53 : return [sprShielderIdle,         loc(_loc, "shielder"                                            )];
		case  54 : return [sprOldGuardianIdle,      loc(_loc, "crown guardian"                                      )];
		case  55 : return [sprExplosion,            loc(_loc, "explosion"                                           )];
		case  56 : return [sprSmallExplosion,       loc(_loc, "small explosion"                                     )];
		case  57 : return [sprTrapGameover,         loc(_loc, "fire trap"                                           )];
		case  58 : return [sprShielderShieldAppear, loc(_loc, "shield"                                              )];
		case  59 : return [sprToxicGas,             loc(_loc, "toxic"                                               )];
		case  60 : return [sprEnemyHorrorIdle,      loc(_loc, "horror"                                              )];
		case  61 : return [sprBarrel,               loc(_loc, "barrel"                                              )];
		case  62 : return [sprToxicBarrel,          loc(_loc, "toxic barrel"                                        )];
		case  63 : return [sprGoldBarrel,           loc(_loc, "golden barrel"                                       )];
		case  64 : return [sprCarIdle,              loc(_loc, "car"                                                 )];
		case  65 : return [sprVenusCar,             loc(_loc, "venus car"                                           )];
		case  66 : return [sprVenusCarFixed,        loc(_loc, "venus car fixed"                                     )];
		case  67 : return [sprVenuzCar2,            loc(_loc, "venus car 2"                                         )];
		case  68 : return [sprFrozenCar,            loc(_loc, "icy car"                                             )];
		case  69 : return [sprFrozenCarThrown,      loc(_loc, "thrown car"                                          )];
		case  70 : return [sprWaterMine,            loc(_loc, "mine"                                                )];
		case  71 : return [sprCrown1Idle,           loc(_loc, "crown of death"                                      )];
		case  72 : return [sprPopoExplo,            loc(_loc, "rogue strike"                                        )];
		case  73 : return [sprBloodNader,           loc(_loc, "blood launcher"                                      )];
		case  74 : return [sprBloodCannon,          loc(_loc, "blood cannon"                                        )];
		case  75 : return [sprBloodHammer,          loc(_loc, "blood hammer"                                        )];
		case  76 : return [sprDisc,                 loc(_loc, "disc"                                                )];
		case  77 : return [sprCurse,                loc(_loc, "@p@qc@qu@qr@qs@qe"                                   )];
		case  78 : return [sprScrapBossMissileIdle, loc(_loc, "big dog missile"                                     )];
		case  79 : return [sprSpookyBanditIdle,     loc(_loc, "halloween bandit"                                    )];
		case  80 : return [sprLilHunterHurt,        loc(_loc, "lil hunter fly"                                      )];
		case  81 : return [sprNothingDeathLoop,     loc(_loc, "throne death"                                        )];
		case  82 : return [sprJungleBanditIdle,     loc(_loc, "jungle bandit"                                       )];
		case  83 : return [sprJungleAssassinIdle,   loc(_loc, "jungle assassin"                                     )];
		case  84 : return [sprJungleFlyIdle,        loc(_loc, "jungle fly"                                          )];
		case  85 : return [sprCrown1Idle,           loc(_loc, "crown of hatred"                                     )];
		case  86 : return [sprIceFlowerIdle,        loc(_loc, "ice flower"                                          )];
		case  87 : return [sprCursedAmmo,           loc(_loc, "@p@qc@qu@qr@qs@qe@qd @qa@qm@qm@qo @qp@qi@qc@qk@qu@qp")];
		case  88 : return [sprLightningDeath,       loc(_loc, "electrocution"                                       )];
		case  89 : return [sprEliteGruntIdle,       loc(_loc, "elite grunt"                                         )];
		case  90 : return [sprKillsIcon,            loc(_loc, "blood gamble"                                        )];
		case  91 : return [sprEliteShielderIdle,    loc(_loc, "elite shielder"                                      )];
		case  92 : return [sprEliteInspectorIdle,   loc(_loc, "elite inspector"                                     )];
		case  93 : return [sprLastIdle,             loc(_loc, "captain"                                             )];
		case  94 : return [sprVanDrive,             loc(_loc, "van"                                                 )];
		case  95 : return [sprBuffGatorIdle,        loc(_loc, "buff gator"                                          )];
		case  96 : return [sprBigGenerator,         loc(_loc, "generator"                                           )];
		case  97 : return [sprLightningCrystalIdle, loc(_loc, "lightning crystal"                                   )];
		case  98 : return [sprGoldTankIdle,         loc(_loc, "golden snowtank"                                     )];
		case  99 : return [sprGreenExplosion,       loc(_loc, "green explosion"                                     )];
		case 100 : return [sprSmallGenerator,       loc(_loc, "small generator"                                     )];
		case 101 : return [sprGoldDisc,             loc(_loc, "golden disc"                                         )];
		case 102 : return [sprBigDogExplode,        loc(_loc, "big dog explosion"                                   )];
		case 103 : return [sprPopoFreakIdle,        loc(_loc, "popo freak"                                          )];
		case 104 : return [sprNothing2Death,        loc(_loc, "throne II death"                                     )];
		case 105 : return [sprOasisBossIdle,        loc(_loc, "big fish"                                            )];
	}
	
	 // Sprite:
	if(sprite_exists(_cause)){
		return [_cause, sprite_get_name(_cause)];
	}
	
	 // None:
	return [mskNone, ""];
    