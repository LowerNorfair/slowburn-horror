extends Node

var scene01 = "Scene04_mass"
var dialogue_counter = 0
@onready var hud = $HUD
@onready var bg = $CanvasLayer/IckyThump
@onready var squish = $squish
@onready var thrash = $thrash

func _ready() -> void:	
	SignalBus.show_dialogue.emit(scene01)
	SignalBus.connect("object_destroyed", finish_him)
	SignalBus.connect("dialogue_closed", inc_counter)
	SignalBus.connect("show_dialogue", play_thrash) #play sound when "struggle" clicked

func _process(delta: float) -> void:
	#text file 1; close eyes on 2nd line, open on 6th
	if GameManager.in_dialogue && dialogue_counter < 1:
		if hud.t_index == 1: squish.play()
		elif hud.t_index == 3: fade_bg_out()
		elif hud.t_index == 5: Heartbeat.set_racing()
		elif hud.t_index == 6: fade_bg_in()
		
	#text file 2; close eyes on 3rd line
	elif GameManager.in_dialogue && dialogue_counter > 0:
		if hud.t_index == 3 : fade_bg_out() 
		elif hud.t_index == 4 : Heartbeat.set_resting()

func inc_counter(): dialogue_counter += 1

func play_thrash(argue): thrash.play()

func fade_bg_out():
	if bg.modulate.a < 1: return
	var tween = get_tree().create_tween()
	tween.tween_property(bg, "modulate:a", 0, 0.5)
	
func fade_bg_in():
	if bg.modulate.a > 0: return
	var tween = get_tree().create_tween()
	tween.tween_property(bg, "modulate:a", 1, 0.5)

func finish_him():
	Heartbeat.stop()
	print("done")
	$HUD/Timer.start()
	$HUD/Timer.connect("timeout", spawn_end_btn)

func spawn_end_btn():
	var endbtn = $HUD/End
	endbtn.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(endbtn, "modulate:a", 1, 2)
	endbtn.disabled = false

func _on_end_pressed():
	get_tree().quit()
