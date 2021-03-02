/*

For some reason this cleanup event breaks in GMS 2.3.1.542
and will not compile. It works fine in GMS 2.2.

Since this clean up event only every happens at game end - and GM should clean
up its own memory use anyway - this has been commented out for now.

// Check if the jam database exists and clean it from memory
if (ds_exists(global.JAM_DATABASE,ds_type_grid)) {
	
	ds_grid_destroy(global.JAM_DATABASE);
	
}

// Check if the unplayed list exists and clean it from memory
if (ds_exists(global.LIST_TOPLAY,ds_type_list)) {
	
	ds_list_destroy(global.LIST_TOPLAY);
	

// Check if the unranked list exists and clean it from memory
if (ds_exists(global.LIST_TORANK,ds_type_list)) {
	
	ds_list_destroy(global.LIST_TORANK);
	
}

*/
