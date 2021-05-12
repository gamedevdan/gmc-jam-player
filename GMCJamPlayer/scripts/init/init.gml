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

	// Initialize global variable for the currently selected game
	global.CURRENT_GAME = -1;

	// Initialize global variables to store the games left to play and rank
	global.LIST_TOPLAY = -1;
	global.LIST_TORANK = -1;

	// Open the save data ini to read information on things the user has already voted for
	load_data();
}