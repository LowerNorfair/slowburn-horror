extends Button

@export_file("*.tscn") var scene_name #use for changing scene
#cursor
@export var cursor : CompressedTexture2D = load("res://UI/Cursors/arrow_left.png")
var c_hover

func _ready() -> void:
	c_hover = cursor

func _on_pressed() -> void:
	change_scene()

#move to a new scene
func change_scene():
	SignalBus.change_scene.emit(scene_name)

#mouse hover cursors
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(c_hover, Input.CURSOR_ARROW, Vector2(16,16))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(GameManager.cursor_default, Input.CURSOR_ARROW, Vector2(16,16))

#disable cursor 
func disabled_cursor() -> void:
	c_hover = GameManager.cursor_default
	
func enabled_cursor() -> void:
	c_hover = cursor
