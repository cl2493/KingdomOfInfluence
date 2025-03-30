extends Button

var currentUI
var nextUI


	

func kingdomUI():
	var result = get_tree().change_scene_to_file("res://Scenes/KingdomSpawn.tscn")
	if result != OK:
		print("Error changing scene: " + str(result))
	else:
		print("Scene change successful")
