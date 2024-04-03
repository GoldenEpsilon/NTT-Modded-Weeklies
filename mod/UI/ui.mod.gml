/* *  *   *   *  * *\
 *                 *
       UI TIME

    ~set up data
    "
            scores =
        {
          testplayer: {
          },
          testplayer2: {
          },
        }
    "
    
    from campfire mod
    -port go button
    -port back button 
        disable it when in score menu
    -port... the rest of it
    
    regain control of the base ui
        menu ui object (RANDOM/ race name/discription)
        
    daily button
        - under back button? top left like early access?
        - slides original ui to the right
            -combines weapon and name. hides race disciption
            -hides name splash, new splash animation?
            
    menu tabs
        daily 
        modded daily
        weekly
        
    next daily countdown
    
    info on hover
        skin
        wep
        crown
        mutation
        killed by on hover over kills
        daily discription
        
        
    if score button clicked start transition
        menu.visible false, run script to resize game window and redraw menu
            moves the character name and art
    
    move charselect off sceen to right
    keep go button in same place
    
    write a report about why modded dailies are bad actually
        modded weeklies good
        modded 3 daylies gooder
        unmodded dailies good
        co op dailies undecided
      
      
      
        
    things i can use from go
    
        clearing up eccessive exploded floors
        
        move the camera by draging around when on "RANDOM"
            probably yeah
            no reason to other then it is nice
            no reason not to unless it breaks something
          
        shuffle the wasteland kings
            other than fish the others can be in any of the left/right/down locations or whereever plant spawned
            plant is og and deserves warmth
            i like it a lot
            fliped eyes and crystal are a little weird at first
            
        fish is shifted slightly left or right on his log sometimes
        
        weapons renamed to remove character names
            chicken sword -> sword
        
        frog and skeleton disabled by default
            frog running around is cute but is a very not NT thing that has become the norm from a whim of yal
	        same for skel
	        headcannon that frog is a curse the mutant gets from using the frog blaster
	        actual cannon that melting melts and revives into skeleton, why he stand next to meltman?
	        re added with /frog /skel /skeleton 
	        big dog command /bdog /bigdog
            inherent to go button (having room by default)
	   
	   skeleton and bigdog campfire animations
	        weird dog doesnt do animation
	   
        skins organize into columns
            make sure no break
            
        character icons squish together then stack when out of room
            change to be gooder
                if stacked
                stay in the squished state until new button i clicked to expand 
            inherent to go button
    
        gscale command
            resizes game 
            /gscale 2 makes game double size /gscale 4 4 times the size
            i like it, it is very useful but no real reason to add
           
        hide the first 4 races if they are locked
            weird thing ntt doesnt do
        

    
 *                 *
\* *  *   *   *  * */

global.menu_surf1 = 0
global.menu_surf2 = 0

	/*  characters unlocked  */	
	global.frog = false;
	global.skel = false;
	global.bdog = false;

	/*	remove character names from weapons (chicken sword)		*/
	global.wepnames = true;

	/*  hide menu portraits  */
	global.hideportraits = false;
		
	
//characters
if !global.frog{
	race_set_active(15,0);
	with instances_matching(CampChar,"num",15) instance_delete(id);
	}
if !global.skel{
	race_set_active(14,0);
	with instances_matching(CampChar,"num",14) instance_delete(id);
	}
if !global.bdog{
	race_set_active(13,0);
	with instances_matching(CampChar,"num",13) instance_delete(id);
    }
else{
    race_set_active(13,1);
}
	
//rename weapons
if global.wepnames{
	weapon_set_name(81,"IDPD RIFLE");
	weapon_set_name(46, "SWORD");
}
else{
	weapon_set_name(81,"rogue rifle");
	weapon_set_name(46,"chicken sword");
}

//sprites
if global.hideportraits 
	sprite_replace(sprBigPortrait,"blank_strip3.png",3,0,0);

