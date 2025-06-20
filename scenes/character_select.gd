extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBox.add_text("*", "SYBAU")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if $TextBox.state == 0:
			$TextBox.add_text("*", "SYBAU")
		elif  $TextBox.state == 1:
			pass
		elif  $TextBox.state == 2:
			$TextBox.hide_textbox()
