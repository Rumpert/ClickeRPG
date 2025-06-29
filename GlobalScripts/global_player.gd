extends Node
var Data = {
	"class":null,
	"name":null,
	"origin":null
}
func get_chosen_class()->int:
	return Data["class"]

func get_chosen_name()->int:
	return Data["name"]

func get_chosen_origin()->int:
	return Data["origin"]

func get_data()->Dictionary:
	return Data

func set_chosen_class(Class: int):
	Data["class"] = Class

func set_chosen_name(Name: int):
	Data["name"] = Name

func set_chosen_origin(Origin: int):
	Data["origin"] = Origin

func set_data(pData: Dictionary):
	Data = pData
