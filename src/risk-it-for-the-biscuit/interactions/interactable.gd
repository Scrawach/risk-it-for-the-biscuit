class_name Interactable
extends Area3D

@export var height: float = 0.5

var tween: Tween
var base_position: Vector3

func _ready() -> void:
	base_position = position

func hover() -> void:
	if tween != null:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "position:y", base_position.y + height, 0.5).set_trans(Tween.TRANS_CUBIC)

func interact() -> void:
	pass

func has_description() -> bool:
	return true

func get_description() -> String:
	return "hello, world!"

func unhover() -> void:
	if tween != null:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "position:y", base_position.y, 0.5).set_trans(Tween.TRANS_CUBIC)
