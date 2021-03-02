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


// Set the font and the drawing alignment
draw_set_font(fntSmall);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

// Loop through the "unranked" list so we can draw the left-hand column
for (var i=0;i<ds_list_size(global.LIST_TORANK);i++) {

	// Set the color of the background rows in this list
	// By default they alternate between light and dark grey
	var _boxColor = $212121;
	if (i mod 2 == 0) {
		_boxColor = $333333;	
	}
	
	// This would change the background of the selected game to GREEN
	// but it is not currently functional as the variable column_a_selected is not currently used
	if (i == column_a_selected) {
		_boxColor = C_GREEN_DARK;	
	}
	
	// Draw the background rectangle for an entry
	draw_set_color(_boxColor);
	draw_rectangle(16,124+column_a_offset+(i*32),336,156+column_a_offset+(i*32),0);
	
	// Draw the name & author of the current entry in this slot
	draw_set_color(C_TEXT);
	var _gameID = ds_list_find_value(global.LIST_TORANK,i);
	var _theString = string(global.GAME_NAME[_gameID])+" by "+string(global.GAME_AUTHORS[_gameID]);
	if (string_length(_theString)>40) {
		// If the name & author string is too long, cut it off
		_theString = string_copy(_theString,1,37)+"...";	
	}
	draw_text(24,140+column_a_offset+(i*32),_theString);
	
	// Draw the "shift" arrow sprite
	draw_sprite(sShift,0,304,124+column_a_offset+(i*32));
	
}

// Loop through the leaderboard to draw the right-hand column
for (var i = 0;i<global.GAME_MAX;i++) {
	
	// Set the color of the background rows in this list
	// By default they alternate between light and dark grey
	var _boxColor = $212121;
	if (i mod 2 == 0) {
		_boxColor = $333333;	
	}
	
	// This would change the background of the selected game to GREEN
	// but it is not currently functional as the variable column_b_selected is not currently used
	if (i == column_b_selected) {
		_boxColor = C_GREEN_DARK;	
	}
	
	// Draw the background rectangle for an entry
	draw_set_color(_boxColor);
	draw_rectangle(352,124+column_b_offset+(i*32),672,156+column_b_offset+(i*32),0);
	
	// Draw the name & author of the current entry in this slot
	draw_set_color(C_TEXT);
	var _gameID = global.LEADERBOARD[i];
	var _theString = string(i+1)+".  ";
	if !(_gameID == -1) {
		_theString += string(global.GAME_NAME[_gameID])+" by "+string(global.GAME_AUTHORS[_gameID]);
		if (string_length(_theString)>35) {
			// If the name & author string is too long, cut it off
			_theString = string_copy(_theString,1,32)+"...";	
		}
		
	}
	draw_text(360,140+column_b_offset+(i*32),_theString);
	
	// Draw the "downvote" and "upvote" arrows for this slot
	draw_sprite(sVoting,0,608,124+column_b_offset+(i*32));
	draw_sprite(sVoting,1,640,124+column_b_offset+(i*32));
	
}

// At the bottom of the leaderboard, draw the games which the user has currently put into each of the "best of" categories
var _theString = "";

if (global.AWARD_THEME>-1) {
	_theString += "Best use of Theme\n"+global.GAME_NAME[global.AWARD_THEME]+" by "+global.GAME_AUTHORS[global.AWARD_THEME]+"\n\n";	
} else {
	_theString += "Best use of Theme\nNot Yet Decided\n\n";
}

if (global.AWARD_CONCEPT>-1) {
	_theString += "Best Concept\n"+global.GAME_NAME[global.AWARD_CONCEPT]+" by "+global.GAME_AUTHORS[global.AWARD_CONCEPT]+"\n\n";	
} else {
	_theString += "Best Concept\nNot Yet Decided\n\n";
}

if (global.AWARD_PRESENTATION>-1) {
	_theString += "Best Presentation\n"+global.GAME_NAME[global.AWARD_PRESENTATION]+" by "+global.GAME_AUTHORS[global.AWARD_PRESENTATION]+"\n\n";	
} else {
	_theString += "Best Presentation\nNot Yet Decided\n\n";
}

