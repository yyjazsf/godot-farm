extends NodeState

@export var player: Player
@export var animate_sprite: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	
	pass
			
func _on_next_transitions() -> void:
	if !animate_sprite.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	match player.direction:
		Vector2.UP:
			animate_sprite.play("chopping_back")
		Vector2.DOWN:
			animate_sprite.play("chopping_front")
		Vector2.LEFT:
			animate_sprite.play("chopping_left")
		Vector2.RIGHT:
			animate_sprite.play("chopping_right")

func _on_exit() -> void:
	animate_sprite.stop()
