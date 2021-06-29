//Original cube drawing by Abstractor, editor by Golden Epsilon
//Version 1.0
//TODO: Undo/redo buttons
//TODO: Importing sprites and pasting onto tris
//TODO: Delete tris
//TODO: Reset button
//TODO: toggle automatic/manual colors
//TODO: vertex colors
//TODO: UV coordinates
#define init
//Editor Setup
{
global.rotX = 0;
global.rotY = 0;
global.rotZ = 0;
global.mode = 0;
global.selectedVertex = 0;

global.tris = 
[-10, -10, -10,  10, -10, -10, -10,  10, -10, 
  10, -10, -10, -10,  10, -10,  10,  10, -10,
 -10, -10, -10, -10,  10, -10, -10, -10,  10, 
 -10,  10, -10, -10, -10,  10, -10,  10,  10,
 -10,  10, -10,  10,  10, -10, -10,  10,  10,
  10,  10, -10, -10,  10,  10,  10,  10,  10,
  10,  10, -10,  10, -10, -10,  10,  10,  10,
  10, -10, -10,  10,  10,  10,  10, -10,  10,
  10, -10, -10, -10, -10, -10,  10, -10,  10,
 -10, -10, -10,  10, -10,  10, -10, -10,  10,
 -10,  10,  10,  10,  10,  10, -10, -10,  10,
  10,  10,  10, -10, -10,  10,  10, -10,  10 
];
}
Setup();
//3D Setup
#define Setup
{
global.ready = false;
// [This part of the code is from Abstractor's example, I'm stealing it thanks - GE]
// hi, this is how u make cube

global.sprDie = sprite_add("Cube/die.png", 1, 0, 0); // don't use subimages, it will not work, every subimage is on its own texture page

// coming up is GM's default vertex buffer format, used by the default shader
vertex_format_begin();
vertex_format_add_position_3d(); // vertex 3d position
vertex_format_add_color(); // this is what image_blend and image_alpha go into
vertex_format_add_texcoord(); // UV coordinates
global.vertex_format = vertex_format_end();

// this will be our mesh
var vbuf = vertex_create_buffer();
vertex_begin(vbuf, global.vertex_format);
wait(1);
// these functions only work one frame later
//var spritetex = sprite_get_texture(global.sprDie, 0);
//var texsize = [texture_get_width(spritetex), texture_get_height(spritetex)];
/* 
The point of texture_get_width/height is this:
Graphics cards only work with textures with width and height a power of 2.
Our sprite above is 48x8, so it will actually be assigned to a texture of 64x8.
So on the texture, the sprite only covers UV coordinates (0,0) to (0.75, 1).
The latter numbers are what texture_get_width/height return.
*/

// (x,y,z) of the four points of each of the faces of the cube
// all that follows is pretty ugly and could be done in much better way (e.g. as a trianglestrip), but we're only doing it once so eh
// [Haha so you thought. I'm using this code anyway because I'm lazy - GE]
var quads = global.tris;
 // verts are top-left, top-right, bottom-left, bottom-right
//var texcoords = [0, 0, 1, 0, 0, 1, 1, 1];

var quadindex = 0;
/*var facenum = 6;
for(var face = 0; face < facenum; face++) {
	var texcoordindex = 0;
	for(var v = 0; v < 3; v++) {
		vertex_position_3d(vbuf, quads[quadindex++], quads[quadindex++], quads[quadindex++]);
		vertex_color(vbuf, ((face * 3 + v) == global.selectedVertex)?make_color_rgb(255, 255, 255):make_color_hsv(face*30, 150, 255), 1);
		vertex_texcoord(vbuf, (face+texcoords[texcoordindex++]) * texsize[0] / facenum, texcoords[texcoordindex++] * texsize[1]);
	}
	/*
	A quad consists of two triangles, so we have to go back and add the last two vertices of the first triangle to the second one.
	The order should really be reversed as well so that the vertices are always in counter-clockwise order, since this determines
	the facing of the triangle, but since back-face culling is disabled it doesn't matter in this case and we'll be lazy
	*//*
	//[I really hope this doesn't bite me later down the line because I'm too lazy to figure out the code to do it the non-lazy way... - GE]
	quadindex -= 6;
	texcoordindex -= 4;
	for(var v = 1; v < 4; v++) {
		vertex_position_3d(vbuf, quads[quadindex++], quads[quadindex++], quads[quadindex++]);
		vertex_color(vbuf, make_color_hsv(face*30, 150, 255), 1);
		vertex_texcoord(vbuf, (face+texcoords[texcoordindex++]) * texsize[0] / facenum, texcoords[texcoordindex++] * texsize[1]);
	}
}*/
//I'm gonna set triangles to be seperate so that the coding's simpler
while(quadindex+3 <= array_length(global.tris)){
	repeat(3){
		vertex_position_3d(vbuf, quads[quadindex++], quads[quadindex++], quads[quadindex++]);
		vertex_color(vbuf, (((quadindex/3)-1) == global.selectedVertex || (global.mode && (floor((quadindex/3-1)/3)) == floor(global.selectedVertex/3)))?make_color_hsv(floor(quadindex/3)*3*255/array_length(global.tris), 50, 255):make_color_hsv(floor(quadindex/3)*3*255/array_length(global.tris), 150, 200), 1);
		vertex_texcoord(vbuf, 0, 0);
	}
}
vertex_end(vbuf);
global.vertex_buffer = vbuf;
global.ready = true;
}
#define step
//clean up the area for working
{
if(!instance_exists(GenCont) && !instance_exists(Menu)){
	with(GameObject){
		if object_index != Player && object_index != TopCont{
			instance_delete(self);
		}
	}
	with(Player){
		visible = 0;
		view_pan_factor[index] = 0;
		with(Player){
			player_set_show_hud(index, other.index, 0);
			player_set_show_prompts(index, other.index, 0);
			player_set_show_skills(index, 0);
			player_set_show_marker(index, other.index, 0);
		}
	}
	background_color = c_ltgray;
}else if(!instance_exists(Menu)){
	audio_stop_all();
}
}
//making the UI do stuff
{
var s = false;
if(button_check(0, "spec")){
	global.rotX -= mouse_delta_y[0];
	global.rotZ -= mouse_delta_x[0] * sign((global.rotX + 360) % 360 - 180);
	global.rotX %= 360;
	global.rotY %= 360;
	global.rotZ %= 360;
}
if(gp_button(5,15,30,10,c_orange,"import") && fork()){
	wait file_load("import.txt");
	var imp = string_load("import.txt");
	if(!is_undefined(imp) && string_length(imp) > 0){
		global.tris = import(imp);
		global.selectedVertex %= array_length(global.tris)/3;
		s=1;
		trace("import.txt loaded.");
	}else{
		trace("import.txt not found.");
	}
}
if(gp_button(5,30,30,10,c_orange,"export")){
	var exportstr = "";
	for(var i = 0; i < array_length(global.tris)/3; i++){
		exportstr += "["+string(global.tris[i*3])+","+string(global.tris[i*3+1])+","+string(global.tris[i*3+2])+"]";
	}
	trace(exportstr);
	string_save(exportstr, string_copy(string_sha1(exportstr), 0, 5)+" Model.txt");
	trace("Saved to the data directory.");
	trace("To be safe, RENAME YOUR FILES AFTER EXPORTING. I only use part of a hash to differentiate exporting, so there's no guarantee it won't be overwritten if it isn't renamed.");
}
if(gp_button(5,45,30,10,c_orange,"new tri")){repeat(9){array_push(global.tris, 0)}}

if(gp_button(game_width - 60,game_height - 15,15,10,c_aqua,"lft")){global.rotY -= 45;}
if(gp_button(game_width - 20,game_height - 15,15,10,c_aqua,"rgt")){global.rotY += 45;}
if(gp_button(game_width - 40,game_height - 15,15,10,c_aqua,"dwn")){global.rotX -= 45;}
if(gp_button(game_width - 40,game_height - 30,15,10,c_aqua,"up")){global.rotX += 45;}
if(gp_button(game_width - 60,game_height - 30,15,10,c_aqua,"rll")){global.rotZ += 45;}
if(gp_button(game_width - 20,game_height - 30,15,10,c_aqua,"rlr")){global.rotZ -= 45;}
if(gp_button(game_width - 60,game_height - 45,55,10,c_orange,"reset rot")){global.rotX = 0; global.rotY = 0; global.rotZ = 0;}

if(gp_button(game_width - 60,game_height/2 - 45,55,10,c_orange,global.mode?"Triangle":"Vertex")){global.mode = !global.mode;s=1;}
if(gp_button(game_width - 40,game_height/2 - 30,15,10,c_orange,string(floor(global.selectedVertex/(global.mode?3:1))))){global.selectedVertex = 0; s=1;}
if(gp_button(game_width - 20,game_height/2 - 30,15,10,c_orange,"+")){global.selectedVertex+=(global.mode?3:1); global.selectedVertex %= array_length(global.tris)/3; s=1;}
if(gp_button(game_width - 60,game_height/2 - 30,15,10,c_orange,"-")){global.selectedVertex-=(global.mode?3:1); if(global.selectedVertex<0){global.selectedVertex = array_length(global.tris)/3 - global.selectedVertex - (global.mode?6:2)} s=1;}
if(global.mode){
	var baseV = floor(global.selectedVertex/3)*3;
	gp_button(game_width - 60,game_height/2 - 15,15,10,c_yellow,string(floor((global.tris[baseV*3]+global.tris[(baseV+1)*3]+global.tris[(baseV+2)*3])/3)));
	gp_button(game_width - 40,game_height/2 - 15,15,10,c_yellow,string(floor((global.tris[baseV*3+1]+global.tris[(baseV+1)*3+1]+global.tris[(baseV+2)*3+1])/3)));
	gp_button(game_width - 20,game_height/2 - 15,15,10,c_yellow,string(floor((global.tris[baseV*3+2]+global.tris[(baseV+1)*3+2]+global.tris[(baseV+2)*3+2])/3)));
	if(gp_button(game_width - 60,game_height/2,15,10,c_aqua,"lft")){global.tris[baseV*3] -= 1;global.tris[(baseV+1)*3] -= 1;global.tris[(baseV+2)*3] -= 1;s=1;}
	if(gp_button(game_width - 60,game_height/2 + 15,15,10,c_aqua,"rgt")){global.tris[baseV*3] += 1;global.tris[(baseV+1)*3] += 1;global.tris[(baseV+2)*3] += 1;s=1;}
	if(gp_button(game_width - 40,game_height/2 + 15,15,10,c_aqua,"dwn")){global.tris[baseV*3 + 1] += 1;global.tris[(baseV+1)*3 + 1] += 1;global.tris[(baseV+2)*3 + 1] += 1;s=1;}
	if(gp_button(game_width - 40,game_height/2,15,10,c_aqua,"up")){global.tris[baseV*3 + 1] -= 1;global.tris[(baseV+1)*3 + 1] -= 1;global.tris[(baseV+2)*3 + 1] -= 1;s=1;}
	if(gp_button(game_width - 20,game_height/2,15,10,c_aqua,"in")){global.tris[baseV*3 + 2] += 1;global.tris[(baseV+1)*3 + 2] += 1;global.tris[(baseV+2)*3 + 2] += 1;s=1;}
	if(gp_button(game_width - 20,game_height/2 + 15,15,10,c_aqua,"out")){global.tris[baseV*3 + 2] -= 1;global.tris[(baseV+1)*3 + 2] -= 1;global.tris[(baseV+2)*3 + 2] -= 1;s=1;}
}else{
	gp_button(game_width - 60,game_height/2 - 15,15,10,c_yellow,string(global.tris[global.selectedVertex*3]));
	gp_button(game_width - 40,game_height/2 - 15,15,10,c_yellow,string(global.tris[global.selectedVertex*3+1]));
	gp_button(game_width - 20,game_height/2 - 15,15,10,c_yellow,string(global.tris[global.selectedVertex*3+2]));
	if(gp_button(game_width - 60,game_height/2,15,10,c_aqua,"lft")){global.tris[global.selectedVertex*3] -= 1;s=1;}
	if(gp_button(game_width - 60,game_height/2 + 15,15,10,c_aqua,"rgt")){global.tris[global.selectedVertex*3] += 1;s=1;}
	if(gp_button(game_width - 40,game_height/2 + 15,15,10,c_aqua,"dwn")){global.tris[global.selectedVertex*3 + 1] += 1;s=1;}
	if(gp_button(game_width - 40,game_height/2,15,10,c_aqua,"up")){global.tris[global.selectedVertex*3 + 1] -= 1;s=1;}
	if(gp_button(game_width - 20,game_height/2,15,10,c_aqua,"in")){global.tris[global.selectedVertex*3 + 2] += 1;s=1;}
	if(gp_button(game_width - 20,game_height/2 + 15,15,10,c_aqua,"out")){global.tris[global.selectedVertex*3 + 2] -= 1;s=1;}
}
if(gp_button(game_width - 55,10,45,10,c_orange,"redraw")){s=1;}
if(s){Setup();}
}
#define draw

