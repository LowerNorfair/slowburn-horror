extends Node

#@export_file("*.tscn") var next_scene
@onready var animation_player = $SceneTransitionRect/AnimationPlayer
var next_scene = ""

func _ready() -> void:
	#fade in on scene start
	SignalBus.connect("change_scene", change_scene)
	animation_player.play_backwards("fade_to_black")
	set_process(false)

func _process(delta: float) -> void:
	if(!animation_player.is_playing()):
		get_tree().change_scene_to_file(next_scene)
		animation_player.play_backwards("fade_to_black")
		set_process(false)

func change_scene(scene_name) -> void:
	print(scene_name)
	animation_player.play("fade_to_black")
	set_process(true)
	next_scene = scene_name
