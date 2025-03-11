extends NodeState

@export var player: Player
@export var animate_sprite: AnimatedSprite2D
@export var speed = 50

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	match player.direction:
		Vector2.UP:
			animate_sprite.play("idle_back")
		Vector2.DOWN:
			animate_sprite.play("idle_front")
		Vector2.RIGHT:
			animate_sprite.play("idle_right")
		Vector2.LEFT:
			animate_sprite.play("idle_left")
		Vector2.ZERO:
			animate_sprite.play("idle_front")
			
	


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animate_sprite.stop()
