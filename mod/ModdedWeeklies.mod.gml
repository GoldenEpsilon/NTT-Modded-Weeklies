//Todo:
/*
-> load data for the weekly from a json file or something
-> download mods and load them
-> run /cwep, /pwep, and /bwep to make sure people aren't cheating/set starter weapon
-> set starting crown
-> create UI for seeing weekly description
-> play button
-> score submission
-> make score submission include base64 versions of sprites if the sprites are modded, so that they can be displayed
-> leaderboards
*/

#define init
//Chat anticheat vars
global.active = true;
global.cheating = [];
global.regChat = [];
for(var p = 0; p < maxp; p++){
	array_push(global.cheating, 0);
	array_push(global.regChat, 0);
}
global.NoChat = instance_create(0,0,SetKey);
global.NoChat.persistent = true;

//other Vars
global.canStart = false;
global.qualified = false;
global.endData = {
	alias: "",
	data: []
};
global.start = false;
global.finished = false;
global.leaderboard = {scores: []}
global.data = {}
global.currentDate = "";
global.currentWeek = "";
wait(3);
while(!mod_sideload()){wait 1;}
global.forks = 0;
checkForUpdates("ModdedWeeklies", "GoldenEpsilon/NTT-Modded-Weeklies")
global.qualified = true;
current_time_scale = 1/(room_speed/30);
if(global.qualified == true && !instance_exists(CharSelect)){
	with(Player){
		instance_destroy();
		global.qualified = false;
	}
	with(Revive){
		instance_destroy();
		global.qualified = false;
	}
	trace("Disqualified for uploading results, as you loaded the mod while in a run. Go back to the character select screen to start a new run.");
}

getCurrentDate();

loadLeaderboards();

global.headers = ds_map_create();
ds_map_set(global.headers, "Authorization", "token 7349069d71cc5b8e1165"+"40e940c2ad5650ea32de");
ds_map_set(global.headers, "cache-control", "no-cache");	
ds_map_set(global.headers, "Accept", "application/vnd.github.full+json");
file_delete("current.json");
while (file_exists("current.json")) {wait 1;}
http_request('https://raw.githubusercontent.com/GoldenEpsilon/NTT-Modded-Weeklies/main/Dailies/' + global.currentDate + '/data.json'
, "GET", global.headers,
''
, "current.json");
while (!file_loaded("current.json")) {wait 1;}
var dl = {};
if(array_length(string_split(string_load("current.json"), chr(34)+"message"+chr(34)+":"+chr(34)+"Not Found"+chr(34))) == 1){
	dl = json_decode(string_load("current.json"));
}
file_unload("current.json");
global.data = dl;

var i = 0;
for(i = 0; array_length(mod_get_names("mod")) > i + 1; i=i){
	if(mod_get_names("mod")[i] != mod_current && 
	mod_get_names("mod")[i] != "GCFix" && 
	mod_get_names("mod")[i] != "areadisplay" && 
	mod_get_names("mod")[i] != "ui"){
		mod_unload(mod_get_names("mod")[i]);
	} else {
		i++;
	}
}
for(i = 0; array_length(mod_get_names("weapon")) > 0; i=i){
	mod_unload(mod_get_names("weapon")[i]);
}
for(i = 0; array_length(mod_get_names("area")) > 0; i=i){
	mod_unload(mod_get_names("area")[i]);
}
for(i = 0; array_length(mod_get_names("crown")) > 0; i=i){
	mod_unload(mod_get_names("crown")[i]);
}
for(i = 0; array_length(mod_get_names("race")) > 0; i=i){
	mod_unload(mod_get_names("race")[i]);
}
for(i = 0; array_length(mod_get_names("skill")) > 0; i=i){
	mod_unload(mod_get_names("skill")[i]);
}
for(i = 0; array_length(mod_get_names("skin")) > 0; i=i){
	mod_unload(mod_get_names("skin")[i]);
}

