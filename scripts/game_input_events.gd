class_name GameInputEvents 

static var direction: Vector2

static func movement_input() ->  Vector2:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	return direction
	
static  func is_movement_input() -> bool:
	return direction != Vector2.ZERO
