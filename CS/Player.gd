extends CharacterBody2D

# 속도
const SPEED = 100.0
# 가속도
const ACCELERATION = 800.0
# 마찰력
const FRICTION = 1000.0
# 점프 중력
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	ApplyGravity(delta)
	HandleJump()
	
	var input_axis = Input.get_axis("ui_left","ui_right")
		
	HandleAcceleration(input_axis, delta)
	ApplyFriction(input_axis, delta)
	move_and_slide()
	
func ApplyGravity(delta):
		if not is_on_floor():
			velocity.y += gravity * delta
			
func HandleJump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
			
func HandleAcceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func ApplyFriction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
