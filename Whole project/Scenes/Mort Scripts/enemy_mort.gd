extends CharacterBody2D


@export var patrol_speed : float = 50.0
@export var gravity : float = 980.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_detect: RayCast2D = $FloorDetect

var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL}

var current_state : STATE = STATE.PATROL

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	if !floor_detect.is_colliding():
		if direction == Vector2.RIGHT:
			direction = Vector2.LEFT
			floor_detect.position.x = -6
			animated_sprite_2d.flip_h = true
		else:
			direction = Vector2.RIGHT
			floor_detect.position.x = 6
			animated_sprite_2d.flip_h = false
		 
		


func _process(delta: float) -> void:
	if current_state == STATE.IDLE:
		velocity=Vector2.ZERO
		animated_sprite_2d.play("Idle")
	elif current_state == STATE.PATROL:
		animated_sprite_2d.play("Walk")
		velocity.x=direction.x*patrol_speed
 
