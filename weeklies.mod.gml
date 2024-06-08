var _name = "weeklies";
var _repo = "GoldenEpsilon/NTT-Modded-Weeklies";

global.forks = 0;

cansideload = 1;

while(!mod_sideload()){wait 1;}

trace_color("Downloading Modded Weeklies!", c_purple);
	
file_delete(_name+"branches.json");
while (file_exists(_name+"branches.json")) {wait 1;}
wait file_unload(_name+"branches.json");
trace_color("Downloading branches...", c_purple);
wait file_download("https://api.github.com/repos/" + _repo + "/branches", _name+"branches.json");
trace_color("Branches downloaded...", c_purple);
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
                if(type == "blob" && string_count("mod/", path) && fork()){
                    var newpath = string_replace(path, "mod/", "")
                    global.forks++;
                    //Replace a file
                    file_delete("../../mods/" + _name + "/" + newpath);
                    while (file_exists("../../mods/" + _name + "/" + newpath)) {wait 1;}
                    wait file_download("https://raw.githubusercontent.com/" + _repo + "/" + branches[0].name + "/" + path, "../../mods/" + _name + "/" + newpath);
                    while (!file_exists("../../mods/" + _name + "/" + newpath)) {wait 1;}
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
trace_color(_name + " download complete!", c_purple);
string_save("/load main.txt", "../../mods/" + _name + "/" + "reload.txt");
wait file_load("../../mods/" + _name + "/" + "reload.txt");
while !file_exists("../../mods/" + _name + "/" + "reload.txt") wait(0)
mod_loadtext(_name + "/" + "reload.txt");