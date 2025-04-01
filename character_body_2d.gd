extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D
@export var speed := 100

var walk_timer := 0.0
var walk_frame := 0
var last_direction := "default"

func _physics_process(delta):
	var input_dir := Vector2.ZERO

	# Input handling
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
		last_direction = "left"
	elif Input.is_action_pressed("right"):
		input_dir.x += 1
		last_direction = "right"
	elif Input.is_action_pressed("back"):
		last_direction = "back"
	elif Input.is_action_just_pressed("front"):
		last_direction = "front"
	elif not Input.is_action_pressed("left") and not Input.is_action_pressed("d"):
		last_direction = "default"

	# Movement
	velocity = input_dir.normalized() * speed
	move_and_slide()

	# Animation logic
	if input_dir.x < 0:
		animate_walking("left", delta)
	elif input_dir.x > 0:
		animate_walking("right", delta)
	else:
		animate_idle()

func animate_walking(dir: String, delta: float):
	walk_timer += delta
	if walk_timer >= 0.25:
		walk_timer = 0.0
		walk_frame = (walk_frame + 1) % 2
	
	var anim_name = "walking_" + dir + str(walk_frame + 1)
	if sprite.animation != anim_name:
		sprite.play(anim_name)

func animate_idle():
	var anim_name = "idle_" + last_direction
	if not sprite.is_playing() or sprite.animation != anim_name:
		sprite.play(anim_name)
