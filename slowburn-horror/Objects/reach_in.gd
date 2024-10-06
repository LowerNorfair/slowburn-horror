extends StaticBody2D

@onready var label = $Label
var offset = Vector2(35,-35)
@export_file("*.tscn") var scene

func _ready() -> void:
	label.visible = false
	set_process(false)

func _process(delta: float) -> void:
	var vec = get_viewport().get_mouse_position()
	label.position = vec + offset
	
	if Input.is_action_just_pressed("LMB"):
		SignalBus.change_scene.emit(scene)

func _mouse_enter() -> void:
	label.visible = true
	set_process(true)

func _mouse_exit() -> void:
	label.visible = false
	set_process(false)
