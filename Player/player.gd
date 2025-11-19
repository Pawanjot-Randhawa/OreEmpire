extends CharacterBody3D


const SPEED = 10.3
const JUMP_VELOCITY = 2.3

var look_dir: Vector2
var capture_mouse: bool = true

@onready var camera: Camera3D = $Pivot/Camera3D;
@onready var head: Node3D = $Pivot;

var camera_sens: float = 0.003

func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Global.has_focus:
		head.rotate_y(-event.relative.x * camera_sens)
		camera.rotate_x(-event.relative.y * camera_sens)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	handle_movement(delta);
	if Global.has_focus: 
		move_and_slide()

func handle_movement(delta: float):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor() and Global.has_focus:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := (Input.get_vector("left", "right", "up", "down") if Global.has_focus else Vector2.ZERO)
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func player(): pass
