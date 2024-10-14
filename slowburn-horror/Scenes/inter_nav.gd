extends StaticBody2D

#direction
enum Dir {NORTH, EAST, SOUTH, WEST}
@export var direction: Dir
#cursors
@export var cursor : CompressedTexture2D = load("res://UI/Cursors/arrow_left.png")

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB"):
		SignalBus.inter_change_scene.emit(direction)
		
#mouse hover funcs
func _mouse_enter() -> void:
	print("enter")
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16,16))
	set_process(true)
	
func _mouse_exit() -> void:
	print("exit")
	Input.set_custom_mouse_cursor(GameManager.cursor_default, Input.CURSOR_ARROW, Vector2(16,16))
	set_process(false)
