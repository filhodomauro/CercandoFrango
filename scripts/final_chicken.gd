extends Area2D

var target
var speed
var limits
var position
var origin
var ecuador
var greenwich
var disable_colision
var hit = false
var is_freezed = false
signal scaped

func _ready():
	limits = Vector2(Globals.get("display/width"),Globals.get("display/height"))
	ecuador = limits.y / 2
	greenwich = limits.x / 2
	set_process(true)

func _on_Chicken_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and not self.disable_colision:
		hit()

func _process(delta):
	if not hit:
		if is_out_of_range():
			emit_signal("scaped")
			queue_free()
		elif not is_freezed:
			position += delta * self.speed * self.target.normalized()
			set_pos(position)

func spawn(position, speed, target, disable_collision, freeze_node):
	self.position = position
	self.origin = position
	self.target = target
	self.speed = speed
	self.disable_colision = disable_collision
	freeze_node.connect("freeze", self, "freeze")
	set_pos(position)

func is_out_of_range():
	var pos = get_pos()
	return pos.x < 0 or pos.y < 0 or pos.x > limits.x or pos.y > limits.y

func hit():
	self.hit = true
	if self.is_freezed:
		unfreeze()
	get_node("hit_sound").play()
	get_node("flyingSprite").hide()
	get_node("hitSprite").show()
	get_node("hitTimer").start()

func revert():
	var position = get_pos()
	var nearest_limit = get_nearest_limit(position)
	if nearest_limit == "TOP" or nearest_limit == "BOTTOM":
		self.target.y *= -1
	else:
		self.target.x *= -1
	self.origin = position

func get_nearest_limit(position):
	var nearest
	if position.y < ecuador:
		if position.x > greenwich:
			nearest = "TOP" if (position.y) < (limits.x - position.x) else "RIGHT"
		else:
			nearest = "TOP" if (position.y) < (position.x) else "LEFT"
	else:
		if position.x > greenwich:
			nearest = "BOTTOM" if (limits.y - position.y) < (limits.x - position.x) else "RIGHT"
		else:
			nearest = "BOTTOM" if (limits.y - position.y) < (position.x) else "LEFT"
	return nearest

func _on_hitTimer_timeout():
	get_node("hitTimer").stop()
	revert()
	get_node("hitSprite").hide()
	get_node("flyingSprite").show()
	self.is_freezed = false
	self.hit = false

func freeze():
	self.is_freezed = true
	get_node("flyingSprite").stop()
	get_node("freezed_sprite").show()
	get_node("freeze_timer").start()

func _on_freeze_timer_timeout():
	unfreeze()

func unfreeze():
	self.is_freezed = false
	get_node("freezed_sprite").hide()
	get_node("flyingSprite").play()
	get_node("freeze_timer").stop()