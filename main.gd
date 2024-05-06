extends Node2D


@export var game_ui: CanvasLayer
@export var game_over_ui_prefab: PackedScene


func _ready() -> void:
  GameManager.game_over.connect(finish_game)

func finish_game() -> void:
  if game_ui:
    game_ui.queue_free()
    game_ui = null

  var game_over_ui = game_over_ui_prefab.instantiate()

  add_child(game_over_ui)
