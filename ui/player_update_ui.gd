extends CanvasLayer

@onready var option1 = $Option1
@onready var option2 = $Option2

var options = ['ATTACK', 'SPEED', 'SPECIAL']

func _ready():
  var opt = options[randi() % options.size()]

  option1.text = '+ ' + opt
  if opt == 'ATTACK':
    option1.pressed.connect(improve_attack)
  elif opt == 'SPEED':
    option1.pressed.connect(improve_speed)
  elif opt == 'SPECIAL':
    option1.pressed.connect(improve_special)

  opt = options[randi() % options.size()]

  option2.text = '+ ' + opt
  if opt == 'ATTACK':
    option2.pressed.connect(improve_attack)
  elif opt == 'SPEED':
    option2.pressed.connect(improve_speed)
  elif opt == 'SPECIAL':
    option2.pressed.connect(improve_special)


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