global.sprBackIntro = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAaQAAAAcCAYAAAAuosuZAAAACXBIWXMAAAsSAAALEgHS3X78AAAAG3RFWHRTb2Z0d2FyZQBDZWxzeXMgU3R1ZGlvIFRvb2zBp+F8AAACCklEQVR42u3dXW7CMBAA4XCiqvc/RNUTpU9IEQIa/2y8xt+8UmmQEDuyG5vbvu8bAKzEz9dt//7db1f6tm3brnLO6rsJEgAxih/WVwXi6LvC2dMnSACWi9EVK4hHV3QkPsEnSACWC9F9aEaF6d2w5hMkAAvH6N3rEcOarw5BAiBGfCl8ggRgyRj1Hqx87T5BApAuJM/+33PlAC0dpr1cq/sECcA0q52SMPUYovcw/uftGb+VfYIEYIoAlZ4f6r1C+s/P1+4TJADTxWrESkmU4n2CBGC6CNVGqWVrqtb37r328JWcBcruEyQA00SpNhAlEet12PPoq4lSj1VgSSQy+AQJwDJRihi4WSJYcoVPVp8gAWge3iMuDY0M0qy+x63C0kiM9gkSgCmiJEh1n8erzyajT5AANEdIkPh6+AQJWHTF0epreY+1vtoBuprvzFOFGX2CBCSLxNlHhkf7jlf8RDwS3WuAruiLDFKkT5CAZFGa5Rc/W4NU42sZoHz5fYIEJFodtW6ljPD1uDmh9sBq7SPVfDl9ggRUDN7oQI1eJZ3ZfmnZUvyEMzN8/X2CBCRcKb36wkf+5PaZv3uMUM8glTLqPju+OJ8gAYnj9+oLHBGm0ig9C1R0lPg+2ydIwARRGrVVGDXMWnwtIebL7RMkAEWD5hjHXqs0Pj5BAjBNILMfFOZr9wkSACAFf9jghAUDVL1aAAAAAElFTkSuQmCC"
, 15, 16, 16);
global.sprBackButton = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAAKgAAAAeCAYAAAC42FXcAAAACXBIWXMAAAsSAAALEgHS3X78AAAAG3RFWHRTb2Z0d2FyZQBDZWxzeXMgU3R1ZGlvIFRvb2zBp+F8AAADBElEQVR42u2cW24kIQxF8YYmSva/homSDXk+ZpAIA8Y2vlBdhb9a6lYdbN/iYawmZk4aIyJOKSVmprTADu/wUkqJNAIlIv796+/nj2+8k0/g5bgT0S15UfEUBZrfggzLhkriU3h1zFGi2cWLjGdXoPkt+Pj+H4hI4hN4zJzF0foe5t9qXmQ8qTN4ERadwCfwRlupSMG0/Hv/4qU8mEDL/UPPEGK5M2+HOFuWRbqKF77Ea2Etc70dD+BpxHniqRCoBqYdiAa+g8fM6fONlvtXL68j+3wjaDxb4ylfFHT+3r9YzaN/G/cpsVin9B28cibzinTGP49IkfGUxjPaAkTkr+RLvHCB5o1yngFa4B28eqmdmUm9/nlnUlQ8ezNprjag85dnUokXtsS3lsOizAEXqYYXKVKvfzPLPSKe0nJflMXgIu3xzIekI9Ij0pUiNZWZWicyaYDSsrST1xPpSv/qg0JxYBiKFBHPgUjh+atE2p5BtdAfDzD81uskgieJdJV/xR6MNKUpbf3SG09vMR+Zv+FVp+ohwCQieS2RXsU/lEhH/kWLdDaew2aRsitF6lCxDPBKvKrLxyxSpH+zd+jeeGpLQCvyR4qbDi43572NekQCd/LKUsdV/Ito8vDG03stGp0/cYmvH5g3sPV3EQk8vNgZNMK/1h55dTyH3Uz16cta4tAkcAevnDHL07O1pIL0zyvQO+VPLDOVtxgoB3fz6h7NaIHO+OcR6N3yp6qDahoXIhzcwdM2Luzwb1agd8ifulAvDXSmDNPrMkLyrHutaJ7WP+GuHMJb7Z+7zCRBWxZVk2yJFMXribRlOUaWlygqnp6Sz478oXjmmySLeYrmM61wETc7I7O0wUXF01ry2ZE/FM98k6SBSA0N0SKd4XlESkShvNX+vRpPfZNkgXkK2B6RRvAsItWc9iOTiPLvlXimmyQJpKl9aZ3M+76eSBE8qQO+bAXzinN3PF+VR9a/vunZqOvb6+hVeKMu81f376o8tUCVy/OS//05vOfwwgR67BjC/gB49PQf8OwrGQAAAABJRU5ErkJggg=="
, 6, 16, 17);
global.sprLoadoutSplat = sprite_add_base64("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"
, 4, 109, 69);
			

