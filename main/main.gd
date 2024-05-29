extends Node2D

enum {HOME, GAME, SETTINGS}

@export var scenes: Array[PackedScene]

var active_scene = HOME
var last_scene = HOME
var render_scene

func _ready():
  GameManager.main = self
  change_scene(HOME)
  print(scenes, ' ', typeof(scenes), ' ', TYPE_DICTIONARY)


func _process(_delta):
  # if Ctrl.not_save():
    # Ctrl.save_data()
  pass

func change_scene(scene):
  if render_scene:
    render_scene.queue_free()

  last_scene = active_scene
  active_scene = scene

  render_scene = scenes[active_scene].instantiate()
  add_child(render_scene)

func back_scene():
  var scene = last_scene
  change_scene(scene)
