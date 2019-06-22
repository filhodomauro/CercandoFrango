extends Control

signal closed
var messages = [
"Voce tem a missao de cuidar do galinheiro, nao deixe os frangos sairem!",
"Quando um frango estiver saindo, toque nele para mudar a direcao",
"Se ele estiver perto do teto, vai comecar a descer, se estiver perto de uma lateral, vai pra outra lateral",
"Se a coisa ficar feia, voce tem um gelinho pra dar uma congelada nos frangos e ir tocando com calma :)",
"Simples assim, espero que tenha um bom jogo ;)"
]
var step
var last_step

func _ready():
	step = 0
	last_step = messages.size()-1
	set_process(true)

func _process(delta):
	if(is_last_step()):
		get_node("next_bt/next_lbl").set_text("FINALIZAR")
	else:
		get_node("next_bt/next_lbl").set_text("PROXIMO")
	get_node("content_lbl").set_text(messages[step])

func open():
	show()

func _on_close_btn_pressed():
	finish()

func _on_next_bt_pressed():
	if(is_last_step()):
		finish()
	else:
		step = step + 1

func finish():
	emit_signal("closed")

func is_last_step():
	return step == last_step