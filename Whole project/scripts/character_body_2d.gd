extends CharacterBody2D


var speed : float = 400

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	position += direction.normalized() * speed * delta
	pass
	
