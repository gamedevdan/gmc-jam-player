function init(){

	// Always randomise at the start of a project which includes random elements
	randomise();

	// Set the main drawing font
	draw_set_font(fntSmall);

	// Load in the jam database from a CSV in the base folder
	// In the github project this is an included file, but in actual jam situations this could be copy & pasted into the base folder by the host
	global.JAM_DATABASE = load_csv("jam_data.csv");

	// Catch any errors creating the database and abort the player
	if !(ds_exists(global.JAM_DATABASE,ds_type_grid)) {

		show_error("ERROR: Could not load the jam database file. You may need to redownload this randomiser.",true);
	
	}
	
	// Check how many games were listed in the CSV and save this to a global variable
	global.GAME_MAX = ds_grid_height(global.JAM_DATABASE);

	// Open the save data ini to read information on things the user has already voted for
	load_data();

	// Create DS lists to store which games are left to be played and which are left to be ranked
	global.LIST_TOPLAY = ds_list_create();
	global.LIST_TORANK = ds_list_create();

	// Loop through the save data we just loaded in adding games to the correct unplayed/uranked ds lists
	for (var i=0;i<global.GAME_MAX;i++) {

		if (global.GAME_PLAYED[i] < 1) {
	
			ds_list_add(global.LIST_TOPLAY,i);
	
		}
	
		if (global.GAME_PLAYED[i] > 0 && global.GAME_RANK[i] < 0) {
	
			ds_list_add(global.LIST_TORANK,i);
	
		}

	}

	// Shuffle the "to play" list so the user plays them in a random order
	ds_list_shuffle(global.LIST_TOPLAY);

}