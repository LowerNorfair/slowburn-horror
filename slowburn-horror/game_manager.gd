extends Node

var circle_cursor = load("res://UI/Cursors/default.png")
var in_dialogue : bool = false
var scene_fade_playing = false

func _ready():
	Input.set_custom_mouse_cursor(circle_cursor)

#escape key
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
