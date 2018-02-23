extends Node

var currentScene

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	
func change_scene(scene):
	call_deferred("_defered_change_scene",scene)

func _defered_change_scene(scene):
	currentScene.free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	get_tree().set_current_scene( currentScene )