extends CharacterBody2D


@export var patrol_speed : float = 50.0
@export var gravity : float = 980.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_detect: RayCast2D = $FloorDetect
@onready var player_detector: Area2D = $PlayerDetector
@export var chase_timer: Timer
@export var idle_timer: Timer



var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL, CHASE}

var current_state : STATE = STATE.IDLE

func _ready() -> void:
	player_detector.body_entered.connect( _check_for_player)
	player_detector.body_exited.connect( _player_left )
	chase_timer.timeout.connect( _stop_chasing )
	
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	match current_state:
		STATE.IDLE:
			handle_idle()
		STATE.PATROL:
			handle_patrol()
		STATE.CHASE:
			handle_chase()

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
		 
		

func handle_idle() -> void:
	idle_timer.start()
	idle_timer.timeout.connect( _start_patrol )
	velocity.x=0
	animated_sprite_2d.play("Idle")
	pass

func handle_patrol() -> void:
	animated_sprite_2d.play("Walk")
	velocity.x=direction.x*patrol_speed
	
	pass

func handle_chase() -> void:
	animated_sprite_2d.play("Walk")
	velocity.x=direction.x*(patrol_speed*2)	
	pass
	
	
func _check_for_player ( body : Node2D ) -> void:
	if body is Player:
		chase_timer.stop()

		current_state = STATE.CHASE
		
func _player_left ( body : Node2D ) -> void:
	if body is Player:
		chase_timer.start()
		
		
func _stop_chasing () -> void:
	current_state = STATE.IDLE
	
	
func _start_patrol () -> void:
	current_state = STATE.PATROL

	
