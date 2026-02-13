class_name HighscoreManager
extends Node

const HIGHSCORE_PATH := "user://highscore.cfg"

var highscore := 0

func saveHighscore(score: int):
	highscore = score
	var file = ConfigFile.new()
	file.set_value("scores", "highscore", highscore)
	file.save(HIGHSCORE_PATH)

func loadHighscore():
	var file = ConfigFile.new()
	var err = file.load(HIGHSCORE_PATH)

	if err != OK:
		highscore = 0
		saveHighscore(highscore)
	else:
		highscore = file.get_value("scores", "highscore", 0)

	highscore = file.get_value("scores", "highscore", 0)
	return highscore