with global.data.mods {
	switch self.download_type {
		case "itch":
			var api_key = "mD4JDfwnLXlsxPChbvGnttoOqHSNiYBmjTD1H2ya";
			file_delete("itchdata.json");
			while (file_exists("itchdata.json")) {wait 1;}
			file_download(self.url + "/data.json", "itchdata.json");
			while (!file_loaded("itchdata.json")) {wait 1;}
			while (!file_exists("itchdata.json")) {wait 1;}
			var modid = json_decode(string_load("itchdata.json")).id;
			
			file_delete(self.name + " data.json");
			while (file_exists(self.name + " data.json")) {wait 1;}
			file_download("https://api.itch.io/games/" + string(modid) + "/uploads?api_key=" + api_key, self.name + " data.json");
			while (!file_loaded(self.name + " data.json")) {wait 1;}
			while (!file_exists(self.name + " data.json")) {wait 1;}
			var out = json_decode(string_load(self.name + " data.json"));
			if("uploads" in out){
				with(out.uploads[0]){
					//check to see if it's just a .gml before unzipping
					if(string_length(filename) == 0){
						trace("ERROR: file is not held on itch.io servers, this downloader does not support external files.");
						return;
					}
					switch(string_lower(string_copy(filename, string_length(filename) - 3, 4))){
						case ".gml":
							file_download("https://api.itch.io/uploads/" + string(id) + "/download?api_key=" + api_key, "../../mods/WeeklyMods/" + filename);
							break;
						default:
							file_download("https://api.itch.io/uploads/" + string(id) + "/download?api_key=" + api_key, filename);
							file_delete("../../mods/WeeklyMods/" + other.name);
							while (file_exists("../../mods/WeeklyMods/" + other.name)) {wait 1;}
							zip_unzip(filename, "../../mods/WeeklyMods/" + other.name);
					}
					wait file_load("../../mods/WeeklyMods/" + other.name + "/main.txt");
					if !file_exists("../../mods/WeeklyMods/" + other.name + "/main.txt") {
						var subfiles = [];
						wait file_find_all("../../mods/WeeklyMods/" + other.name, subfiles);
						var maintxt = "";
						with(subfiles){
							if(self.ext == ""){
								maintxt += "/load " + self.name + chr(10)
							}else if(self.ext == ".txt" && self.name != "main.txt"){
								maintxt += "/load " + self.name + chr(10)
							}else if(self.ext == ".gml"){
								maintxt += "/loadmod " + self.name + chr(10)
							}
						}
						string_save(maintxt, "../../mods/WeeklyMods/" + other.name + "/main.txt")
					}
					trace(other.name + " Downloaded!");
					mod_loadtext("../../mods/WeeklyMods/" + other.name + "/main.txt");
				}
			}else{
				trace("ERROR: incorrect response. Recieved response was:");
				trace(out);
			}
			break;
	}
}

wait(30);

global.ModNames = "";
		     
var i = 0;
for(i = 0; array_length(mod_get_names("mod")) > i; i++){
	global.ModNames += mod_get_names("mod")[i]
}
for(i = 0; array_length(mod_get_names("weapon")) > i; i++){
	global.ModNames += mod_get_names("weapon")[i]
}
for(i = 0; array_length(mod_get_names("area")) > i; i++){
	global.ModNames += mod_get_names("area")[i]
}
for(i = 0; array_length(mod_get_names("crown")) > i; i++){
	global.ModNames += mod_get_names("crown")[i]
}
for(i = 0; array_length(mod_get_names("race")) > i; i++){
	global.ModNames += mod_get_names("race")[i]
}
for(i = 0; array_length(mod_get_names("skill")) > i; i++){
	global.ModNames += mod_get_names("skill")[i]
}
for(i = 0; array_length(mod_get_names("skin")) > i; i++){
	global.ModNames += mod_get_names("skin")[i]
}

var modtext = [];
with global.data.mods {
	array_push(modtext, self.name)
}

trace("Current Weekly:");
trace("Mods : " + array_join(modtext, ", "));
trace("Seed : " + string(global.data.seed));

