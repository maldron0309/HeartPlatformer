extends CharacterBody2D

# 속도
const SPEED = 100.0
# 가속도
const ACCELERATION = 600.0
# 마찰력
const FRICTION = 600.0
# 점프 중력
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED, ACCELERATION * delta)
	else:
		velocity.x = 0 

	move_and_slide()
