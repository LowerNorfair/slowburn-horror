extends CanvasLayer

@onready var volume_slider = $container/volume_slider
@export var audio_bus := AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus))

#volume slider
func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus, linear_to_db(volume_slider.value))

#exit button
func _on_button_pressed() -> void:
	get_tree().quit()

func _on_return_pressed() -> void:
	GameManager.close_menu()

#for web builds
func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.scn")
	GameManager.close_menu()
