class_name PlayerHUD
extends CanvasLayer

@onready var description_label: Label = %"Description Label"

func show_description(text: String) -> void:
	description_label.text = text

func hide_description() -> void:
	description_label.text = ""
