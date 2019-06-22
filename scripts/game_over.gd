extends Control

var can_reload = false
var label_high_score
var label_best_score

func _ready():
	set_process_input(true)
	self.label_high_score = tr("GAME_OVER_SCORE")
	self.label_best_score = tr("GAME_OVER_BEST_SCORE")

func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH and can_reload:
		get_tree().reload_current_scene()

func game_over():
	show()
	if State.is_interstitial_loaded():
		State.show_ad()
		can_reload = true
		get_node("retry").show()
	else:
		can_reload = false
		get_node("timer").start()

func _on_Timer_timeout():
	can_reload = true
	get_node("retry").show()