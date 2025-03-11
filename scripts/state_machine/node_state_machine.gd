class_name NodeStateMachine
extends Node

# 管理游戏中各种对象（如角色、敌人等）的不同状态
# 处理状态之间的平滑转换
# 确保每个状态都能正确执行其进入、退出和更新逻辑
# 1.为游戏对象创建不同的状态（如：待机、移动、攻击等）
# 2.定义状态之间的转换条件
# 3.在每个状态中实现特定的行为
# 4.通过信号系统触发状态转换

# 角色状态管理
# 游戏流程控制
# 敌人AI行为
# 任何需要在不同状态间切换的系统

# 状态机是一种用于管理对象状态的系统
# 状态机由多个状态组成，每个状态定义了对象在特定情况下的行为
# 状态机可以处理对象的各种状态，并根据对象当前的状态执行相应的操作

@export var initial_node_state : NodeState

var node_states : Dictionary = {}
var current_node_state : NodeState
var current_node_state_name : String
var parent_node_name: String


func _ready() -> void:
	parent_node_name = get_parent().name
	
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			# Connect the transition signal to the transition_to function
			child.transition.connect(transition_to)
	
	# Set the initial state
	if initial_node_state:
		initial_node_state._on_enter()
		current_node_state = initial_node_state
		current_node_state_name = current_node_state.name.to_lower()


func _process(delta : float) -> void:
	# Process the current state
	if current_node_state:
		current_node_state._on_process(delta)

# 处理物理更新逻辑
func _physics_process(delta: float) -> void:
	# Process the current state
	if current_node_state:
		current_node_state._on_physics_process(delta)
		# 检查可能的下一状态转换
		current_node_state._on_next_transitions()
		#print(parent_node_name, " Current State: ", current_node_state_name)

#状态转换功能
func transition_to(node_state_name : String) -> void:
	if node_state_name == current_node_state.name.to_lower():
		return
	
	# 获取新的状态节点
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return
	
	# 退出当前状态
	if current_node_state:
		current_node_state._on_exit()
	
	# 进入新的状态
	new_node_state._on_enter()
	
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	#print("Current State: ", current_node_state_name)
