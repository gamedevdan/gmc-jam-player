// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function reset() {
	file_delete("personal_jam_data.ini");
	
	load_data();
}