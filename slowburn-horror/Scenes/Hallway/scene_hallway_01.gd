extends Node

var dlg_file = "Scene02_hallway01"

func _ready() -> void:
	SignalBus.show_dialogue.emit(dlg_file)
