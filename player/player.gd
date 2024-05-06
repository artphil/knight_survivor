class_name Player
extends CharacterBody2D

signal item_collected(item_name: String)

@export_category('Movement')
@export var speed: float = 3

@export_category('Sword')
@export var sword_attack: int = 2

@export_category('Aura')
@export var aura_damage: int = 2
@export var aura_interval: float = 30
@export var aura_prefab: PackedScene

@export_category('Life')
@export var health: int = 100
@export var max_health: int = 100
@export var hit_frequency: float = 0.5
@export var death_prefab: PackedScene

var input_vector: Vector2 = Vector2()
var attack_cooldown: float = 0
var aura_cooldown: float = 0
var hit_cooldown: float = 0
var is_attacking: bool = false
var is_running: bool = false
var was_running: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sword_area: Area2D = $SwordArea
@onready var hitbox_area: Area2D = $HitboxArea
@onready var health_progress: ProgressBar = $HealthProgress


func _ready() -> void:
	GameManager.player = self

func _process(delta) -> void:
	GameManager.player_position = position

	process_countdown(delta)

	process_animation()

	if not is_attacking:
		process_direction()

	if Input.is_action_just_pressed("attack"):
		attack()

	hit_detect(delta)

	aura()

	health_progress.max_value = max_health
	health_progress.value = health

func _physics_process(_delta: float) -> void:
	process_input()
	move_and_slide()


func process_input() -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if abs(input_vector.x) < 0.015:
		input_vector.x = 0
	if abs(input_vector.y) < 0.015:
		input_vector.y = 0

	var target_velocity = input_vector * speed * 100.0
	if is_attacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.2)

func process_animation() -> void:
	was_running = is_running
	is_running = not input_vector.is_zero_approx()

	if not is_attacking:
		if is_running != was_running:
			if is_running:
				animation.play("run")
			else:
				animation.play("idle")

func process_direction():
	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true

func process_countdown(delta: float) -> void:
	if is_attacking:
		attack_cooldown -= delta
		if attack_cooldown <= 0:
			is_attacking = false
			is_running = false
			animation.play("idle")

	aura_cooldown -= delta

func attack() -> void:
	if is_attacking:
		return

	animation.play("attack_side_%d" % randi_range(1, 2))

	is_attacking = true
	attack_cooldown = 0.6

func apply_damage_to_enemies() -> void:
	var enemies = sword_area.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group('enemy'):
			var enemy: Enemy = body
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			if sprite.flip_h:
				attack_direction = Vector2.LEFT
			else:
				attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			if dot_product > 0.3:
				enemy.damage(sword_attack)

func hit_detect(delta: float) -> void:
	hit_cooldown -= delta
	if hit_cooldown > 0: return

	hit_cooldown = hit_frequency

	var enemies = hitbox_area.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group('enemy'):
			var enemy: Enemy = body

			damage(enemy.attack_damage)

func damage(amount: int) -> void:
	health -= amount

	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)

	if health <= 0:
		die()

func die() -> void:
	if death_prefab:
		var death_scene: Node2D = death_prefab.instantiate()
		death_scene.position = position
		get_parent().add_child(death_scene)

	queue_free()

func heal(amount: int):
	health += amount
	health = min(health, max_health)
	print("Player health: %d / %d" % [health, max_health])

func aura():
	if aura_cooldown > 0: return

	aura_cooldown = aura_interval

	var aura_scene = aura_prefab.instantiate()
	aura_scene.damage_amount = aura_damage
	add_child(aura_scene)
