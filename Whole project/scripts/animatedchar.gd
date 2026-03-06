extends CharacterBody2D
var speed  : float = 150


@export var gravity : float = 980.0

@export var jump_force : float  = -400
@onready var animation_player: AnimationPlayer = $"../Player/AnimationPlayer"
@onready var sprite_2d: Sprite2D = $"../Player/Sprite2D"
@onready var winner_text: Label = $"../Sky And Land/winner_text"
@onready var loser_text: Label = $"../Sky And Land/loser_text"
@onready var slime: Area2D = $"../slime"
@onready var slime_2: Area2D = $"../slime2"
@onready var slime_3: Area2D = $"../slime3"
@onready var win_coin: Area2D = $"../win coin"
@onready var obstacle_2: StaticBody2D = $"../obstacle2"
@onready var obstacle: StaticBody2D = $"../obstacle"
@onready var player: CharacterBody2D = $"../Player"
@onready var sky_and_land: Sprite2D = $"../Sky And Land"


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
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	



	if !is_on_floor():
		animation_player.play("jump")
	elif direction != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if get_tree().paused:
			get_tree().paused = false
			get_tree().reload_current_scene()		
		elif is_on_floor():
			velocity.y = jump_force
	

func die () -> void:
	print("Player Died")
	loser_text.visible = true
	slime.visible = false
	slime_2.visible = false
	slime_3.visible = false
	win_coin.visible = false
	obstacle.visible = false
	obstacle_2.visible = false
	player.visible = false
	get_tree().paused = true
	
		
			
	
func win() -> void:
	print("Player Wins")
	winner_text.visible = true
	slime.visible = false
	slime_2.visible = false
	slime_3.visible = false
	win_coin.visible = false
	obstacle.visible = false
	obstacle_2.visible = false
	player.visible = false
	get_tree().paused = true
