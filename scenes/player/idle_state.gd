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
	print("player.current_tool:",player.current_tool, DataTypes.Tools.None)
	var new_tool = GameInputEvents.switch_tools()
	if new_tool != DataTypes.Tools.None:
		player.current_tool = GameInputEvents.switch_tools()
		

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	
	if GameInputEvents.use_tool():
		match player.current_tool:
			DataTypes.Tools.AxeWood:
				transition.emit("Chopping")
			DataTypes.Tools.TillGround:
				transition.emit("Tilling")
			DataTypes.Tools.WaterCrops:
				transition.emit("Watering")
			DataTypes.Tools.PlantCorn:
				transition.emit("PlantCorn")
			DataTypes.Tools.PlantTomato:
				transition.emit("PlantTomato")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animate_sprite.stop()
