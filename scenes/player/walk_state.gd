extends NodeState

@export var player: Player
@export var animate_sprite: AnimatedSprite2D
@export var speed = 50

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	match direction:
		Vector2.UP:
			animate_sprite.play("walking_back")
		Vector2.DOWN:
			animate_sprite.play("walking_front")
		Vector2.RIGHT:
			animate_sprite.play("walking_right")
		Vector2.LEFT:
			animate_sprite.play("walking_left")
		
	if direction != Vector2.ZERO:
		player.direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	animate_sprite.stop()


func _on_exit() -> void:
	pass
