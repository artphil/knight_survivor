class_name Enemy
extends Node2D

@export var health: float = 10
@export var attack_damage: float = 1
@export var death_prefab: PackedScene


func damage(amount: float) -> void:
	health -= amount
	print("health: ", health)

	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)

	if health <= 0:
		die()

func die() -> void:
	if death_prefab:
		var death_scene: Node2D = death_prefab.instantiate()
		death_scene.position = position
		get_parent().add_child(death_scene)

	queue_free()