if(global.qualified == true && !instance_exists(CharSelect)){
	with(Player){
		instance_destroy();
		global.qualified = false;
	}
	with(Revive){
		instance_destroy();
		global.qualified = false;
	}
	trace("Disqualified for uploading results. reload the Weekly mod from the character select screen to qualify again.");
}

global.canStart = true;

#define game_start
if(!global.active){return;}
room_speed = 30;
current_time_scale = 1;
global.finished = false;
game_set_seed(global.data.seed);
random_set_seed(global.data.seed);
global.start = true;

global.endData.alias = "";
global.endData.data = array_create(instance_number(Player));
global.endData.initialdata = array_create(instance_number(Player));
with(Player){
	if(global.endData.alias != ""){
		global.endData.alias += ", "
	}
	global.endData.alias += player_get_alias(index);
	global.endData.data[index] = {
		alias: player_get_alias(index),
		wep: wep,
		bwep: bwep,
		color: player_get_color(index),
		race: race,
		skin: bskin
	}
	global.endData.initialdata[index] = {
		alias: player_get_alias(index),
		wep: wep,
		bwep: bwep,
		color: player_get_color(index),
		race: race,
		skin: bskin
	}
}

#define step
cheat_check();

with(ProtoChest){instance_destroy();}

//This chunk is redundant and VERY slow.
/*
if(global.qualified == true && global.canStart && global.ModNames != ""){
	var ModNames = "";
		     
	var i = 0;
	for(i = 0; array_length(mod_get_names("mod")) > i; i++){
		ModNames += mod_get_names("mod")[i]
	}
	for(i = 0; array_length(mod_get_names("weapon")) > i; i++){
		ModNames += mod_get_names("weapon")[i]
	}
	for(i = 0; array_length(mod_get_names("area")) > i; i++){
		ModNames += mod_get_names("area")[i]
	}
	for(i = 0; array_length(mod_get_names("crown")) > i; i++){
		ModNames += mod_get_names("crown")[i]
	}
	for(i = 0; array_length(mod_get_names("race")) > i; i++){
		ModNames += mod_get_names("race")[i]
	}
	for(i = 0; array_length(mod_get_names("skill")) > i; i++){
		ModNames += mod_get_names("skill")[i]
	}
	for(i = 0; array_length(mod_get_names("skin")) > i; i++){
		ModNames += mod_get_names("skin")[i]
	}
	if(ModNames != global.ModNames){
		trace("Disqualified for uploading results. reload the weekly mod from the character select screen to qualify again. Reason: Incorrect mod list");
		global.qualified = false;
	}
}
*/
with(Player){
	global.endData.data[index] = {
		alias: player_get_alias(index),
		wep: wep,
		bwep: bwep,
		color: player_get_color(index),
		race: race,
		skin: bskin
	}
}

//clear game-over button
if instance_exists(GameOverButton) with GameOverButton {
	if num == 1 instance_delete(self);
}

