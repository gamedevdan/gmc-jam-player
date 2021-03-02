function export_clipboard() {
	
	// Export the data (votes, reviews, etc.) from the jam player to the clipboard in a post-friendly format for the GMC
	
	// Initiate the string to return
	_clipboardString = "";
	
	// Post title
	_clipboardString += "[center][b][size=7]My Votes & Reviews[/size][/b][/center]\n\n";

	// Top 3 entries
	if (global.LEADERBOARD[0]>-1) {
		_clipboardString += "\n[size=5]1st. [b]"+global.GAME_NAME[global.LEADERBOARD[0]]+"[/b] by "+global.GAME_AUTHORS[global.LEADERBOARD[0]]+"[/size]\n\n";
		_clipboardString += global.GAME_COMMENT[global.LEADERBOARD[0]]+"\n";
	}

	if (global.LEADERBOARD[1]>-1) {
		_clipboardString += "\n[size=5]2nd. [b]"+global.GAME_NAME[global.LEADERBOARD[1]]+"[/b] by "+global.GAME_AUTHORS[global.LEADERBOARD[1]]+"[/size]\n\n";
		_clipboardString += global.GAME_COMMENT[global.LEADERBOARD[1]]+"\n";
	}

	if (global.LEADERBOARD[2]>-1) {
		_clipboardString += "\n[size=5]3rd. [b]"+global.GAME_NAME[global.LEADERBOARD[2]]+"[/b] by "+global.GAME_AUTHORS[global.LEADERBOARD[2]]+"[/size]\n\n";
		_clipboardString += global.GAME_COMMENT[global.LEADERBOARD[2]]+"\n";
	}

	// Best ofs title
	_clipboardString += "\n[size=6]Best ofs:[/size]\n\n";


	// Best ofs (check if each one has been set first)
	if (global.AWARD_THEME>-1) {
		_clipboardString += "[b]Best use of Theme:[/b] "+global.GAME_NAME[global.AWARD_THEME]+" by "+global.GAME_AUTHORS[global.AWARD_THEME]+"[/size]\n";
	}

	if (global.AWARD_CONCEPT>-1) {
		_clipboardString += "[b]Best Concept:[/b] "+global.GAME_NAME[global.AWARD_CONCEPT]+" by "+global.GAME_AUTHORS[global.AWARD_CONCEPT]+"[/size]\n";
	}

	if (global.AWARD_PRESENTATION>-1) {
		_clipboardString += "[b]Best Presentation:[/b] "+global.GAME_NAME[global.AWARD_PRESENTATION]+" by "+global.GAME_AUTHORS[global.AWARD_PRESENTATION]+"[/size]\n";
	}

	if (global.AWARD_STORY>-1) {
		_clipboardString += "[b]Best Story:[/b] "+global.GAME_NAME[global.AWARD_STORY]+" by "+global.GAME_AUTHORS[global.AWARD_STORY]+"[/size]\n";
	}

	if (global.AWARD_DEVLOG>-1) {
		_clipboardString += "[b]Best Devlog:[/b] "+global.GAME_NAME[global.AWARD_DEVLOG]+" by "+global.GAME_AUTHORS[global.AWARD_DEVLOG]+"[/size]\n";
	}

	// Full ranking title & open spoiler/ordered list tags
	_clipboardString += "\n\n[size=6]Full ranking:[/size]\n\n[spoiler][list=1]";

	// Loop through the leaderboard adding the available games one by one
	for (var h=0;h<global.GAME_MAX;h++) {

		if (global.LEADERBOARD[h]>-1) {
	
			_clipboardString += "[*]"+global.GAME_NAME[global.LEADERBOARD[h]]+" by "+global.GAME_AUTHORS[global.LEADERBOARD[h]]+"\n";
	
		} else {
	
			break;
		
		}

	}

	// Close the leaderboard ordered list/spoiler tags
	_clipboardString += "[/list][/spoiler]";

	// Title for the reviews section and open spoiler tag
	_clipboardString += "\n\n[size=6]Reviews:[/size]\n\n[spoiler]";

	// Loop through the games adding the reviews for all games that have one
	for (var h=0;h<global.GAME_MAX;h++) {

		if (global.GAME_COMMENT[h] != "") {
			_clipboardString += "[b]"+global.GAME_NAME[h]+" by "+global.GAME_AUTHORS[h]+"[/b]\n\n";
			_clipboardString += global.GAME_COMMENT[h]+"\n\n";
		}

	}

	// Close the spoiler tag
	_clipboardString += "[/spoiler]";

	// Copy the text to the clipboard
	clipboard_set_text(_clipboardString);

}