global.menu_opened = false
global.menu_opening = [0,16]     //  min/start,max

global.scoreboard_number_of_rows = 6    // number of rows displayed
global.scoreboard_opened = -4       //which row is opened, -4 = none
global.scoreboard_opening = [0,16]  //  min/start,max


#macro debug true   if debug trace("debug is on")
#macro moddedweeklies_mod_file "moddedweeklies"

#macro holdbackdelay 16;    /*  how long you have to hold to return to the main menu  */

#macro menu_opened global.menu_opened
#macro menu_opening global.menu_opening
#macro scoreboard_number_of_rows global.scoreboard_number_of_rows
#macro scoreboard_opened global.scoreboard_opened 
#macro scoreboard_opening global.scoreboard_opening
#macro scoreboard_anim scoreboard_opening[0]/scoreboard_opening[1]    //*scoreboard_anim
#macro menu_anim menu_opening[0]/menu_opening[1]    //*menu_anim
    
if debug
global.names = ["fish","eyes","crystal","yv","steroids","cuz","rebel","melting","robot","horor","plant","rogue","big dog","blaac"]

with instances_matching(CustomObject,"name","mod_ui_daily_button"){
    
    global.menu_opened = true
    instance_delete(id)
    
}



update_scoreboard()

#define update_scoreboard
global.scoreboard = [
	{
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
		mutations : [1,2,3,4,5,6],
		time : 55032,
		color : c_red
		
	},
]

if debug{
    
    var _array = []
    for(var i = 1;i<22;i++){
        
        var _kills = irandom(10000)
        var _hard = ceil(_kills/240)
        var _area = ceil((_kills/32) mod 7)
        var _race = irandom(10)
        //var _race = irandom(11)
        //if !irandom(10) _race = "detonator"
        var _muts = [1,2,3,4,5,6]
        var _name = 
                {
                    name : global.names[irandom(array_length(global.names)-1)],//"p"+string(i), 
                    race : _race,
                    skin : irandom(1),
                    kills : _kills,
                    hard : _hard,
                    area : _area,
                    subarea : _area mod 2 = 1 ? 1:(_hard mod 3 )+1,
                    loop : floor(_hard/16),
                    wep : irandom(101),
                    bwep : irandom(101),
                    crown : irandom(13),
                    mutations : array_shuffle(_muts),
                    time : 55032,
                    color : choose(c_red,c_aqua,c_lime,c_purple,c_dkgray,c_fuchsia,c_yellow,c_orange,c_blue)
                }
        _array[array_length(_array)]= _name
        }
    global.scoreboard = _array
}
var does_the_mod_exist = mod_exists("mod",moddedweeklies_mod_file)

if does_the_mod_exist{
    
    global.scoreboard = {
    }

    global.scoreboard = 
        mod_script_call("mod",moddedweeklies_mod_file,"get_scores_please")
        //please sort them by kills/display order
}

global.scoreboard = array_shuffle(global.scoreboard)//sort_array_by(global.scoreboard,kills)



#define go

game_restart();
instance_destroy();

#define force_quit
mod_loadtext("exit.txt");
instance_destroy();

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

//trace((scoreboard_opening[0]))
//#define sort_array_by(_array,_how)
//var old = _array;
//var temp = [];
//for(var i = 0;i<array_length(old);i++){
//    for(var f = 0 f<array_length(old);f++){
//        if old[f]._how > old[i]._how
//            array
//    }
//}

#define draw
if !instance_exists(Campfire) exit;


    draw_set_projection(0, 0)
    draw_set_color(c_black)
    var xx = -240+(322*menu_anim)
    draw_rectangle(xx-200,36,xx-200+game_width*0.8,game_height-36,0)
    draw_sprite_ext(sprLoadoutOpen,floor(2+3*(menu_anim)),xx,game_height-36,-1,1,0,c_white,1)
    draw_sprite(global.sprLoadoutSplat,floor(3-(3*min(1,menu_anim*4))),game_width+64*(menu_anim),game_height-36)

    draw_reset_projection()


