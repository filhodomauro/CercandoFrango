extends Area2D

var is_freeze_active = true
var countdown_label
var freeze_countdown

signal freeze

func _ready():
	countdown_label = get_node("countdown")
	freeze_countdown = get_node("freeze_cooldown")
	set_process(true)

func _process(delta):
	if not is_freeze_active:
		countdown_label.set_text(str(int(freeze_countdown.get_time_left())))

func _on_area_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and is_freeze_active:
		emit_signal("freeze")
		is_freeze_active = false
		get_node("freeze_cooldown").start()

func _on_freeze_cooldown_timeout():
	countdown_label.set_text("")
	is_freeze_active = true
	get_node("freeze_cooldown").stop()