extends Node

var firebase

func _ready():
	firebase = Globals.get_singleton("FireBase");
	if firebase:
		firebase.initWithFile("res://godot-firebase-config.json", get_instance_ID())
