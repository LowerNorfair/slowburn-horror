extends Node

var counter = 0
var started = false
var pulsing = false
var bg
signal start_dialogue

func _ready() -> void:
	bg = $Layout/BG
	bg.modulate.a = 0
	
	#disable navigation initally
	GameManager.in_dialogue = true
	return

func _process(delta):
	if Input.is_action_just_pressed("LMB") && !pulsing && !started:
		pulsing = true
		counter+=1
		pulse_bg()
		
	if(started && !GameManager.in_dialogue):
		#end this
		set_process(false)

func pulse_bg() -> void:
	var max_opacity = 0.2
	var duration = 0.5
	var c = 0
	
	if counter == 1: 
		Heartbeat.play_heartbeat()
	elif counter == 2: 
		Heartbeat.play_heartbeat()
		max_opacity = 0.5
	elif counter == 3:
		Heartbeat.play_tinitus()
		Heartbeat.play_heartbeat()
		max_opacity = 1
		duration = 2.0
	
	while c < duration:
		c += get_process_delta_time()
		bg.modulate.a = lerp(0, 1, c/duration) * max_opacity
		await get_tree().process_frame
	
	c = 0
		
	if counter != 3:
		while c < duration:
			c += get_process_delta_time()
			
			bg.modulate.a = lerp(1, 0, c/duration) * max_opacity
			await get_tree().process_frame
	else:
		Heartbeat.play_static()
		Heartbeat.set_resting()
		start_dialogue.emit()
		started = true
	
	pulsing = false