if (global.AWARD_STORY>-1) {
	_theString += "Best Story\n"+global.GAME_NAME[global.AWARD_STORY]+" by "+global.GAME_AUTHORS[global.AWARD_STORY]+"\n\n";	
} else {
	_theString += "Best Story\nNot Yet Decided\n\n";
}

if (global.AWARD_DEVLOG>-1) {
	_theString += "Best Devlog\n"+global.GAME_NAME[global.AWARD_DEVLOG]+" by "+global.GAME_AUTHORS[global.AWARD_DEVLOG]+"\n\n";	
} else {
	_theString += "Best Devlog\nNot Yet Decided\n\n";
}

// If the string of "best ofs" is going to be too big, squish it
var _theScale = 1;
if (string_width(_theString)>320) {
	_theScale = 320/string_width(_theString);
}

// Finally actually draw the best ofs
draw_set_valign(fa_top);
draw_text_transformed(360,160+column_b_offset+(global.GAME_MAX*32),_theString,_theScale,_theScale,0);

// If we have currently clicked on a game to view its info in the info panel
if (global.CURRENT_GAME>-1) {
	
	// Set the large font, color and alignment
	draw_set_font(fntLarge);
	draw_set_color(C_TEXT);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// Check the width of the game title and prepare to "squash" it horizontally to make it fit within this column
	var _strScale = 1;
	var _strWidth = string_width(global.GAME_NAME[global.CURRENT_GAME]);
	if (_strWidth>288) {_strScale = 288/_strWidth;}
	
	// Draw the game title
	draw_text_transformed(848,156,global.GAME_NAME[global.CURRENT_GAME],_strScale,1,0);
	
	// Change the font to the smaller font
	draw_set_font(fntSmall);
	
	// Check the width of the game authors and prepare to "squash" it horizontally to make it fit within this column
	var _strScale = 1;
	var _strWidth = string_width("by "+global.GAME_NAME[global.CURRENT_GAME]);
	if (_strWidth>288) {_strScale = 288/_strWidth;}
	
	// Draw the game authors
	draw_text_transformed(848,180,"by "+global.GAME_AUTHORS[global.CURRENT_GAME],_strScale,1,0);
	
	// Set the alignment to left-top
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	// Check how long the review/comment is and cut it off if it's longer than 255 characters
	var _theComment = global.GAME_COMMENT[global.CURRENT_GAME];
	if (string_length(_theComment)>255) {
		_theComment = string_copy(_theComment,1,252)+"...";	
	}
	
	// Draw the review/comment
	draw_text_ext(688,270,"Your Review:\n"+_theComment,-1,320);
	
	// Create the clickable on-screen button for editing reviews
	var checkMe = clicker_check(848,400,80,20);
	if (checkMe>0) {
		
		// Draw the clicker if the mouse is over the top of it
		draw_clicker(848,400,80,20,"Edit Review",C_GREEN_DARK,C_GREEN_OUTLINE);
	
		if (checkMe == 2) {
			// If the clicker is clicked:
			
			// Allow the user to edit their review, and save the data when they're done
			global.GAME_COMMENT[global.CURRENT_GAME] = get_string("Edit Review for "+global.GAME_NAME[global.CURRENT_GAME],global.GAME_COMMENT[global.CURRENT_GAME]);
			save_data();
		}
	} else {
		
		// Draw the clicker if the mouse isn't over the top of it
		draw_clicker(848,400,80,20,"Edit Review",C_BUTTON_DARK,C_BUTTON_DARK_OUTLINE);
		
	}
	
	
	// Create the clickable on-screen buttons for awarding the various "best ofs" (START) ================================================
	// Follows the same structure as the check above for editing the review, if you want to understand how each block of code here works
	
	// Best use of theme
	var checkMe = clicker_check(738,456,50,20);
	if (checkMe>0) {
		
		draw_clicker(738,456,50,20,"Best Theme",C_GREEN_DARK,C_GREEN_OUTLINE);
		
		if (checkMe == 2) {
			if (global.AWARD_THEME == global.CURRENT_GAME) {
				global.AWARD_THEME=-1;
			} else {
				global.AWARD_THEME=global.CURRENT_GAME;
			}
			save_data();
			
		}
	} else {
		
		var _theCol = C_BUTTON_DARK_OUTLINE;
		if (global.AWARD_THEME=global.CURRENT_GAME) {_theCol = c_yellow;}
		draw_clicker(738,456,50,20,"Best Theme",C_BUTTON_DARK,_theCol);
		
	}
	
	// Best concept
	var checkMe = clicker_check(848,456,50,20);
	if (checkMe>0) {
		
		draw_clicker(848,456,50,20,"Best Concept",C_GREEN_DARK,C_GREEN_OUTLINE);
		
		if (checkMe == 2) {
			if (global.AWARD_CONCEPT == global.CURRENT_GAME) {
				global.AWARD_CONCEPT=-1;
			} else {
				global.AWARD_CONCEPT=global.CURRENT_GAME;
			}
			save_data();
		}
		
	} else {
		
		var _theCol = C_BUTTON_DARK_OUTLINE;
		if (global.AWARD_CONCEPT=global.CURRENT_GAME) {_theCol = c_yellow;}
		draw_clicker(848,456,50,20,"Best Concept",C_BUTTON_DARK,_theCol);
		
	}
	
	// Best presentation
	var checkMe = clicker_check(958,456,50,20);
	if (checkMe>0) {
		
		draw_clicker(958,456,50,20,"Best Pres.",C_GREEN_DARK,C_GREEN_OUTLINE);
		if (checkMe == 2) {
			if (global.AWARD_PRESENTATION == global.CURRENT_GAME) {
				global.AWARD_PRESENTATION=-1;
			} else {
				global.AWARD_PRESENTATION=global.CURRENT_GAME;
			}
			save_data();
		}
		
	} else {
		
		var _theCol = C_BUTTON_DARK_OUTLINE;
		if (global.AWARD_PRESENTATION=global.CURRENT_GAME) {_theCol = c_yellow;}
		draw_clicker(958,456,50,20,"Best Pres.",C_BUTTON_DARK,_theCol);
		
	}
	
	// Best story
	var checkMe = clicker_check(793,504,50,20);
	if (checkMe>0) {
		
		draw_clicker(793,504,50,20,"Best Story",C_GREEN_DARK,C_GREEN_OUTLINE);
		if (checkMe == 2) {
			if (global.AWARD_STORY == global.CURRENT_GAME) {
				global.AWARD_STORY=-1;
			} else {
				global.AWARD_STORY=global.CURRENT_GAME;
			}
			save_data();
		}
		
	} else {
		
		var _theCol = C_BUTTON_DARK_OUTLINE;
		if (global.AWARD_STORY=global.CURRENT_GAME) {_theCol = c_yellow;}
		draw_clicker(793,504,50,20,"Best Story",C_BUTTON_DARK,_theCol);
		
	}
	
	// Best devlog
	var checkMe = clicker_check(903,504,50,20);
	if (checkMe>0) {
		
		draw_clicker(903,504,50,20,"Best Devlog",C_GREEN_DARK,C_GREEN_OUTLINE);
		
		if (checkMe == 2) {
			if (global.AWARD_DEVLOG == global.CURRENT_GAME) {
				global.AWARD_DEVLOG=-1;
			} else {
				global.AWARD_DEVLOG=global.CURRENT_GAME;
			}
			save_data();
		}
		
	} else {
		
		var _theCol = C_BUTTON_DARK_OUTLINE;
		if (global.AWARD_DEVLOG=global.CURRENT_GAME) {_theCol = c_yellow;}
		draw_clicker(903,504,50,20,"Best Devlog",C_BUTTON_DARK,_theCol);
		
	}
	
	// Create the clickable on-screen buttons for awarding the various "best ofs" (END) ================================================
	
	// Create the clickable on-screen button for downloading the game
	// If this "lightweight" URL randomiser ever gets turned into the main "Jam Player" this will need to execute the EXE file for each game
	// Instead of pointing to a URL
	var checkMe = clicker_check(848,224,80,20);
	
	if (checkMe>0) {
		
		draw_clicker(848,224,80,20,"Download Game",C_GREEN_DARK,C_GREEN_OUTLINE);
	
		if (checkMe == 2) {
			
			// Open the download link for the game (currently using an extension because url_open is broken in GMS2)
			// Thanks, YellowAfterLife
			execute_shell_simple(global.GAME_DOWNLOAD[global.CURRENT_GAME]);
			// WARNING! Should maybe add a safety check here to ensure this is actually a URL
			// (although since the host compiles the CSV they should know that already)
			
		}
		
	} else {
		
		draw_clicker(848,224,80,20,"Download Game",C_BUTTON_DARK,C_BUTTON_DARK_OUTLINE);
		
	}
	
} else {
	
	// If no game is currently selected, draw a message explaining why this box is empty
	draw_set_color(C_TEXT);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fntSmall);
	draw_text_ext(848,382,"Select a game\nto see more information here.",-1,288);
	
}