if(!global.finished && !instance_exists(Player) && global.start){
	getCurrentDate();
	var score = "";
	with(GameCont){
		var modtext = [];
		with global.data.mods {
			array_push(modtext, self.name)
		}
		score = global.endData.alias + ": Area " + string(area) + "-" + string(subarea) + " L" + string(loops) + " Kills: " + string(kills) + " Character: " + race_get_name(global.endData.data[0].race) + " Mods:" + array_join(modtext, ", ") + " Seed:" + string(global.data.seed);
	}
	trace(score);
	global.finished = true;
	
	if(global.qualified){
		var mutationList = [];
		var i = 0;
		while (true) {
			var mut = skill_get_at(i++);
			if (mut == undefined) break;
			array_push(mutationList, mut);
		}
		
		var DataSubmission = {
			"name": global.endData.alias,
			"kills": GameCont.kills,
			"race": global.endData.data[0].race,
			"skin": global.endData.data[0].skin,
			"area": GameCont.area,
			"subarea": GameCont.subarea,
			"loop": GameCont.loops,
			"hard": GameCont.hard,
			"wep": global.endData.data[0].wep,
			"bwep": global.endData.data[0].bwep,
			"crown": GameCont.crown,
			"mutations": mutationList,
			"time": GameCont.timer,
			"death_cause": GameCont.deathcause,
			"color": global.endData.data[0].color,
			"allies": global.endData.data,
		}
	
		headers = ds_map_create();
		ds_map_set(headers, "Authorization", "token 7349069d71cc5b8e1165"+"40e940c2ad5650ea32de");
		ds_map_set(headers, "cache-control", "no-cache");
		ds_map_set(headers, "Accept", "application/vnd.github.full+json");	
		file_delete("dl.txt");
		while (file_exists("dl.txt")) {wait 1;}
		http_request('https://api.github.com/repos/GoldenEpsilon/NTT-Modded-Weeklies/contents/Dailies/' + global.currentDate + '/leaderboard.json'
		, "GET", headers,
		''
		, "dl.txt");
		while (!file_loaded("dl.txt")) {wait 1;}
		var dl = "404";
		var leaderboard = "";
		if(string_count('"message":"Not Found"', string_load("dl.txt")) >= 1 || string_count('Bad Credentials', string_load("dl.txt")) >= 1){
			leaderboard = dl;
		}else{
			dl = string_split(string_split(string_load("dl.txt"), '","encoding":"base64"')[0],'"content":"')[1];
			dl = string_replace_all(dl, "\" + "n", "");
			leaderboard = base64Decode(dl);
		}
		file_unload("dl.txt");
		if(string_copy(leaderboard, 0, 3) == "404" || json_decode(leaderboard) == json_error){
			http_request('https://api.github.com/repos/GoldenEpsilon/NTT-Modded-Weeklies/contents/Dailies/' + global.currentDate + '/leaderboard.json'
			, "PUT", headers,
			'{
			"message":"Leaderboard Update (New leaderboard!) (' + DataSubmission.name + ')",
			"content":"'+base64(json_encode({scores: [DataSubmission]}))+'"
			}'
			, "out.txt");
		}else{
			leaderboard = json_decode(leaderboard);
			var fail = false;
			for(var i = 0; i < array_length(leaderboard.scores); i++){
				// Checking specifically player 1
				if leaderboard.scores[i].allies[0].alias == DataSubmission.allies[0].alias {
					fail = true;
				}
			}
			array_push(leaderboard.scores, DataSubmission);
			if(!global.data.can_resubmit || !fail){
				file_delete("sha.txt");
				while (file_exists("sha.txt")) {wait 1;}
				http_request('https://api.github.com/repos/GoldenEpsilon/NTT-Modded-Weeklies/contents/Dailies/' + global.currentDate + '/leaderboard.json'
				, "GET", headers,
				''
				, "sha.txt");
				while (!file_loaded("sha.txt")) {wait 1;}
				wait file_load("sha.txt");
				sha = string_split(string_split(string_load("sha.txt"), '"sha":"')[1], '"')[0];
				file_unload("sha.txt");
				http_request('https://api.github.com/repos/GoldenEpsilon/NTT-Modded-Weeklies/contents/Dailies/' + global.currentDate + '/leaderboard.json'
				, "PUT", headers,
				'{
				"message":"Leaderboard Update (' + DataSubmission.name + ')",
				"content":"'+base64(json_encode(leaderboard))+'",
				"sha":"'+sha+'"
				}'
				, "out.txt");
			}else{
				trace("You've already played this Daily!");
			}
		}
		wait(60);
		loadLeaderboards()
	}else{
		trace("You were disqualified, so your scores were not uploaded.");
	}
}
	
#define draw_pause
//remove restart buttons
if instance_exists(button) with button {
	if num == 1 || num == 0 {
		instance_delete(self);
	}
}

cheat_check();
/*
with button {
	trace(variable_instance_get_names(self));
	if num == 1 instance_delete
}
*/
#define cheat_check
//Spawn setkey to prevent opening chat
if !instance_exists(global.NoChat) {
	with instance_create(x,y,SetKey) {
		persistent = true;
		global.NoChat = self;
	}
}

