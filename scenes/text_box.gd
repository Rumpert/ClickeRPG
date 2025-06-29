extends CanvasLayer

signal dialogue_finished

@onready var textbox_container := $MarginContainer
@onready var start_symbol := $MarginContainer/MarginContainer/HBoxContainer/Start
@onready var label := $MarginContainer/MarginContainer/HBoxContainer/text
signal finished
var text_library = []
var state = 0
var current_tween: Tween = null

func _ready() -> void:
	hide_textbox()

func _process(delta: float) -> void:
	pass

func hide_textbox():
	start_symbol.text = ""
	label.text = ""
	label.visible_ratio = 0
	textbox_container.hide()
	state = 0

func add_text(text: String):
	text_library.append(text)

func show_text(start: String = ">"):
	if not text_library.is_empty() and (state == 0 or state == 2):
		state = 1
		label.visible_ratio = 0
		var current_text = text_library.front()
		label.text = current_text
		start_symbol.text = start
		textbox_container.show()
		
		current_tween = get_tree().create_tween()
		var duration = current_text.length() * 0.06
		current_tween.tween_property(label, "visible_ratio", 1, duration).finished.connect(func():
			state = 2
			text_library.erase(current_text)
			finished.emit()
			current_tween = null
		)
	elif text_library.is_empty():
		hide_textbox()
		emit_signal("dialogue_finished")
	elif state == 1:
		skip_text()

func update_state():
	match state:
		0:
			hide_textbox()
		1:
			pass
		2:
			label.visible_ratio = 1
			textbox_container.show()

func skip_text():
	if state == 1:
		if current_tween:
			current_tween.kill()
			current_tween = null
		label.visible_ratio = 1
		state = 2
		text_library.erase(text_library.front())
		finished.emit()
		update_state()

func continue_text():
	if state == 2:
		show_text(start_symbol.text)
