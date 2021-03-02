function is_mouse_here(argument0, argument1, argument2, argument3) {
	
	// A function for checking if the mouse is within a certain rectangle
	if (point_in_rectangle(mouse_x,mouse_y,argument0,argument1,argument2,argument3)) {

		return true;

	} else {

		return false;
	
	}

}
