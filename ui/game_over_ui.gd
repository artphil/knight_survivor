extends CanvasLayer

@export var restart_delay: float = 5.0

var restart_coodown: float

@onready var time_label: Label = %TimeSurvived
@onready var monsters_label: Label = %MonstersDefeated
@onready var level_label: Label = %Level


func _ready():
  time_label.set_text(GameManager.time_elapse_string)
  monsters_label.set_text(str(GameManager.monsters_defeated))
  level_label.set_text(str(GameManager.level))
  restart_coodown = restart_delay

func _process(delta):
  restart_coodown -= delta

  if restart_coodown < 0:
    restart_game()

func restart_game():
  GameManager.reset()
  get_tree().reload_current_scene()