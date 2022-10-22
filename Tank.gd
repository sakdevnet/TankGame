extends KinematicBody2D



var Speed: int = 0
export var TopSpeed: int = 300

export var RotationSpeed: float = deg2rad(90)
var calculatedRotation: float = 0.0

export var Friction = 30
export var acceleration: float = 0
const TopAcceleration = 20



var velocity = Vector2()
var result_velocity = Vector2()
var RotationDirection = 0
var ForceDirection = 0
var MoveDirection = 0
var LastMoveDirection = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	calculatedRotation = rotation	

func _physics_process(delta: float) -> void:
	get_input()	
	calculatedRotation += RotationDirection * RotationSpeed * delta	
	rotation = calculatedRotation	
	
	if (ForceDirection == 0):
		acceleration = 0
	else:
		acceleration = TopAcceleration

	
	Speed = Speed + (MoveDirection *  ForceDirection * acceleration) - (Friction * delta)

	Speed  = clamp(Speed,0,TopSpeed)	
	
	if (Speed == 0): MoveDirection = 0	
	
	velocity = Vector2.ZERO	
	velocity.y = MoveDirection
	#velocity = velocity.normalized()	
	velocity = velocity.rotated(calculatedRotation) * Speed
	#var collisionInfo: KinematicCollision2D = move_and_collide(velocity)
	move_and_slide(velocity)
	
	
func get_input():	
	RotationDirection = 0
	
	ForceDirection = 0
#	if Speed == 0: MoveDirection = -1
	
	if Input.is_action_pressed("ui_right"):
		RotationDirection += 1
	if Input.is_action_pressed("ui_left"):
		RotationDirection -= 1
	if Input.is_action_pressed("ui_down"):
		ForceDirection = 1
		if Speed == 0: MoveDirection = 1
	if Input.is_action_pressed("ui_up"):
		ForceDirection = -1
		if Speed == 0: MoveDirection = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
