extends CharacterBody2D


@export var patrol_speed : float = 50.0
@export var gravity : float = 980.0

var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL}

var curren_state : STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta




	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
