extends AudioStreamPlayer2D

#heartbeat
@onready var timer = $Timer
var sleeping = 2.0
var resting = 1.0
var racing = 0.5
var loud = 15
var normal = 10
#tinitus 
@onready var tinitus = $tinitus
@onready var timer_tinitus = $tinitus/Timer_tinitus
var tinitus_fade_rate = 0.2
var tinitus_base_vol = -20.0
var silent = -80
var tin_fade_in = false
var tin_fade_out = false
#wind
@onready var wind = $wind

func _ready() -> void:
	play()
	wind.play()
	timer.timeout.connect(_on_loop_sound)
	timer_tinitus.timeout.connect(stop_tinitus)
	set_process(false)

func _on_loop_sound():
	play()

func set_interval(interval):
	timer.wait_time = interval

func set_sleeping():
	timer.wait_time = sleeping
	
func set_resting():
	timer.wait_time = resting
	volume_db = normal

func set_racing():
	timer.wait_time = racing
	volume_db = loud

func play_heartbeat(): 
	timer.start()
	volume_db = normal
	play()
	
func stop_heartbeat():
	timer.stop()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "volume_db", -80, 1)
	await tween.finished
	stop()
	
func play_tinitus():
	tinitus.volume_db = silent
	tinitus.play()
	var tween = get_tree().create_tween()
	tween.tween_property(tinitus, "volume_db", tinitus_base_vol, 2)
	await tween.finished
	timer_tinitus.start()

func stop_tinitus():
	var tween = get_tree().create_tween()
	tween.tween_property(tinitus, "volume_db", silent, 3)

func play_wind(): 
	wind.play()
	wind.volume_db = 5
	
func stop_wind(): 	
	var tween = get_tree().create_tween()
	tween.tween_property(wind, "volume_db", -80, 1)
	await tween.finished
	wind.stop()
