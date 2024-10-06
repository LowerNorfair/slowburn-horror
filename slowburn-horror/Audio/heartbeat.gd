extends AudioStreamPlayer2D

#heartbeat
@onready var timer = $Timer
var sleeping = 2.0
var resting = 1.0
var racing = 0.5
var loud = 10
var normal = 1
#tinitus
@onready var tinitus = $tinitus
@onready var timer_tinitus = $tinitus/Timer_tinitus
var tinitus_fade_rate = 0.2
var tinitus_base_vol = -20.0
var silent = -80
var tin_fade_in = false
var tin_fade_out = false
#static
@onready var _static = $static

func _ready() -> void:
	play()
	timer.timeout.connect(_on_loop_sound)
	timer_tinitus.timeout.connect(stop_tinitus)
	set_process(false)

func _process(delta: float) -> void:	
	if tin_fade_in && tinitus.volume_db < tinitus_base_vol:
		tinitus.volume_db += tinitus_fade_rate/2
	elif tin_fade_in:
		tin_fade_in = false
		timer_tinitus.start()
	
	if tin_fade_out && tinitus.volume_db > silent:
		tinitus.volume_db -= tinitus_fade_rate
	elif tin_fade_out:
		tinitus.stop()
		tin_fade_out = false
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

func play_heartbeat():	play()
	
func play_tinitus():
	tinitus.volume_db = silent
	tinitus.play()
	tin_fade_in = true
	set_process(true)

func stop_tinitus():
	tin_fade_out = true
	set_process(true)

func play_static():	_static.play()
	
func stop_static(): _static.stop()