//old chat failsafe is still nice as a backup
if(global.qualified){
	for(var p = 0; p < maxp; p++){
		if(button_check(p, "talk")){
			if(global.cheating[p] == 0){
				trace("PLAYER " + string(p+1) + ", IF YOU ARE NOT A CHEATER SAY SOMETHING");
				trace("DO NOT PRESS ESCAPE, DO NOT SEND AN EMPTY MESSAGE");
			}
			global.cheating[p] = 1;
			global.regChat[p] = false;
		}else if(global.cheating[p] == 1){
			if(global.regChat[p]){
				global.cheating[p] = 0;
			}else{
				trace("Player " + string(p+1) + " could have run a command, I cannot verify, this session is disqualified. Restart the session to re-qualify.");
				global.qualified = false;
				global.cheating[p] = 0;
			}
		}
	}
}

#define draw_gui
if(!global.active){return;}
draw_set_font(fntSmall);
if(global.qualified == true){
	draw_text_nt(game_width - 25, game_height - 6, "Weekly");
}else{
	draw_text_nt(game_width - 7*4 - 25, game_height - 12, "DISQUALIFIED#       Weekly");
}

#define draw_gui_end
for(var p = 0; p < maxp; p++){
	if(global.cheating[p] == 1){
		draw_set_color(make_color_rgb(51, 37, 30));
		draw_rectangle(game_width/2-151, game_height/2-20, game_width/2+157, game_height/2+20, 0);
		draw_set_halign(1);
		draw_set_valign(1);
		draw_set_font(fntM0);
		draw_text_nt(game_width/2+5, game_height/2, "@rPLAYER " + string(p+1) + ",#IF YOU ARE NOT A CHEATER SAY SOMETHING.#DO NOT PRESS ESCAPE,#DO NOT SEND AN EMPTY MESSAGE");
		draw_set_halign(0);
		draw_set_valign(0);
	}
}

#define chat_message(_message, _player)
global.regChat[_player] = 1;

#define loadLeaderboards()
if(fork()){
	global.headers = ds_map_create();
	ds_map_set(global.headers, "Authorization", "token 7349069d71cc5b8e1165"+"40e940c2ad5650ea32de");
	ds_map_set(global.headers, "cache-control", "no-cache");	
	ds_map_set(global.headers, "Accept", "application/vnd.github.full+json");
	file_delete("leaderboard.json");
	while (file_exists("leaderboard.json")) {wait 1;}
	http_request('https://raw.githubusercontent.com/GoldenEpsilon/NTT-Modded-Weeklies/main/Dailies/' + global.currentDate + '/leaderboard.json'
	, "GET", global.headers,
	''
	, "leaderboard.json");
	while (!file_loaded("leaderboard.json")) {wait 1;}
	var dl = {scores: []};
	if(array_length(string_split(string_load("leaderboard.json"), chr(34)+"message"+chr(34)+":"+chr(34)+"Not Found"+chr(34))) == 1){
		dl = json_decode(string_load("leaderboard.json"));
	}
	file_unload("leaderboard.json");
	if dl != json_error {
		global.leaderboard = dl;
		mod_variable_set("mod", "ui", "scoreboard", global.leaderboard.scores);
	}
	exit;
}

#define getCurrentDate()
var checkDate = false
var prevDate = "";
if global.currentDate != "" {
	checkDate = true
	prevDate = global.currentDate;
}

//file_download("http://worldclockapi.com/api/json/est/now", "ping.txt");
file_load("ping.txt")
var d = 0;
while (!file_loaded("ping.txt")){
	if d++ > 100 break;
	wait 1;
}
var str = string_load("ping.txt");
if is_undefined(str){
	trace("ERROR: Cannot connect to worldclockapi. Date cannot be loaded");
}
file_unload("ping.txt");
var json = json_decode(str);
if json = json_error{
	if(fork()){
		wait 5;
		trace("ERROR: World Clock API could not be reached!");
		trace("         Date and Time could not be fetched!");
		exit;
	}
	json = {};
	global.currentDate = "0-0-0";
	json.dayOfTheWeek = "Sunday";
} else {
	global.currentDate = string_copy(json.currentDateTime, 1, string_pos("T", json.currentDateTime) - 1);
}