if debug{
    
    
    //with CharSelect ystart = 210 - 250*menu_anim    
    with Menu visible = menu_opening[0] = 0
    
if button_pressed(0,"horn")
    update_scoreboard()

//if menu_opened{
  
    
    //if scoreboard_opened != -4 draw_text_nt(32,game_height-32,scoreboard_opened)
    
    draw_set_projection(0, 0)
    var xx = game_width-36 +222-(222*menu_anim)
    var yy = game_height-48
    
    var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,game_width-64,game_height-67,game_width,game_height-37)
    
    //var _sprt = get_mapsprite(player_get_race_id(0),player_get_skin(0))
    //draw_sprite(_sprt[0],_sprt[1],xx-1*mouse_over,yy+1*mouse_over)
        
    var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,game_width-64,game_height-67,game_width,game_height-37)
    
    
    
    var xx = 16 -game_width +(game_width*menu_anim);
    var yy = 48;
    for(var i = 0;i<    min(scoreboard_number_of_rows,array_length(global.scoreboard) )    ;i++){
        
	    draw_set_halign(0)
        
        var col2 = global.scoreboard[i].color
        var col = make_color_hsv(color_get_hue(col2),color_get_saturation(col2)*0.8,color_get_value(col2)*0.7)
        
        var mouse_over = point_in_rectangle(mouse_x-view_xview,mouse_y-view_yview,xx,yy-1,xx+game_width*0.8,yy+7)
        var _opened = i=scoreboard_opened
        
        var xxx = 0
        var yyy = 0
        var _pointless_wiggle = ceil(sin(current_frame + i)/2)
        
        
        if mouse_over or scoreboard_opened = i{
        draw_set_color(col)
        draw_rectangle(xx-20,yy-1,xx+(game_width-17)*menu_anim,yy+7*menu_anim,0) 
        draw_line(xx-20,yy+8+_opened,xx+(game_width-17)*menu_anim,yy+8*menu_anim+_opened)
        draw_set_color(c_white)
            _pointless_wiggle= cos(current_frame + i)
            
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
            if !is_string(global.scoreboard[i].race)
            var _text = string(race_get_name(global.scoreboard[i].race))
            else
                    _text = global.scoreboard[i].race
            if _text = "venuz" _text = "yung venuz"
                
            draw_text(xx-32+(34*scoreboard_anim)+_pointless_wiggle*0.3,yy+10,_text)
        }
        
        //bgun      //maybe second forloop to render all bweps first for less clipping
        xxx+= 4
        var _sprt = weapon_get_sprt(global.scoreboard[i].bwep)
        if _sprt != 0
        draw_sprite_ext(_sprt,0,
        round(xx+xxx-5+((210*scoreboard_anim)*_opened))
        ,round(yy+(_pointless_wiggle*(scoreboard_opened!=i))+((26*scoreboard_anim)*_opened))
        ,1,1,45-((45*scoreboard_anim)*_opened),_opened ? c_white:c_silver,1)
        xxx-=32
        
        //mapicon
        var _sprt = get_mapsprite(global.scoreboard[i].race,global.scoreboard[i].skin)
        draw_sprite(_sprt[0],_sprt[1],round(xx+((167*scoreboard_anim)*_opened)),round(yy+(_pointless_wiggle*!_opened)+((10*scoreboard_anim)*_opened)))
        
        //gun       // add melee weapon angle
        xxx+=28
        var _sprt = weapon_get_sprt(global.scoreboard[i].wep)
        if _sprt != 0
        draw_sprite_ext(_sprt,0,
            round(xx+xxx+((180*scoreboard_anim)*_opened))
            ,round(yy+4+(_pointless_wiggle*(scoreboard_opened!=i))+((22*scoreboard_anim)*_opened))
            ,1,1,(45-45*_opened)*weapon_is_melee(global.scoreboard[i].wep)-15+((15*scoreboard_anim)*_opened),c_white,1)
        
        //crown
        xxx+=16
        var _sprt = get_crownsprite(global.scoreboard[i].crown)
        if global.scoreboard[i].crown != 0 and global.scoreboard[i].crown != 1
        draw_sprite_ext(_sprt,current_frame*0.4,round(xx+xxx),round(yy+4+_pointless_wiggle+((22*scoreboard_anim)*_opened)),1,1,0,c_white,1)
        
        xxx+=18
        
        draw_set_color(c_gray)
        if scoreboard_opened = i or mouse_over
        draw_set_color(c_white)
        
        //ranking
        draw_text(round(xx+xxx+(-8- 16*(scoreboard_anim*_opened)+_pointless_wiggle)),yy,i+1)
        
        _pointless_wiggle*=1.5
        
        //name
	    draw_set_halign(0)
        var _text = string(global.scoreboard[i].name)
            
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
            string(global.scoreboard[i].kills)
        
	    draw_set_halign(1)
        draw_text(xx+xxx,yy+yyy,_text)
        
        //loop
        xxx+=48
        _text = 
            string(" : ")
	    draw_set_halign(2)
        //draw_text(xx+xxx,yy+yyy,_text)
        xxx+=24
        _text = 
            string("L"+
            string(global.scoreboard[i].loop)
        )
        
        if global.scoreboard[i].loop != 0
        draw_text(xx+xxx,yy+yyy,_text)
        
        //area
        xxx+=32
        _text = 
            string(string(global.scoreboard[i].area)+"-"+string(global.scoreboard[0].subarea))
        
        draw_text(xx+xxx,yy+yyy,_text)
        
        
        
        
        if _opened{
            xxx=0
            
            //charselect
            var _sprt = get_charsprite(global.scoreboard[i].race)
            draw_sprite(_sprt[0],_sprt[1],xx-32+(16*scoreboard_anim),yy-1)
            
            //mutations
            var muts = global.scoreboard[i].mutations
            if array_length(muts) > 0{
            var mx = 0
            for(var m = 0;m<array_length(muts);m++){
                
                draw_sprite(sprSkillIconHUD,muts[m],xx+12+((48+(18*m))*scoreboard_anim),yy+30)
                
            }
                
            }
        }
        
        
        if scoreboard_opened = i
        yy+= 45
        else
        yy+=24-((3*(scoreboard_opened!=-4)))
    }
    
    
    draw_reset_projection()
