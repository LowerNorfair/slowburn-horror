extends Button

enum Type {INTERNAL, EXTERNAL}
enum Dir {NORTH, EAST, SOUTH, WEST}

@export var type: Type
@export_file("*.tscn") var scene_name #use for changing scene
@export var inter_name: Dir #use for moving in the same scene
#cursor
@export var cursor : CompressedTexture2D = load("res://UI/Cursors/arrow_left.png")
var c_default = load("res://UI/Cursors/default.png")
var c_hover

func _ready() -> void:
	c_hover = cursor

func _on_pressed() -> void:
	if type == Type.EXTERNAL:
		change_scene()
	else:
		inter_change_scene()

#for moving to a new scene
func change_scene():
	SignalBus.change_scene.emit(scene_name)

#for swapping out the map in current scene
func inter_change_scene():
	SignalBus.inter_change_scene.emit(inter_name)

#mouse hover cursors
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(c_hover)

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(c_default)

#disable cursor 
func disabled_cursor() -> void:
	c_hover = c_default
	
func enabled_cursor() -> void:
	c_hover = cursor
