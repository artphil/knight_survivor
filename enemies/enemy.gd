class_name Enemy
extends Node2D

const damage_digit_prefab: PackedScene = preload('res://misc/damage_digit.tscn')

@export var health: int = 10
@export var attack_damage: int = 1
@export var death_prefab: PackedScene

@onready var damage_marker: Marker2D = $Marker


func damage(amount: int) -> void:
	health -= amount

	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)

	var damage_digit = damage_digit_prefab.instantiate()
	damage_digit.amount = amount
	if damage_marker:
		damage_digit.global_position = damage_marker.global_position
	else:
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)

	if health <= 0:
		die()

func die() -> void:
	if death_prefab:
		var death_scene: Node2D = death_prefab.instantiate()
		death_scene.position = position
		get_parent().add_child(death_scene)

	queue_free()

