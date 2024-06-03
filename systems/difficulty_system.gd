extends Node2D


@export var mob_spawn: MobSpawn
@export var spawn_rate_base: float = 60
@export var spawn_rate_per_minute: float = 30.0
@export var wave_duration: float = 20.0
@export var break_intensity: float = 0.4

var time: float = 0.0

func _process(delta):
  if GameManager.is_game_over: return

  time += delta

  var spawn_rate = spawn_rate_base + spawn_rate_per_minute * (time / 60.0)

  var wave_sin = sin(TAU * (time / wave_duration))
  var wave_factor = remap(wave_sin, -1.0, 1.0, break_intensity, 1.0)

  mob_spawn.mobs_per_minute = spawn_rate * wave_factor
