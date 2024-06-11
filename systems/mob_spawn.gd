class_name MobSpawn
extends Node2D


@export var creatures: Array[PackedScene]
@export var increase_interval: float = 25

@onready var path = %PathFollow

var mobs_per_minute: float = 60
var cooldown: float = 0
var increase_cooldown: float = 0
var increase_factor: int = 0
var weight_mobs: Array[float] = []

func _process(delta: float) -> void:
  if GameManager.is_game_over: return

  increase_mobs(delta)
  cooldown -= delta

  if cooldown > 0: return

  var interval = 60.0 / mobs_per_minute
  cooldown = interval

  spown_mob()

func spown_mob():
  if creatures.size() == 0: return

  var point = get_point()
  var world = get_world_2d().direct_space_state
  var parameters = PhysicsPointQueryParameters2D.new()
  parameters.position = point
  var result = world.intersect_point(parameters, 1)

  if not result.is_empty(): return

  var index = Util.weight_rand(weight_mobs)
  var creature_scene = creatures[index].instantiate()
  creature_scene.global_position = point
  get_parent().add_child(creature_scene)


func get_point() -> Vector2:
  path.progress_ratio = randf()
  return path.global_position

func increase_mobs(delta):
  increase_cooldown -= delta

  if increase_cooldown > 0: return

  increase_cooldown = increase_interval
  increase_factor += 1
  weight_mobs = []
  for i in creatures.size():
    weight_mobs.push_back(2 * max(0, increase_factor -i))
