extends Node2D


@export var creatures: Array[PackedScene]
@export var mobs_per_minute: float = 60

@onready var path = %PathFollow

var cooldown: float = 0

func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown > 0: return

	var interval = 60.0 / mobs_per_minute
	cooldown = interval

	spown_mob()

func spown_mob():
	var point = get_point()
	var world = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	var result = world.intersect_point(parameters, 1)

	if not result.is_empty(): return

	var index = randi_range(0, creatures.size() - 1)
	var creature_scene = creatures[index].instantiate()
	creature_scene.global_position = point
	get_parent().add_child(creature_scene)


func get_point() -> Vector2:
	path.progress_ratio = randf()
	return path.global_position

