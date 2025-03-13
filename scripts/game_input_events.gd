class_name GameInputEvents 

static var direction: Vector2

# 使用字典映射工具按键到对应的工具类型
static var tool_mapping = {
	"tool_1": DataTypes.Tools.AxeWood,
	"tool_2": DataTypes.Tools.TillGround,
	"tool_3": DataTypes.Tools.WaterCrops,
	"tool_4": DataTypes.Tools.PlantCorn,
	"tool_5": DataTypes.Tools.PlantTomato
}

static func movement_input() ->  Vector2:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	return direction
	
static  func is_movement_input() -> bool:
	return direction != Vector2.ZERO

static func use_tool() -> bool:
	return Input.is_action_pressed("action")

static func switch_tools() -> DataTypes.Tools:
	# 遍历映射检查是否有按键被按下
	for action_name in tool_mapping:
		if Input.is_action_just_pressed(action_name):
			return tool_mapping[action_name]
	
	# 如果没有按键被按下，返回None
	return DataTypes.Tools.None