//drawing the cube
{
if !global.ready exit;

d3d_start();

//d3d_set_culling(true); // <-- if you enable this you'll see some triangles face the wrong way, as explained above, so let's not turn it on
// if you don't disable it at the end, it'll also mess up drawing the rest of the game, by the way (flipped sprites for instance)

//d3d_set_projection_ortho(view_xview_nonsync, view_yview_nonsync, game_width, game_height, 0); // as far as I know this is the standard projection

for(var p = 0; p < maxp; p++) {
	if player_is_active(p) {
		for(var i = 0; i < 10; i++){
			d3d_transform_set_identity();
			d3d_transform_set_scaling(0.5 + (i==0), 0.5 + (i==0), 0.5 + (i==0)); // scaling
			// try different numbers for x,y,z, for a squashed cube (or "hyperrectangle" or "rectangular cuboid" or "3-orthotope")
			
			// now some example rotation
			// note that in the default projection the z-axis is the one orthogonal to the screen, and you're looking in the positive z-direction
			// (so vertices with negative z-values appear first, just like with depth)
			d3d_transform_add_rotation_z(global.rotZ + (i==1)*90 + (i==2)*180 + (i==3)*270);
			d3d_transform_add_rotation_x(global.rotX + (i==4)*90 + (i==5)*180 + (i==6)*270);
			d3d_transform_add_rotation_y(global.rotY + (i==7)*90 + (i==8)*180 + (i==9)*270);
			
			// note that the order in which scaling, rotation, and translation is applied is important
			// scaling and rotation are always applied relative to the origin (0,0,0)
			// generally speaking you'll want to scale first, rotate next, translate last
			
			d3d_transform_add_translation(view_xview[p] + game_width/2 - ((i-1)%3)*30 - 30 - (i!=0)*20, view_yview[p] + game_height/2 + floor((i-1)/3)*30 + 30 + (i!=0)*10, 0);
			vertex_submit(global.vertex_buffer, pr_trianglelist, sprite_get_texture(global.sprDie, 0)); // draw
		}
	}
}

d3d_transform_set_identity(); // <-- important
//d3d_set_culling(false);

d3d_end();
}

