extends Control

var can_reload = false

func _ready():
	set_process_input(true)
	
func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH and can_reload:
		get_tree().reload_current_scene()

func game_over():
	show()
	get_node("timer").start()

func _on_Timer_timeout():
	can_reload = true
	get_node("retry").show()
