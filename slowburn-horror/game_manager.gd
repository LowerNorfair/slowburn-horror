extends Node

var in_dialogue : bool = false
var scene_fade_playing = false
@onready var menu = SceneManager.get_child(1)
var cursor_default = load("res://UI/Cursors/cursor02.png")

#escape key
func _process(delta):
	if Input.is_action_just_pressed("escape"): open_menu()

func close_menu():
	get_tree().paused = false
	menu.hide()

func open_menu():
	get_tree().paused = true
	menu.show()
