class_name Enemy
extends Node2D


const damage_digit_prefab: PackedScene = preload('res://misc/damage_digit.tscn')

@export_category('Life')
@export var health: int = 10
@export var life_time: float = 30
@export var attack_damage: int = 1
@export var death_prefab: PackedScene

@export_category('Drops')
@export var drop_chance: float = 0.1
@export var items_prefab: Array[PackedScene]
@export var items_chance: Array[float]
@export var energy: int = 1


@onready var damage_marker: Marker2D = $Marker
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _process(delta):
	life_time -= delta
	if life_time < 0 and !notifier.is_on_screen():
		queue_free()


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
	GameManager.monsters_defeated += 1

	if death_prefab:
		var death_scene: Node2D = death_prefab.instantiate()
		death_scene.position = position
		get_parent().add_child(death_scene)

		drop_item()

	queue_free()

func drop_item():
	if items_prefab.is_empty(): return
	if randf() > drop_chance: return

	var item_scene: Node2D = get_drop()
	item_scene.position = position
	get_parent().add_child(item_scene)

func get_drop():
	if items_prefab.size() == 1:
		return items_prefab[0].instantiate()

	var weigths: Array[float] = []
	for i in items_prefab.size():
		var item_weigth = items_chance[i] if i < items_chance.size() else 1.0
		weigths.push_back(item_weigth)
	var index = Util.weight_rand(weigths)
	return items_prefab[index].instantiate()
