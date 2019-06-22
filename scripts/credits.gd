extends Control

func _on_voltar_pressed():
	get_node("/root/global").change_scene("res://scenes/home.tscn")
