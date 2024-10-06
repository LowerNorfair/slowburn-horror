#interactable_object.gd
#handles scene objects
extends StaticBody2D

#label
@onready var label = $Label
var offset = Vector2(35,-35)
#dialogue stuff
@export var dlg_file = "Placeholder"
var reading = false

#hide the label & stop process on ready
func _ready() -> void:
	label.visible = false
	set_process(false)

func _process(delta: float) -> void:
	#move label with the mouse
	var vec = get_viewport().get_mouse_position()
	label.position = vec + offset
	
	#while hovering, lmb opens text file
	if Input.is_action_just_pressed("LMB") && !reading:
		SignalBus.show_dialogue.emit(dlg_file)
		reading = true
		label.visible = false
		
	#after finished reading, destroy
	if (reading && !GameManager.in_dialogue):
		print("destroy clickey")
		SignalBus.object_destroyed.emit()
		queue_free()

#mouse hover funcs
func _mouse_enter() -> void:
	if GameManager.in_dialogue: return
	set_process(true)
	label.visible = true
	
func _mouse_exit() -> void:
	if GameManager.in_dialogue: return
	set_process(false)
	label.visible = false
