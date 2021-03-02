function load_data(){

	// Open the ini file
	ini_open("personal_jam_data.ini");

	// Clear / Set up the "leaderboard"
	for (var i=0;i<global.GAME_MAX;i++) {

		global.LEADERBOARD[i] = -1;
	
	}

	// Loop through the games loading their authors, names, download links and devlog links from the csv file
	// Also loop through the ini file looking for games with the same name and author and load in their "played" value, rank, score and comment
	for (var i=0;i<global.GAME_MAX;i++) {

		global.GAME_AUTHORS[i] = ds_grid_get(global.JAM_DATABASE,1,i);
		global.GAME_NAME[i] = ds_grid_get(global.JAM_DATABASE,0,i);
		global.GAME_DOWNLOAD[i] = ds_grid_get(global.JAM_DATABASE,2,i);
		global.GAME_DEVLOG[i] = ds_grid_get(global.JAM_DATABASE,3,i);
		global.GAME_PLAYED[i] = ini_read_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"PLAYED",0);
		global.GAME_RANK[i] = ini_read_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"RANK",-1);
		global.GAME_SCORE[i] = ini_read_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"SCORE",-1);
		global.GAME_COMMENT[i] = ini_read_string(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"COMMENT","");
	
		if (global.GAME_RANK[i]>-1) {
		
			global.LEADERBOARD[global.GAME_RANK[i]] = i;
		
		}
	
	}

	// Load the best ofs
	global.AWARD_THEME = ini_read_real("bestofs","theme",-1);
	global.AWARD_CONCEPT = ini_read_real("bestofs","concept",-1);
	global.AWARD_PRESENTATION = ini_read_real("bestofs","presentation",-1);
	global.AWARD_STORY = ini_read_real("bestofs","story",-1);
	global.AWARD_DEVLOG = ini_read_real("bestofs","devlog",-1);

	// close the ini file
	ini_close();

}