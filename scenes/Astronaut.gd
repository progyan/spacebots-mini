extends KinematicBody2D

const SPEED = 200
const GRAVITY = 300
const JUMP_SPEED = -150;
const UP = Vector2(0, -1)

var motion = Vector2()

var left = false
var right = false

func run():
	if (Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left")) or right:
		motion.x = SPEED
	elif (Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")) or left:
		motion.x = -SPEED
	else:
		motion.x = 0

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
