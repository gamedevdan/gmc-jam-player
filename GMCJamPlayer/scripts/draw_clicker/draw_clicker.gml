function draw_clicker(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	// Draws a clickable button to the screen
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fntSmall);
	draw_set_color(argument5);
	draw_roundrect(argument0-argument2,argument1-argument3,argument0+argument2,argument1+argument3,0);
	draw_set_color(argument6);
	draw_roundrect(argument0-argument2,argument1-argument3,argument0+argument2,argument1+argument3,1);
	draw_set_color(C_TEXT);
	draw_text(argument0+1,argument1+1,argument4);

}
