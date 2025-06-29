extends Control

@onready var text_box = $TextBox
@onready var option_list = $MarginContainer/HBoxContainer
@onready var selection_button := preload("res://scenes/selection_screen_button.tscn")
var selection_stage = 0


func _ready() -> void:
	text_box.add_text("Select thy class")
	text_box.show_text("*")
	display_choices(selection_stage)

func update_and_display_choices():
	selection_stage += 1
	display_choices(selection_stage)

func _clear_option_list():
	for child : SelectionButton in option_list.get_children():
		child.queue_free()

func _process(delta: float) -> void:
	pass
func display_choices(stage: int):
	_clear_option_list()
	match stage:
		0:
			for pickable_class in CharacterTypes.classes:
				var selection_button_added: SelectionButton = selection_button.instantiate()
				selection_button_added.text = pickable_class
				selection_button_added.index = CharacterTypes.classes[pickable_class]
				selection_button_added.selected.connect(func(index):
					GlobalPlayer.set_chosen_class(index)
					_clear_option_list()
					text_box.add_text(str(CharacterTypes.classes.find_key(index)) + " indeed...")
					text_box.add_text("Select thy name")
					text_box.skip_text()
					text_box.show_text("*")
					await text_box.finished
					await get_tree().create_timer(1).timeout
					text_box.show_text("*")
					update_and_display_choices()
				)
				option_list.add_child(selection_button_added)
		1:
			for pickable_name in CharacterTypes.names:
				var selection_button_added: SelectionButton = selection_button.instantiate()
				selection_button_added.text = pickable_name
				selection_button_added.index = CharacterTypes.names[pickable_name]
				selection_button_added.selected.connect(func(index):
					GlobalPlayer.set_chosen_name(index)
					_clear_option_list()
					text_box.add_text(str(CharacterTypes.names.find_key(index)) + " indeed")
					text_box.add_text("Select thy origin")
					text_box.skip_text()
					text_box.show_text("*")
					await text_box.finished
					await get_tree().create_timer(1).timeout
					text_box.show_text("*")
					update_and_display_choices()
				)
				option_list.add_child(selection_button_added)
		2:
			for pickable_origin in CharacterTypes.origins:
				var selection_button_added: SelectionButton = selection_button.instantiate()
				selection_button_added.text = pickable_origin
				selection_button_added.index = CharacterTypes.origins[pickable_origin]
				selection_button_added.selected.connect(func(index):
					GlobalPlayer.set_chosen_origin(index)
					_clear_option_list()
					text_box.add_text(get_text_to_display_for_chosing(GlobalPlayer.get_chosen_class(), GlobalPlayer.get_chosen_name(), GlobalPlayer.get_chosen_origin()))
					text_box.add_text("Now let your journey begin....")
					text_box.skip_text()
					text_box.show_text("*")
					await text_box.finished
					await get_tree().create_timer(3).timeout
					text_box.show_text("*")
					await text_box.finished
					await get_tree().create_timer(1).timeout
					get_tree().quit(-1)
				)
				option_list.add_child(selection_button_added)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		print(GlobalPlayer.get_data())


func get_text_to_display_for_chosing(Class:int, Name:int, Origin:int)->String:
	var stringified_player_choices = str(Class)+str(Name)+str(Origin)
	match stringified_player_choices:
		"031":
			return "Good combination of strength and agility with name that suits you WARRIOR."
		"301", "311", "321", "331":
			return "Don't act so high of yourself, you ain't Mozart..."
		"302", "312", "322", "332":
			return "A lich like you doesn't deserve to have a voice... or does it?"
		"303", "313", "333":
			return "Hypnotizing voice of a siren... Use it wisely"
		"323":
			return "Hypnotizing voice of a siren... Use it at your own risk"
		"300", "310", "320", "330":
			return "An elf, singing or playing? I put my hopes in you " + CharacterTypes.names.find_key(Name)
		"200", "210", "220", "230":
			return "Elf magic, once was the strongest..."
		"201", "221", "231":
			return "You ain't a wizard " + CharacterTypes.names.find_key(Name)
		"211":
			return "You're a wizard " + CharacterTypes.names.find_key(Name)
		"202", "212", "222", "232":
			return "You have high powers... but still shorter than some other " + CharacterTypes.names.find_key(randi_range(0,3)) + "."
		"203", "213", "223", "233":
			return "Aight, so you gonna just use [SPLASH] or smh?"
		"003", "013", "023", "033":
			return "It's a terribe world to live in for sirens like you..."
		"002", "012", "022", "032":
			return "No matter what, even if you're a Melee warrior, there's always someone better."
		"001", "011", "021":
			return "Probably the best choosing for a mere human like you."
		"000", "010", "020", "030":
			return "You should have picked diffrent, now suffer."
		"100", "110", "120", "130":
			return "Good..."
		"101", "111", "121", "131":
			return "Alright, but will u hit any shot?"
		"102", "112", "122", "132":
			return "Still ain't special.."
		"103", "113", "123", "133":
			return "More like a Harp than a Bow."
		_:
			return "Indeed"
