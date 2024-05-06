extends Node2D

@export var regeneration_amount: int = 10
@export var item_name: String = ''

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.is_in_group('player'):
		var player: Player = body
		player.heal(regeneration_amount)
		player.item_collected.emit(item_name)
		queue_free()
