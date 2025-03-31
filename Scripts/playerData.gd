extends Node


# default skin
var selectedSkin = 0
var username = ""

# save skin and name
func save_customization(skin, name):
	# user inputed name
	if (name != ""):
		# input is set to username
		username = name
	# user did not put anything
	else:
		#user set to bob
		username = "Bob"
	# set the kin input value in data
	selectedSkin = skin
	print(selectedSkin)
	print(username)
	
# get data
func get_customization():
	return {"skin": selectedSkin,
			"name": username}	
			
