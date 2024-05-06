extends CanvasLayer


var items = {
  "meat": 0,
  "gold": 0
}

@onready var time_label = %TimeLabel
@onready var gold_label = %GoldLabel
@onready var meat_label = %MeatLabel

var time_elapse: float = 0


func _ready() -> void:
  GameManager.player.item_collected.connect(_on_colect_item)

func _process(delta: float) -> void:
  time_elapse += delta
  time_label.set_text(get_time(time_elapse))
  gold_label.set_text(str(items['gold']))
  meat_label.set_text(str(items['meat']))

func get_time(time_float: float) -> String:
  var time_int: int = floori(time_float)
  var seconds: int = time_int % 60
  var minutes: int = time_int / 60

  return "%02d:%02d" % [minutes, seconds]

func _on_colect_item(item_name: String) -> void:
  items[item_name] += 1
