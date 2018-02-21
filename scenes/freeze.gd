extends Area2D

signal freeze

func _on_area_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		emit_signal("freeze")