var weekOffset = 0;
switch(json.dayOfTheWeek){
	case "Sunday": weekOffset = 0; break;
	case "Monday": weekOffset = 1; break;
	case "Tueday": weekOffset = 2; break;
	case "Wednesday": weekOffset = 3; break;
	case "Thursday": weekOffset = 4; break;
	case "Friday": weekOffset = 5; break;
	case "Saturday": weekOffset = 6; break;
}
global.currentWeek = string_split(global.currentDate, "-");
global.currentWeek = global.currentWeek[0]+"-"+global.currentWeek[1]+"-"+string(real(global.currentWeek[2]) - weekOffset)

if checkDate && prevDate != global.currentDate {
	global.qualified = false;
	trace("It is now a different day than when the mod was loaded. You have been disqualified.");
}

#define base64(str)
var retVal = "";
for(var i = 0; i < string_length(str)/3; i++){
	if(string_length(str)/3-i>=1){
		ord1 = string_ord_at(str, i*3+1);
		ord2 = string_ord_at(str, (i*3)+2);
		ord3 = string_ord_at(str, (i*3)+3);
		char1 = base64Char((ord1&252)/4);
		char2 = base64Char((ord1&3)*16+(ord2&240)/16);
		char3 = base64Char((ord2&15)*4+(ord3&192)/64);
		char4 = base64Char(ord3&63);
		retVal += string(char1)+string(char2)+string(char3)+string(char4);
	}else if(string_length(str) - i*3 == 2){
		ord1 = string_ord_at(str, i*3+1);
		ord2 = string_ord_at(str, (i*3)+2);
		char1 = base64Char((ord1&252)/4);
		char2 = base64Char((ord1&3)*16+(ord2&240)/16);
		char3 = base64Char((ord2&15)*4);
		retVal += string(char1)+string(char2)+string(char3)+"=";
	}else if(string_length(str) - i*3 == 1){
		ord1 = string_ord_at(str, i*3+1);
		char1 = base64Char((ord1&252)/4);
		char2 = base64Char((ord1&3)*16);
		retVal += string(char1)+string(char2)+"==";
	}
}
return retVal;
#define base64Char(num)
var retVal = "=";
switch(num){
	case 0:retVal = "A";break;
	case 1:retVal = "B";break;
	case 2:retVal = "C";break;
	case 3:retVal = "D";break;
	case 4:retVal = "E";break;
	case 5:retVal = "F";break;
	case 6:retVal = "G";break;
	case 7:retVal = "H";break;
	case 8:retVal = "I";break;
	case 9:retVal = "J";break;
	case 10:retVal = "K";break;
	case 11:retVal = "L";break;
	case 12:retVal = "M";break;
	case 13:retVal = "N";break;
	case 14:retVal = "O";break;
	case 15:retVal = "P";break;
	case 16:retVal = "Q";break;
	case 17:retVal = "R";break;
	case 18:retVal = "S";break;
	case 19:retVal = "T";break;
	case 20:retVal = "U";break;
	case 21:retVal = "V";break;
	case 22:retVal = "W";break;
	case 23:retVal = "X";break;
	case 24:retVal = "Y";break;
	case 25:retVal = "Z";break;
	case 26:retVal = "a";break;
	case 27:retVal = "b";break;
	case 28:retVal = "c";break;
	case 29:retVal = "d";break;
	case 30:retVal = "e";break;
	case 31:retVal = "f";break;
	case 32:retVal = "g";break;
	case 33:retVal = "h";break;
	case 34:retVal = "i";break;
	case 35:retVal = "j";break;
	case 36:retVal = "k";break;
	case 37:retVal = "l";break;
	case 38:retVal = "m";break;
	case 39:retVal = "n";break;
	case 40:retVal = "o";break;
	case 41:retVal = "p";break;
	case 42:retVal = "q";break;
	case 43:retVal = "r";break;
	case 44:retVal = "s";break;
	case 45:retVal = "t";break;
	case 46:retVal = "u";break;
	case 47:retVal = "v";break;
	case 48:retVal = "w";break;
	case 49:retVal = "x";break;
	case 50:retVal = "y";break;
	case 51:retVal = "z";break;
	case 52:retVal = "0";break;
	case 53:retVal = "1";break;
	case 54:retVal = "2";break;
	case 55:retVal = "3";break;
	case 56:retVal = "4";break;
	case 57:retVal = "5";break;
	case 58:retVal = "6";break;
	case 59:retVal = "7";break;
	case 60:retVal = "8";break;
	case 61:retVal = "9";break;
	case 62:retVal = "+";break;
	case 63:retVal = "/";break;
}
return retVal;
#define base64Decode(str)
var retVal = "";
for(var i = 0; i < string_length(str)/4; i++){
	if(string_length(str)/4-i>=1){
		ord1 = base64CharDecode(string_char_at(str, (i*4)+1));
		ord2 = base64CharDecode(string_char_at(str, (i*4)+2));
		ord3 = base64CharDecode(string_char_at(str, (i*4)+3));
		ord4 = base64CharDecode(string_char_at(str, (i*4)+4));
		char1 = chr(ord1 * 4 + (ord2 & 48) / 16);
		char2 = chr((ord2 & 15) * 16 + (ord3 & 60)/4);
		char3 = chr((ord3&3)*64+ord4);
		retVal += string(char1)+string(char2)+string(char3);
	}
}
return retVal;
#define base64CharDecode(str)
var retVal = 0;
switch(str){
	case "A":retVal = 0;break;
	case "B":retVal = 1;break;
	case "C":retVal = 2;break;
	case "D":retVal = 3;break;
	case "E":retVal = 4;break;
	case "F":retVal = 5;break;
	case "G":retVal = 6;break;
	case "H":retVal = 7;break;
	case "I":retVal = 8;break;
	case "J":retVal = 9;break;
	case "K":retVal = 10;break;
	case "L":retVal = 11;break;
	case "M":retVal = 12;break;
	case "N":retVal = 13;break;
	case "O":retVal = 14;break;
	case "P":retVal = 15;break;
	case "Q":retVal = 16;break;
	case "R":retVal = 17;break;
	case "S":retVal = 18;break;
	case "T":retVal = 19;break;
	case "U":retVal = 20;break;
	case "V":retVal = 21;break;
	case "W":retVal = 22;break;
	case "X":retVal = 23;break;
	case "Y":retVal = 24;break;
	case "Z":retVal = 25;break;
	case "a":retVal = 26;break;
	case "b":retVal = 27;break;
	case "c":retVal = 28;break;
	case "d":retVal = 29;break;
	case "e":retVal = 30;break;
	case "f":retVal = 31;break;
	case "g":retVal = 32;break;
	case "h":retVal = 33;break;
	case "i":retVal = 34;break;
	case "j":retVal = 35;break;
	case "k":retVal = 36;break;
	case "l":retVal = 37;break;
	case "m":retVal = 38;break;
	case "n":retVal = 39;break;
	case "o":retVal = 40;break;
	case "p":retVal = 41;break;
	case "q":retVal = 42;break;
	case "r":retVal = 43;break;
	case "s":retVal = 44;break;
	case "t":retVal = 45;break;
	case "u":retVal = 46;break;
	case "v":retVal = 47;break;
	case "w":retVal = 48;break;
	case "x":retVal = 49;break;
	case "y":retVal = 50;break;
	case "z":retVal = 51;break;
	case "0":retVal = 52;break;
	case "1":retVal = 53;break;
	case "2":retVal = 54;break;
	case "3":retVal = 55;break;
	case "4":retVal = 56;break;
	case "5":retVal = 57;break;
	case "6":retVal = 58;break;
	case "7":retVal = 59;break;
	case "8":retVal = 60;break;
	case "9":retVal = 61;break;
	case "+":retVal = 62;break;
	case "/":retVal = 63;break;
}
return retVal;