//}
}



if !surface_exists(global.menu_surf1)
    global.menu_surf1 = surface_create(game_width,game_height);
surface_set_target(global.menu_surf1)
    draw_clear_alpha(c_silver,0)
    draw_set_projection(2, 0)
    with Menu{
            for(var c = 0;c<3;c++)
                charx[c] = floor(178+80*menu_anim)
            visible = true
        	event_perform(ev_draw,0)
        	visible = false
    }
    draw_reset_projection()
    

surface_reset_target()

    
    draw_set_projection(0, 0)
    
    draw_surface_part(global.menu_surf1,0,36,game_width,game_height-72,-(game_width*1.2)*menu_anim,36)

    draw_reset_projection()

#define draw_gui
if !instance_exists(Campfire) exit;
with Loadout if selected menu_opened = false
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
            
            var _loadout = false
            with Loadout if selected _loadout = true
            
            //y = ystart - 210*menu_anim - 64*_loadout
            
            for(var i=0;i<maxp;i++){
                if instance_exists(self) and point_in_rectangle(mouse_x[i],mouse_y[i],view_xview[i]+x,view_yview[i]+y,view_xview[i]+x+sprite_get_width(sprite_index),view_yview[i]+y+sprite_get_height(sprite_index)){
                    //trace(choose(""," ","  "),"hover")
                    if button_pressed(i,"fire"){
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
    	mod_ui = true
    } 
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
	
	
   

#define menu_draw(_y)
if !instance_exists(Campfire) exit;


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
if(race_get_id(race) <= 16){
	race = race_get_id(race)
}
var sprt = [sprMapIcon,0]
if is_string(race){
    sprt = [race,skin]
    if mod_exists("race",race){
        sprt[0] = mod_script_call("race",race,"race_mapicon");
        sprt[1] = 0
        //i dont know how to make it use the skin if the sprite is or isnt a sprite strip
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
if(race_get_id(race) <= 16){
	race = race_get_id(race)
}
var sprt = [sprCharSelect,0]
if is_string(race){
    sprt = [race,0]
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


   
#define chat_command

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
if(argument0 = "wepnames"){
    global.wepnames = global.wepnames ? false : true;
    if !global.wepnames
    	trace("default names");
    else
    	trace("changed names");
    return true;
}

if(argument0 = "portraits"){
    global.hideportraits = global.hideportraits ? false : true;
    if global.hideportraits 
		sprite_replace(sprBigPortrait,"blank_strip3.png",0,0,0);
    else{
    	sprite_restore(sprBigPortrait);
    }
    return true;
}


#define cleanup

sprite_restore(sprBackButton);
sprite_restore(sprBigPortrait);
//sprite_restore(sprLoadoutSplat);
    
surface_destroy(global.menu_surf1);
surface_destroy(global.menu_surf2);
