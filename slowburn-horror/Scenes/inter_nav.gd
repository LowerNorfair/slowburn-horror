extends StaticBody2D

#direction
enum Dir {NORTH, EAST, SOUTH, WEST}
@export var direction: Dir
#cursors
@export var cursor : CompressedTexture2D = load("res://UI/Cursors/arrow_left.png")
var c_default = load("res://UI/Cursors/default.png")

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB"):
		SignalBus.inter_change_scene.emit(direction)
		
#mouse hover funcs
func _mouse_enter() -> void:
	Input.set_custom_mouse_cursor(cursor)
	set_process(true)
	
func _mouse_exit() -> void:
	Input.set_custom_mouse_cursor(c_default)
	set_process(false)
