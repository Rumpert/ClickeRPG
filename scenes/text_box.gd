extends CanvasLayer

@onready var textbox_container := $MarginContainer
@onready var start_symbol := $MarginContainer/MarginContainer/HBoxContainer/Start
@onready var label := $MarginContainer/MarginContainer/HBoxContainer/text
var state = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	add_text("*", "TEXT")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hide_textbox():
	start_symbol.text = ""
	label.text = ""
	label.visible_ratio = 0
	textbox_container.hide()
	state = 0

func add_text(start : String, text : String):
	state = 1
	label.visible_ratio = 0
	label.text = text
	start_symbol.text = start
	textbox_container.show()
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1, label.text.length()* 0.06).finished.connect(func():
		state = 2)
