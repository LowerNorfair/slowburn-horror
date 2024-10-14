extends Button

func _ready() -> void:
	Heartbeat.play_wind()

func _on_pressed():
	print("clickly")
	
	Heartbeat.play_tinitus()
	
