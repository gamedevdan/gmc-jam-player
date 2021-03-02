// Before doing anything else in this step, check the various data structures exist
// and error with a human-readable message
// This avoids bog standard GML errors if something goes wrong.
if !(ds_exists(global.JAM_DATABASE,ds_type_grid)) {
	
	show_error("ERROR: Database was destroyed somehow, please re-open the jam randomiser.",true);
	
}

if !(ds_exists(global.LIST_TOPLAY,ds_type_list)) {
	
	show_error("ERROR: Game play queue was destroyed somehow, please re-open the jam randomiser.",true);
	
}

if !(ds_exists(global.LIST_TORANK,ds_type_list)) {
	
	show_error("ERROR: Game rank queue was destroyed somehow, please re-open the jam randomiser.",true);
	
}

// Decrease the mouse wheel delay towards zero
if (wheel_delay>0) {
	
	wheel_delay--;
	
}

// Store the size of the unranked list in a temporary variable for later use
var unranksize = ds_list_size(global.LIST_TORANK);

// Clamp the column offset for the left hand column so the user can't scroll out of bounds
column_a_offset = clamp(column_a_offset,0-((unranksize-1)*32),0);

if (is_mouse_here(16,124,336,room_height)) {
	
	// If the mouse is hovering over the left hand column (the unranked list)
	
	// If the mouse wheel moves up and the wheel_delay has reached zero:
	// Scroll the column
	if (mouse_wheel_up() && wheel_delay<1) {
		column_a_offset = clamp(column_a_offset+32,0-((unranksize-1)*32),0);
		wheel_delay = 3;
	}
	
	// If the mouse wheel moves down and the wheel_delay has reached zero:
	// Scroll the column
	if (mouse_wheel_down() && wheel_delay<1) {
		column_a_offset = clamp(column_a_offset-32,0-((unranksize-1)*32),0);
		wheel_delay = 3;
	}
	
	// If the mouse is clicked on the left hand column
	if (mouse_check_button_pressed(mb_left)) {
	
		// If the mouse is clicking on the "shift" arrow next to one of the entries in this column
		if (is_mouse_here(304,124,336,140+column_a_offset+(unranksize*32))) {
		
			// Get the ID for the entry being clicked
			var _thisEntry = (mouse_y-124-column_a_offset) div 32;
		
			// Make sure this is a valid entry, not out of bounds of the data structure
			if (_thisEntry < unranksize) {
				
				// Move the unranked entry into the ranked leaderboard
				// Moving the entry currently in that space on the leaderboard down if we need to
				
				// Get the row we're currently scrolled to in the right hand column
				var _rightEntry = (mouse_y-124-column_b_offset) div 32;
				
				// Get the current "bottom" of the leaderboard
				var _maxEntry = 0;
				for (var i2=0;i2<global.GAME_MAX;i2++) {
					if (global.LEADERBOARD[i2]<0) {
						_maxEntry = i2;
						break;
					}
				}
				
				// If the row we've scrolled to in the right hand column is "out of bounds",
				// i.e. higher than the number of games, or higher than the currently bottom ranked entry,
				// then set the currently selected right-hand row to the "correct" or "maximum possible" row.
				if (_rightEntry > global.GAME_MAX || _rightEntry > _maxEntry) {
						_rightEntry = _maxEntry;
				}
				
				
				if (global.LEADERBOARD[_rightEntry]<0) {
					
					// If the row in the right-hand column is empty (its ID # is below 0)
					// Put this game in that slot
					global.LEADERBOARD[_rightEntry] = ds_list_find_value(global.LIST_TORANK,_thisEntry);
					
				} else {
					
					// If the row in the right-hand column was not empty, we need to move games
					// down the rankings to make room for the one we're currently ranking
					
					// Loop through the leaderboard moving everything below the current row down a rank
					for (var q=(global.GAME_MAX-1);q>_rightEntry;q--) {
						global.LEADERBOARD[q] = global.LEADERBOARD[q-1];	
					}
					
					// Shift the current game into the rankings
					global.LEADERBOARD[_rightEntry] = ds_list_find_value(global.LIST_TORANK,_thisEntry);
				}
				
				// Delete the current game from the unranked list
				ds_list_delete(global.LIST_TORANK,_thisEntry);
				
				// Save the changes
				save_data();
			
			}
		
		} else if (is_mouse_here(16,124,303,140+column_a_offset+(unranksize*32))) {
			
			// If one of the games in the left-hand column is being clicked by *name* but is not 
			// having its "shift" arrow clicked
			
			// Get the ID of the entry based on the mouse position
			var _thisEntry = (mouse_y-124-column_a_offset) div 32;
			
			// Check this ID is within the bounds of the unranked ds list
			if (_thisEntry < unranksize) {
				
				// Set game currently being viewed in the info panel to this one
				global.CURRENT_GAME = ds_list_find_value(global.LIST_TORANK,_thisEntry);
			}
			
		}
	
	}
	
} else if (is_mouse_here(352,124,672,room_height)) {
	
	// If the mouse is currently hovering over the right-hand column (the leaderboard)
	
	// If the mouse wheel moves up and the wheel_delay has reached zero:
	// Scroll the column
	if (mouse_wheel_up() && wheel_delay<1) {
		column_b_offset = clamp(column_b_offset+32,0-((global.GAME_MAX-1)*32),0);
		wheel_delay = 3;
	}
	
	// If the mouse wheel moves down and the wheel_delay has reached zero:
	// Scroll the column
	if (mouse_wheel_down() && wheel_delay<1) {
		column_b_offset = clamp(column_b_offset-32,0-((global.GAME_MAX-1)*32),0);
		wheel_delay = 3;
	}
	
	// If the mouse is clicked on the right hand column
	if (mouse_check_button_pressed(mb_left)) {
	
		if (is_mouse_here(608,124,639,140+column_b_offset+((global.GAME_MAX-1)*32))) {
			
			// If the mouse is clicking the "downvote" arrow for a game
		
			// Get the ID of the game
			var _thisEntry = (mouse_y-124-column_b_offset) div 32;
		
			// Make sure the game ID is valid (not out of bounds in some way)
			if (_thisEntry > -1 && _thisEntry < (global.GAME_MAX-1)) {

					if (global.LEADERBOARD[_thisEntry+1]>-1) {
						// If the game is not already at the bottom of the leaderboard
						
						// Store the ID of the game currently below this one
						var _tempVal =  global.LEADERBOARD[_thisEntry+1];
						
						// Change the ID of the slot below this one to the game we are currently downvoting
						global.LEADERBOARD[_thisEntry+1] = global.LEADERBOARD[_thisEntry];
						
						// Put the other game above this one (swap them around)
						global.LEADERBOARD[_thisEntry] = _tempVal;
						
						// Save the changes
						save_data();
					
					}
			
			}
		
		} else if (is_mouse_here(640,124,672,140+column_b_offset+(global.GAME_MAX*32))) {
			
			// If the mouse is clicking the "upvote" arrow for a game
			
			// Get the ID of the game
			var _thisEntry = (mouse_y-124-column_b_offset) div 32;
		
			// Make sure the game ID is valid (not out of bounds in some way)
			// And is not already at the top of the leaderboard
			if (_thisEntry > 0 && _thisEntry < global.GAME_MAX) {
				
					// Store the ID of the game currently above this one
					var _tempVal =  global.LEADERBOARD[_thisEntry-1];
					
					// Change the ID of the slot to match the ID of the game we are upvoting
					global.LEADERBOARD[_thisEntry-1] = global.LEADERBOARD[_thisEntry];
					
					// Put the other game below this one (Swap them around)
					global.LEADERBOARD[_thisEntry] = _tempVal;
					
					// Save the changes
					save_data();
					
			}
			
		} else if (is_mouse_here(352,124,607,140+column_b_offset+((global.GAME_MAX-1)*32))) {
			
			// If the entry is being clicked by *name* (i.e. not being clicked on one of the voting arrows)
			
			// Get the ID of this game
			var _thisEntry = (mouse_y-124-column_b_offset) div 32;
			
			// Make sure the game ID is valid (not out of bounds in some way)
			if (_thisEntry > -1 && _thisEntry < global.GAME_MAX) {
				
				// Make sure this leaderboard slot is actually filled
				if (global.LEADERBOARD[_thisEntry]>-1) {
					
						// Set the game currently being viewed in the info panel to this entry
						global.CURRENT_GAME = global.LEADERBOARD[_thisEntry];
						
				}
				
			}
		}
	
	}
	
}
