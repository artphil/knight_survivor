extends Node2D


@export var game_ui: CanvasLayer
@export var game_over_ui_prefab: PackedScene
@export var game_paused_ui_prefab: PackedScene


func _ready() -> void:
  GameManager.game_over.connect(finish_game)
  GameManager.player_update.connect(update_player)

func update_player():
  get_tree().paused = true
  var game_paused_ui = game_paused_ui_prefab.instantiate()
  add_child(game_paused_ui)

func finish_game() -> void:
  if game_ui:
    game_ui.queue_free()
    game_ui = null

  var game_over_ui = game_over_ui_prefab.instantiate()

  add_child(game_over_ui)

