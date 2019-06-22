extends Control

func _on_start_pressed():
	get_node("/root/global").change_scene("res://scenes/game.tscn")

func _on_credits_pressed():
	get_node("/root/global").change_scene("res://scenes/credits.tscn")

func _on_tutorial_pressed():
	get_node("/root/global").change_scene("res://scenes/tutorial.tscn")
