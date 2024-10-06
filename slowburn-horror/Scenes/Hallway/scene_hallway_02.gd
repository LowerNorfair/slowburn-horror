extends Node

var dlg_file = "Scene02_hallway02"
var dlg_counter = 0
@onready var button = $Navigator/Button
@onready var hatch = $Layout/Hatch
@onready var bg = $Layout/BG
@onready var bg2 = $Layout/BG2
@onready var hatch_sound = $Creak
@onready var timer = $Timer

func _ready() -> void:
	button.disabled = true
	button.disabled_cursor()
	SignalBus.show_dialogue.emit(dlg_file)
	SignalBus.connect("dialogue_closed", manage_scene)
	
func _process(delta: float) -> void:
	pass

func manage_scene():
	dlg_counter += 1
	if dlg_counter > 1: fade_bg()

func fade_bg():
	var tween = get_tree().create_tween()
	tween.tween_property(bg, "modulate:a", 0, 0.5)
	tween.tween_callback(bg.queue_free)
	tween.connect("finished", play_hatch)
	
func play_hatch():
	hatch_sound.play()
	timer.start()
	timer.connect("timeout", load_bg2)
	
func load_bg2():
	bg2.visible = true
	#fade in new bg
	var tween = get_tree().create_tween()
	tween.tween_property(bg2, "modulate:a", 1, 0.5)
	#enable scene change btn
	button.disabled = false
	button.enabled_cursor()
