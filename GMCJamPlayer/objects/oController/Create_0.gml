// Initialise the project
macros_and_globals();
init();

// Set a variable for the currently highlighted / selected game
global.CURRENT_GAME = -1;

// Set how far up each column has been scrolled
// Also set the mouse wheel delay to 0
// This delay will be set to a hard value later on so the UI doesn't scroll too fast
column_a_offset = 0;
column_b_offset = 0;
wheel_delay = 0;