#define checkForUpdates(_name, _repo)
//loading the previous version file. 
//The version file is a list of commits github provides, this mod just checks the sha
file_load(_name+"version.json");
while (!file_loaded(_name+"version.json")) {wait 1;}
var oldjson = false;
if(file_exists(_name+"version.json")){
	oldjson = json_decode(string_load(_name+"version.json"));
}

//downloading the new version file over the old one
//I delete for safety, there's a chance it isn't necessary
file_delete(_name+"version.json");
while (file_exists(_name+"version.json")) {wait 1;}
wait file_unload(_name+"version.json");
wait file_download("https://api.github.com/repos/" + _repo + "/commits", _name+"version.json");
file_load(_name+"version.json");
while (!file_loaded(_name+"version.json")) {wait 1;}
while (!file_exists(_name+"version.json")) {wait 1;}
var newjson = json_decode(string_load(_name+"version.json"));
wait file_unload(_name+"version.json");
while(global.forks > 0){wait(1);}
if(oldjson == false){
	updateFiles(_name, _repo);
}

#define updateFiles(_name, _repo)
	trace_color("Updating Files!", c_purple);
	
	file_delete(_name+"branches.json");
	while (file_exists(_name+"branches.json")) {wait 1;}
	wait file_unload(_name+"branches.json");
	trace_color("Downloading branches...", c_purple);
	wait file_download("https://api.github.com/repos/" + _repo + "/branches", _name+"branches.json");
	trace_color("Branches downloaded...", global.update_color);
	file_load(_name+"branches.json");
	while (!file_loaded(_name+"branches.json")) {wait 1;}
	while (!file_exists(_name+"branches.json")) {wait 1;}
	var branches = json_decode(string_load(_name+"branches.json"));
	wait file_unload(_name+"branches.json");
	
	if(branches != json_error){
		if(is_array(branches)){
			file_delete(_name+"tree.json");
			while (file_exists(_name+"tree.json")) {wait 1;}
			wait file_unload(_name+"tree.json");
			trace_color("Downloading commit data...", c_purple);
			wait file_download("https://api.github.com/repos/" + _repo + "/git/trees/"+branches[0].commit.sha+"?recursive=1", _name+"tree.json");
			file_load(_name+"tree.json");
			trace_color("Commit data downloaded...", c_purple);
			while (!file_loaded(_name+"tree.json")) {wait 1;}
			while (!file_exists(_name+"tree.json")) {wait 1;}
			var tree = json_decode(string_load(_name+"tree.json"));
			wait file_unload(_name+"tree.json");
			if(tree != json_error){
				with(tree.tree){
					if(type == "blob" && (string_count(path, "main") || string_count(path, "mod")) && fork()){
						global.forks++;
						//Replace a file
						file_delete("../../mods/" + _name + "/" + path);
						while (file_exists("../../mods/" + _name + "/" + path)) {wait 1;}
						wait file_download("https://raw.githubusercontent.com/" + _repo + "/" + branches[0].name + "/" + path, "../../mods/" + _name + "/" + path);
						while (!file_exists("../../mods/" + _name + "/" + path)) {wait 1;}
						global.forks--;
						exit;
					}
				}
				wait(0);
				var forks = global.forks;
				while(global.forks > 0){
					trace_color("Update for "+_name+" is "+string(round((1-(global.forks/forks))*100))+"% done.", c_purple);
					wait(30);
				}
			}else{
				//set it to download again when it can
				file_delete(_name+"tree.json");
				trace_color("ERROR. Were you downloading too much at once?", c_purple);
			}
			if("message" in tree){
				trace_color(tree.message, c_purple);
			}
		}else{
			//set it to download again when it can
			file_delete(_name+"branches.json");
			trace_color("ERROR. Were you downloading too much at once?", c_purple);
		}
	}
	trace_color("Update for " + _name + " complete!", c_purple);
	mod_loadtext("../../mods/" + _name + "/" + "main.txt");
