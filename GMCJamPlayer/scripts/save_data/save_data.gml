function save_data() {
	
	// Cycle through the data for each game and make sure it "knows" its place in the leaderboard
	for (var i=0;i<global.GAME_MAX;i++) {
	
		if (global.LEADERBOARD[i]>-1) {
			
			global.GAME_RANK[global.LEADERBOARD[i]] = i;
			
		}
	
	}

	// open the ini file
	ini_open("personal_jam_data.ini");

	// write the data for whether the user has played the game, the rank they gave it, the score and the comment
	for (var i=0;i<global.GAME_MAX;i++) {

		ini_write_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"PLAYED",global.GAME_PLAYED[i]);
		ini_write_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"RANK",global.GAME_RANK[i]);
		ini_write_real(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"SCORE",global.GAME_SCORE[i]);
		ini_write_string(global.GAME_AUTHORS[i],global.GAME_NAME[i]+"COMMENT",global.GAME_COMMENT[i]);
	
	}

	// write the data for the "best of" categories
	ini_write_real("bestofs","theme",global.AWARD_THEME);
	ini_write_real("bestofs","concept",global.AWARD_CONCEPT);
	ini_write_real("bestofs","presentation",global.AWARD_PRESENTATION);
	ini_write_real("bestofs","story",global.AWARD_STORY);
	ini_write_real("bestofs","devlog",global.AWARD_DEVLOG);

	// close the ini file
	ini_close();

}
