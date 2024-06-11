extends CanvasLayer

@onready var option1 = $Option1
@onready var option2 = $Option2

var options = ['ATTACK', 'SPEED', 'SPECIAL', 'LUCK', 'LIFE']

func _ready():
  var opt1 = options[randi() % options.size()]
  connect_function(option1, opt1)

  var opt2 = options[randi() % options.size()]
  connect_function(option2, opt2)

func connect_function(button: Button, option: String):
  button.text = '+ ' + option
  if option == 'ATTACK':
    button.pressed.connect(improve_attack)
  elif option == 'SPEED':
    button.pressed.connect(improve_speed)
  elif option == 'SPECIAL':
    button.pressed.connect(improve_special)
  elif option == 'LUCK':
    button.pressed.connect(improve_luck)
  elif option == 'LIFE':
    button.pressed.connect(improve_life)


func return_game():
  get_tree().paused = false
  queue_free()


func improve_attack():
  GameManager.player.sword_attack += 1
  return_game()

func improve_speed():
  GameManager.player.speed += 0.5
  return_game()

func improve_special():
  GameManager.player.aura_damage += 1
  return_game()

func improve_luck():
  GameManager.luck += 0.1
  return_game()

func improve_life():
  GameManager.player.max_health += 10
  GameManager.player.health += 10
  return_game()