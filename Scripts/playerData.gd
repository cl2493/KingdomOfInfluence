extends Node

var selectedSkin = 0

func save_customization(skin):
	selectedSkin = skin
	print(selectedSkin)
	
	
func get_customization():
	
	return {"skin": selectedSkin}	
