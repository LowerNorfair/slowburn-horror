extends CanvasLayer

var children
var enabled = true

func _ready() -> void:
	children = get_children()
	disable_children()

func _process(delta: float) -> void:
	if GameManager.in_dialogue && enabled:
		disable_children()
		enabled = false
	elif !GameManager.in_dialogue && !enabled:
		enable_children()
		enabled = true

func disable_children():
	print("disabling children")
	for child in children:
		child.disabled = true
		child.disabled_cursor()

func enable_children():
	print("enabling children")
	for child in children:
		child.disabled = false
		child.enabled_cursor()
