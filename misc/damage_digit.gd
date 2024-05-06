extends Node2D

@export var amount: int

func _ready():
  %Label.text = str(amount)
