extends Node2D

var steps = [
	"Seja bem vindo ao Cercando o Frango. Toque para continuar..."
]
var current_step = 0

func _ready():
	set_process(true)

func _process(delta):
	get_node("message").set_text(steps[current_step])
	
func _on_message_timer_timeout():
	pass # replace with function body
