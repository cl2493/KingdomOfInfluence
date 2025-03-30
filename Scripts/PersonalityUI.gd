extends Button

var currentUI
var nextUI

func _ready():
	# get noes of ui
	currentUI = get_tree().current_scene.get_node("Node3D/CanvasLayer/UI/CharacterCustomization")
	nextUI = get_tree().current_scene.get_node("Node3D/CanvasLayer/UI/PersonalityCustomization")
	


func personalityUI():
	currentUI.visible = false
	var player = get_tree().current_scene.get_node("Node3D/Player")
	player.toggleVisibilityChar()
	# next ui is visible
	nextUI.visible = true
