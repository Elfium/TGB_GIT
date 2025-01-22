class_name Combat extends Node
##

##
static var ref : Combat
##
func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


##
@onready  var state_idle : CombatState = $IdleState
##
@onready var state_move : CombatState = $MoveState
##
@onready var state_enemy_selection : CombatState = $EnemySelectionState
##
@onready var state_wind_up : CombatState = $WindUpState
##
@onready var state_attack : CombatState = $AttackState
##
@onready var state_reward : CombatState = $RewardState
##
var current_state : CombatState


##
var enemy : Enemy


##
func _ready() -> void :
	current_state = state_idle
	current_state.enter_state()


##
func change_state(state : CombatState) -> Error : 
	if not current_state.can_switch_to(state) : return FAILED
	current_state.exit_state()
	current_state = state
	current_state.enter_state()
	return OK
