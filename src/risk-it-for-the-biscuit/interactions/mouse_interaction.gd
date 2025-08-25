class_name MouseInteraction
extends Node

@export var camera: Camera3D
@export var player_hud: PlayerHUD
@export var max_length: float = 15

var previous_interactable: Interactable

func _physics_process(_delta: float) -> void:
	var interactable := get_first_interactable_object()
	change_target_interactable(interactable)

func change_target_interactable(target: Interactable) -> void:
	if previous_interactable == target:
		return
	
	if previous_interactable != null:
		previous_interactable.unhover()
		player_hud.hide_description()
	
	previous_interactable = target
	
	if previous_interactable != null:
		previous_interactable.hover()
		
	if previous_interactable != null and previous_interactable.has_description():
		player_hud.show_description(previous_interactable.get_description())

func get_first_interactable_object() -> Interactable:
	var space_state := camera.get_world_3d().direct_space_state
	var mouse_position := get_viewport().get_mouse_position()
	
	var origin = camera.project_ray_origin(mouse_position)
	var target = origin + camera.project_ray_normal(mouse_position) * max_length
	
	var query = PhysicsRayQueryParameters3D.create(origin, target)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	if result.has("collider") and result["collider"] is Interactable:
		return result["collider"]
	
	return null
