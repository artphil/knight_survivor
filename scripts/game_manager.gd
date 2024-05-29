extends Node

signal game_over

var main: Node2D

var player_position: Vector2
var player: Player
var is_game_over: bool = false
var time_elapse: float = 0
var time_elapse_string: String
var meat_counter: int = 0
var gold_counter: int = 0
var monsters_defeated: int = 0
var total_defeated = {
  'goblin': 0,
  'pawn': 0,
  'sheep': 0
}

func _process(delta):
  if is_game_over: return

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

  for commection in game_over.get_connections():
    game_over.disconnect(commection.callable)

func go_game():
  main.change_scene(main.GAME)
