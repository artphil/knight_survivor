extends Node

@export var speed: float = 1

var enemy: CharacterBody2D
var sprite: AnimatedSprite2D

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("Sprite")

func _physics_process(_delta):
	var player_position = GameManager.player_position
	var input_vector = (player_position - enemy.position).normalized()
	enemy.velocity = input_vector * speed * 100.0
	enemy.move_and_slide()

	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
