class_name MobSpawn
extends Node2D


@export var creatures: Array[PackedScene]
@export var increase_interval: float = 20

@onready var path = %PathFollow

var mobs_per_minute: float = 60
var cooldown: float = 0
var time: float = 0

func _process(delta: float) -> void:
  if GameManager.is_game_over: return

  time += delta
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

  var max_index = int(time / increase_interval)
  max_index = min(max_index, creatures.size() - 1)

  var index = randi_range(0, max_index)
  var creature_scene = creatures[index].instantiate()
  creature_scene.global_position = point
  get_parent().add_child(creature_scene)


func get_point() -> Vector2:
  path.progress_ratio = randf()
  return path.global_position

