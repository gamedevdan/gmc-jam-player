function clicker_check(argument0, argument1, argument2, argument3) {
	
	// Checks a clickable button for clicks
	// Returns 0 for no click, no hover
	// Returns 1 if the mouse is hovering on it
	// Returns 2 if it has been clicked this step

	var toReturn = 0;

	if (is_mouse_here(argument0-argument2,argument1-argument3,argument0+argument2,argument1+argument3)) {
	
		if (mouse_check_button_pressed(mb_left)) {

			toReturn = 2;

		} else {
	
			toReturn = 1;
		
		}
	
	}

	return toReturn;


}