// Create the clickable on-screen button for skipping to the next game
var checkMe = clicker_check(848,568,80,20);
if (checkMe>0) {
	
	// Draw the button if the mouse is over the top of it
	draw_clicker(848,568,80,20,"Next Game",C_GREEN_DARK,C_GREEN_OUTLINE);
	
	if (checkMe == 2) {
		// If the button was clicked
		
		// Check if the unplayed list has any games in it
		if (ds_list_size(global.LIST_TOPLAY)>0) {
			
			// Set the currently selected game to the next game on the list
			global.CURRENT_GAME = ds_list_find_value(global.LIST_TOPLAY,0);
			
			// Add the game to the "unranked" list and deleted it from the "unplayed" list
			ds_list_add(global.LIST_TORANK,global.CURRENT_GAME);
			ds_list_delete(global.LIST_TOPLAY,0);
			
			// Set the game to "played"
			global.GAME_PLAYED[global.CURRENT_GAME]=1;
			
			// Save the changes
			save_data();
		}
	}
} else {
	
	// Draw the button if the mouse isn't over the top of it
	draw_clicker(848,568,80,20,"Next Game",C_BUTTON_DARK,C_BUTTON_DARK_OUTLINE);
	
}

// Draw how many games are left unplayed
draw_text(848,612,string(ds_list_size(global.LIST_TOPLAY))+" left");