#define gp_button(x,y,w,h,color,text)
script_bind_draw("gp_button_draw", 0, x,y,w,h,color,text);
return gp_button_check(x,y,w,h);

#define gp_button_draw(x,y,w,h,color,text)
draw_set_color(color);
draw_button(x,y,x+w,y+h,gp_button_check(x,y,w,h));
draw_set_halign(1);
draw_set_valign(1);
draw_set_font(fntSmall);
draw_text_nt(x+w/2+1,y+h/2+1,"@w"+text);
draw_set_halign(0);
draw_set_valign(0);
instance_destroy();

#define gp_button_check
//x,y,w,h,?hold,?index
{
var retVal = false;
if(argument_count == 4 || (argument_count == 5 && argument[4] == 0)){
	var mouseX = mouse_x[0]-view_xview[0];
	var mouseY = mouse_y[0]-view_yview[0];
	var x = argument[0];
	var y = argument[1];
	var w = argument[2];
	var h = argument[3];
	for(var i = 0; i < 4; i++){
		var mouseX = mouse_x[i]-view_xview[i];
		var mouseY = mouse_y[i]-view_yview[i];
		if(!retVal){retVal = (button_pressed(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h));}
	}
}else if(argument_count == 5){
	var mouseX = mouse_x[0]-view_xview[0];
	var mouseY = mouse_y[0]-view_yview[0];
	var x = argument[0];
	var y = argument[1];
	var w = argument[2];
	var h = argument[3];
	for(var i = 0; i < 4; i++){
		var mouseX = mouse_x[i]-view_xview[i];
		var mouseY = mouse_y[i]-view_yview[i];
		if(!retVal){retVal = (button_check(i, "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h));}
	}
}
else if(argument_count == 6 && argument[4] == 0){
	var mouseX = mouse_x[argument[5]]-view_xview[argument[5]];
	var mouseY = mouse_y[argument[5]]-view_yview[argument[5]];
	var x = argument[0];
	var y = argument[1];
	var w = argument[2];
	var h = argument[3];
	if(!retVal){retVal = (button_pressed(argument[5], "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h));}
}
else if(argument_count == 6){
	var mouseX = mouse_x[argument[5]]-view_xview[argument[5]];
	var mouseY = mouse_y[argument[5]]-view_yview[argument[5]];
	var x = argument[0];
	var y = argument[1];
	var w = argument[2];
	var h = argument[3];
	if(!retVal){retVal = (button_check(argument[5], "fire") && point_in_rectangle(mouseX,mouseY,x,y,x+w,y+h));}
}
return retVal;
}
#define import(imp)
var retVal = [];
var num = "";
for(var i = 0; i < string_length(imp); i++){
	if(num != "" && (string_char_at(imp, i) == "," || string_char_at(imp, i) == "[" || string_char_at(imp, i) == "]")){
		array_push(retVal, real(num));
		num = "";
	}else if(string_char_at(imp, i) == "-" || string_char_at(imp, i) == "0" || string_char_at(imp, i) == "1" || string_char_at(imp, i) == "2" || string_char_at(imp, i) == "3" || string_char_at(imp, i) == "4" || string_char_at(imp, i) == "5" || string_char_at(imp, i) == "6" || string_char_at(imp, i) == "7" || string_char_at(imp, i) == "8" || string_char_at(imp, i) == "9"){
		num+=string_char_at(imp, i);
	}
}
if(num != ""){
	array_push(retVal, real(num));
	num = "";
}
return retVal;