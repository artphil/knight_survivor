extends CanvasLayer

func _process(_delta):
  if Input.is_action_just_pressed("pause"):
    return_game()

func _on_button_pressed():
  return_game()

func return_game():
  get_tree().paused = false
  queue_free()
