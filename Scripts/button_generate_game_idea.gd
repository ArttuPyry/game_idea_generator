extends Button

#Arrays
var genre = ["", ""]
var dimension = ["2D", "2.5D", "3D"]
var requirement = ["", ""]

#Texts nodes
onready var genre_label = $Genre
onready var dimension_label = $Dimension
onready var requirement_label = $Requirement

#Bools
var multiGenre = false
var multiRequirement = false
var noTwoFiveD = false

#For checking correctg filers
var genreTxt = File.new()
var requirementTxt = File.new()

#Checks if you have correct files and sets arrays
func _ready():
	if genreTxt.file_exists("user://genre.txt"):
		genre = load_file('user://genre.txt')
	else:
		self.disabled = true
		genre_label.text = "No txt file! Copy genre.txt and requirement.txt to AppData-Roaming-GIG"
		
	if requirementTxt.file_exists("user://requirement.txt"):
		requirement = load_file('user://requirement.txt')
	else:
		self.disabled = true
		requirement_label.text = "No txt file! Copy genre.txt and requirement.txt to AppData-Roaming-GIG"


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

#CheckBox bools
func _on_Multiple_Genres_toggled(_button_pressed: bool) -> void:
	if !multiGenre:
		multiGenre = true
	else:
		multiGenre = false

#CheckBox bools
func _on_Multiple_Requirments_toggled(_button_pressed: bool) -> void:
	if !multiRequirement:
		multiRequirement = true
	else:
		multiRequirement = false

#CheckBox bools
func _on_No_25D_toggled(_button_pressed: bool) -> void:
	if !noTwoFiveD:
		noTwoFiveD = true
		dimension.erase("2.5D")
	else:
		noTwoFiveD = false
		dimension.append("2.5D")
