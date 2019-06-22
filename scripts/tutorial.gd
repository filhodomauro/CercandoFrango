extends Control

var steps = preload("res://scenes/tutorial_steps.tscn")

func _ready():
	var steps_node = steps.instance()
	add_child(steps_node)
	steps_node.open()
	steps_node.connect("closed", self, "back")


func _on_back_bt_pressed():
	back()

func back():
	get_node("/root/global").change_scene("res://scenes/home.tscn")