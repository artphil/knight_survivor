extends CanvasLayer


@onready var time_label = %TimeLabel
@onready var gold_label = %GoldLabel
@onready var meat_label = %MeatLabel
@onready var level_label = %LevelLabel
@onready var experience_bar = %ExpBar


func _process(_delta: float) -> void:
  time_label.set_text(GameManager.time_elapse_string)
  gold_label.set_text(str(GameManager.gold_counter))
  meat_label.set_text(str(GameManager.meat_counter))
  level_label.set_text(str(GameManager.level))
  experience_bar.value = GameManager.experience / GameManager.max_experience
