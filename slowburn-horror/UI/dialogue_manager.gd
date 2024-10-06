#this can be called with a signal. 
#signal should transmit a string with the file name
extends CanvasLayer

#file stats
var text = []
var t_length = 0
var t_index = 0
var t_loaded = false
#fade stats
var fade_dur = 1.0
var wait = false
#nodes
var dialogue

func _ready() -> void:
	dialogue = $dialogue
	#connect to signal for recieving new dialogue
	SignalBus.connect("show_dialogue", load_dialogue)

func _process(delta: float) -> void:
	if t_loaded && !wait && Input.is_action_just_pressed("LMB"):
		if (t_index < t_length):
			print_line()
		elif t_loaded:
			print_line()
			t_loaded = false
			GameManager.in_dialogue = false
			SignalBus.dialogue_closed.emit()
			dialogue.set_process(false)

func load_dialogue(tf_name):
	var path = "res://Dialogue/" + tf_name + ".txt"
	var file = FileAccess.open(path, FileAccess.READ)
	#clear prev
	t_index = 0
	t_length = 0
	text.clear()
	
	print(path)
	
	if file.is_open():
		while !file.eof_reached():
			text.push_back(file.get_line())
			t_length+=1
			
		t_length -= 1
		file.close()
		
		#print text to scene
		GameManager.in_dialogue = true
		print_line()
		
		t_loaded = true
	else:
		print_debug("File not found: " + path)

func print_line():
	wait = true
	if(t_index!=0):
		fade_out()
		await get_tree().create_timer(fade_dur).timeout
	
	dialogue.text = text[t_index]
	fade_in()
	t_index+=1

func fade_out() -> void:
	var counter = 0
	
	while counter < fade_dur:
		counter += get_process_delta_time()
		dialogue.modulate.a = lerp(1, 0, counter/fade_dur)
		await get_tree().process_frame

func fade_in() -> void:
	var counter = 0
	
	while counter < fade_dur:
		counter += get_process_delta_time()
		dialogue.modulate.a = lerp(0, 1, counter/fade_dur)
		await get_tree().process_frame
		
	wait = false
