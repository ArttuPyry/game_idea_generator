extends Node2D

var genreTxt = File.new()
var noGenreFileExists = genreTxt.file_exists("user://")

var requirementTxt = File.new()
var noRequirementFileExists = requirementTxt.file_exists("user://")

func _ready():
	if noGenreFileExists:
		get_tree().quit()
	if noRequirementFileExists:
		get_tree().quit()
