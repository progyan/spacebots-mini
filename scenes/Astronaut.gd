extends KinematicBody2D

const SPEED = 200
const ACCEL = 10
const DECEL = 0.95
const GRAVITY = 100
const JUMP_SPEED = -150;
const EPSILON = 30;
const UP = Vector2(0, -1)

var motion = Vector2()
var anim = 0

func run():
	if (Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left")):
		motion.x += ACCEL
	elif (Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")):
		motion.x -= ACCEL
	else:
		motion.x *= DECEL
	motion.x = clamp(motion.x, -SPEED, SPEED)

func fall(delta):
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY * delta

func _physics_process(delta):
	update_motion(delta)

func update_motion(delta):
	fall(delta)
	run()
	jump()
	move_and_slide(motion, UP)

func jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y = JUMP_SPEED

func _process(delta):
	animate()

func animate():
	anim = "default"
	if abs(motion.x) > EPSILON:
		anim = "walk"
	if motion.y < 0:
		anim = "jump"
	$Sprite.animation = anim
	$Sprite.flip_h = motion.x < 0
