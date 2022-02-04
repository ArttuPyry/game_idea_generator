extends Button

#Arrays
var genre = ["No txt file (Copy genre.txt and requirement.txt to AppData-Roaming-GIG)", ""]
var dimension = ["2D", "2.5D", "3D"]
var requirement = ["No txt file (Copy genre.txt and requirement.txt to AppData-Roaming-GIG)", ""]

#Texts nodes
onready var genre_label = $Genre
onready var dimension_label = $Dimension
onready var requirement_label = $Requirement

#Bools
var multiGenre = false
var multiRequirement = false
var noTwoFiveD = false

var genreTxt = File.new()
var requirementTxt = File.new()

func _ready():
	if genreTxt.file_exists("user://"):
		var genreTxtFile = 'user://genre.txt'
		genre = load_file(genreTxtFile)
	if requirementTxt.file_exists("user://"):
		var requirementTxtFile = 'user://requirement.txt'
		requirementTxt = load_file(requirementTxtFile)
	

#Loads txt files and fills arrays
func load_file(txt):
	var tempArray = []
	var f = File.new()
	f.open(txt, File.READ)
	while !f.eof_reached():
		var line = f.get_line()
		line += " "
		tempArray.append(line)
	f.close()
	return tempArray

func _on_Button_pressed() -> void:
	#Without this it's seeded
	randomize()
	#Suffles all arrays
	genre.shuffle()
	dimension.shuffle()
	requirement.shuffle()
	#Changes texts to first thing in array
	#Genre
	if multiGenre:
		genre_label.text = genre[0] + " + " + genre[1]
	else:
		genre_label.text = genre[0]
	#3D / 2.5D / 2D
	dimension_label.text = dimension[0]
	#Requirments
	if multiRequirement:
		requirement_label.text = requirement[0] + " + " + requirement[1]
	else:
		requirement_label.text = requirement[0]


func _on_Multiple_Genres_toggled(_button_pressed: bool) -> void:
	if !multiGenre:
		multiGenre = true
	else:
		multiGenre = false


func _on_Multiple_Requirments_toggled(_button_pressed: bool) -> void:
	if !multiRequirement:
		multiRequirement = true
	else:
		multiRequirement = false


func _on_No_25D_toggled(_button_pressed: bool) -> void:
	if !noTwoFiveD:
		noTwoFiveD = true
		dimension.erase("2.5D")
	else:
		noTwoFiveD = false
		dimension.append("2.5D")
