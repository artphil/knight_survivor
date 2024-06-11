extends Node

signal game_over
signal player_update

var main: Node2D

var player_position: Vector2
var player: Player
var is_game_over: bool = false
var time_elapse: float = 0
var time_elapse_string: String
var meat_counter: int = 0
var gold_counter: int = 0
var monsters_defeated: int = 0
var experience: float = 0.0
var max_experience: float
var level: int = 1
var luck: float = 1.0

func _process(delta):
  if is_game_over: return

  max_experience = 6 + 2 * (2 ** level)
  if experience >= max_experience:
    level += 1
    player.sword_attack += 1
    experience = 0
    player_update.emit()

  time_elapse += delta
  time_elapse_string = Util.get_time(time_elapse)

func end_game() -> void:
  if is_game_over: return
  is_game_over = true
  game_over.emit()
  player_position *= -100

func reset() -> void:
  player_position = Vector2.ZERO
  player = null
  is_game_over = false
  time_elapse = 0
  time_elapse_string = ""
  meat_counter = 0
  gold_counter = 0
  monsters_defeated = 0
  experience = 0.0
  level = 1
  luck = 1.0

  for commection in game_over.get_connections():
    game_over.disconnect(commection.callable)

  for commection in player_update.get_connections():
    player_update.disconnect(commection.callable)

func go_game():
  main.change_scene(main.GAME)
