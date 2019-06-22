extends Node

var firebase
var interstitial_loaded

func _ready():
	firebase = Globals.get_singleton("FireBase");
	if firebase:
		firebase.initWithFile("res://godot-firebase-config.json", get_instance_ID())

func show_ad():
	firebase.show_interstitial_ad()
	interstitial_loaded = false

func _receive_message(tag, from, key, data):
	print("tag:" + tag + " - from:" + from + " - key:" + key + " - data:" + data)
	if tag == "FireBase":
		if from == "AdMob":
			if key == "AdMob_Interstitial":
				if data == "loaded":
					interstitial_loaded = true

func is_interstitial_loaded():
	return interstitial_loaded