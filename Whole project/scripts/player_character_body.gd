extends CharacterBody2D
var speed  : float = 150


@export var gravity : float = 980.0

@export var jump_force : float  = -400
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	var direction : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	velocity.x = direction.normalized().x * speed
	
	# Flip sprite
	if direction.x < 0:
		animated_sprite_2d.flip_h = true
	elif direction.x > 0:
		animated_sprite_2d.flip_h = false

	# Animation logic
	if !is_on_floor():
		animated_sprite_2d.play("jump")
	elif direction != Vector2.ZERO:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	

func die () -> void:
	print("Player Died")
	get_tree().reload_current_scene()
