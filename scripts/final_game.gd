extends Node2D

const START_POSITION = Vector2(0,0)
const GREEN_COLOR = Color( 0.0732422, 0.75, 0.11554, 1 )
const ALERT_COLOR = Color(0.910156,0.195541,0.195541)
const CRITICAL_LIFE = 1

var chicken = preload("res://scenes/chicken.tscn")
var tutorial_steps = preload("res://scenes/tutorial_steps.tscn")
var steps_node
var score
var lifes
var high_score
var is_on_play
var speed = 100

var config_file = File.new()
var path = "user://cerc_frg.config"
var config

func _ready():
	load_data()
	if self.config["skip_tutorial"]:
		start_game()
	else:
		start_tutorial()

func start_game():
	self.is_on_play = true
	self.score = 0
	self.lifes = 3
	self.high_score = config["high_score"]
	get_node("control/life").set_text(str(self.lifes))
	get_node("control/high_score").set_text(str(self.high_score))
	get_node("control/score").set_text(str(self.score))
	add_chicken()

func start_tutorial():
	steps_node = tutorial_steps.instance()
	add_child(steps_node)
	steps_node.open()
	steps_node.connect("closed",self,"finish_tutorial")

func finish_tutorial():
	self.config["skip_tutorial"] = true
	steps_node.queue_free()
	start_game()

func add_chicken():
	var chicken_node = chicken.instance()
	var target = Vector2(1000,rand_range(100,600))
	chicken_node.spawn(START_POSITION, speed, target, false, get_node("freeze"))
	chicken_node.connect("scaped", self, "chicken_scaped")
	add_child(chicken_node)
	change_score(1)

func _on_ChickenGenerator_timeout():
	if is_on_play:
		randomize()
		add_chicken()

func chicken_scaped():
	if lifes > 0:
		change_score(-1)
		self.lifes -= 1
		get_node("control/life").set_text(str(self.lifes))
		if lifes == 0:
			is_on_play = false
			get_node("gameOver").game_over()
			self.config["high_score"] = high_score
			save_data(self.config)
		elif lifes == CRITICAL_LIFE:
			get_node("control/life").add_color_override("font_color", ALERT_COLOR)


func change_score(point):
	self.score += point
	get_node("control/score").set_text(str(self.score))
	if self.score > self.high_score:
		self.high_score = self.score
		get_node("control/high_score").set_text(str(self.high_score))
		get_node("control/high_score").add_color_override("font_color", GREEN_COLOR)

func load_data():
	if config_file.file_exists(path):
		config_file.open(path, File.READ)
		self.config = config_file.get_var()
		if not "high_score" in self.config:
			self.config["high_score"] = 0
		if not "skip_tutorial" in self.config:
			self.config["skip_tutorial"] = false
		config_file.close()
	else:
		self.config = {
			"high_score" : 0,
			"skip_tutorial" : false
		}
		save_data(self.config)
	print(self.config)

func save_data(config):
	config_file.open(path, File.WRITE)
	config_file.store_var(config)
	config_file.close()
	print(self.config)
