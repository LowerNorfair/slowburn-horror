extends Node

enum Dir {NORTH, EAST, SOUTH, WEST}

#scene management
var current_scene
var nav_disabled = false
@onready var directions = [$North, $East, $South, $West]
@onready var navs = [$North/Navigation, $East/Navigation, $South/Navigation, $West/Navigation]
var scene01 = "Scene03_attic01"
#object management
var object_count = 0
@onready var claw_marks = $North/obj_claw_marks
@onready var stain = $East/obj_stain
@onready var lump = $East/obj_lump
@onready var reach_in = $East/obj_reach_in
var spawn_north = false
var spawn_east = false

func _ready() -> void:
	SignalBus.connect("inter_change_scene", inter_change_scene)
	SignalBus.connect("object_destroyed", handle_objects)
	SignalBus.show_dialogue.emit(scene01)
	
	current_scene = Dir.NORTH
	for i in range(1,4): directions[i].process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	if GameManager.in_dialogue && !nav_disabled:
		navs[current_scene].process_mode = Node.PROCESS_MODE_DISABLED
		nav_disabled = true
	elif !GameManager.in_dialogue && nav_disabled:
		navs[current_scene].process_mode = Node.PROCESS_MODE_INHERIT
		nav_disabled = false
		
	if(spawn_north && current_scene != Dir.NORTH):
		claw_marks.process_mode = Node.PROCESS_MODE_INHERIT
		claw_marks.visible = true
		spawn_north = false
	if(spawn_east && current_scene != Dir.WEST):
		stain.process_mode = Node.PROCESS_MODE_INHERIT
		stain.visible = true
		spawn_east = false
		

func inter_change_scene(sc_name):
	directions[current_scene].process_mode = Node.PROCESS_MODE_DISABLED
	directions[current_scene].visible = false
	directions[sc_name].process_mode = Node.PROCESS_MODE_INHERIT
	directions[sc_name].visible = true
	current_scene = sc_name

func handle_objects():
	object_count += 1
	print("collecting " + str(object_count))
	
	if object_count == 5:
		print("spawning1")
		spawn_north = true
		spawn_east = true
	
	if object_count == 7: lump.process_mode = Node.PROCESS_MODE_INHERIT
		
	elif object_count == 8: reach_in.process_mode = Node.PROCESS_MODE_INHERIT
