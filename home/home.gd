extends Node2D

@export var credits_prefab: PackedScene


func _on_start_button_pressed():
	GameManager.go_game()


func _on_credit_button_pressed():
	var credit_scene = credits_prefab.instantiate()
	add_child(credit_scene)