// Draw the bar at the top of the screen containing the GMC Jam Logo, title of the randomiser and title of each column
// The logo & title are currently hard-coded into the base project but should probably read in a variable from 
// A text file packaged with the player so it can be altered by jam hosts without altering this base GM project
draw_set_color($282828);
draw_rectangle(0,0,1024,124,0);
draw_sprite_ext(sGMCJam40Logo,0,512,8,0.125,0.125,0,c_white,1);
draw_set_font(fntSmall);
draw_set_color(C_GRAY_TEXT);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(512,64,"Lightweight GMC Jam Randomiser");
draw_set_color(C_TEXT);
draw_text(176,100,"Unranked entries");
draw_text(512,100,"Current ranking & awards");
draw_text(848,100,"Selected Game");

// Create the clickable on-screen button for exporting the current votes & reviews to the clipboard
var checkMe = clicker_check(848,32,80,20);
if (checkMe>0) {
	
	// Drawing the button if the mouse is hovering over it
	draw_clicker(848,32,80,20,"Export Votes",C_GREEN_DARK,C_GREEN_OUTLINE);
	
	// If the button was clicked
	if (checkMe == 2) {
		
		// Ask the user if they're sure they want to do this, as it will overwrite clipboard data
		var _choice = show_question("Copy your votes & reviews to the clipboard? This will overwrite anything you have on your clipboard now.");
		if (_choice == true) {
			
			// If the user said "yes", export the clipboard data
			export_clipboard();	
			
		}
		
	}
} else {
	
	// Drawing the button if the mouse isn't hovering over it
	draw_clicker(848,32,80,20,"Export Votes",C_BUTTON_DARK,C_BUTTON_DARK_OUTLINE);
	
}
