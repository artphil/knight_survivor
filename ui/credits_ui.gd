extends Node2D

var credit_path = 'res://data/credits.txt'

@onready var credit_label = %CreditLabel

func _ready():
  var file = FileAccess.open(credit_path, FileAccess.READ)
  if file.is_open():
    credit_label.text = file.get_as_text()
    file.close()

func _on_button_pressed():
  queue_free()
