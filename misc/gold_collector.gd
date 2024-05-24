extends Node2D

@export var gold_amount: int = 10

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.is_in_group('player'):
		GameManager.gold_counter += 1
		queue_free()
