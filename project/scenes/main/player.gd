extends KinematicBody

export(float) var speed : float = 10
export(float) var accel_weight : float = 20

export(float) var sens : float = 1
export(float) var fov : float = 90

onready var cam : Camera = $cam

var time_hold : float = 0
var vel : Vector3 = Vector3.ZERO

var total_y_rot : float = 0

func _ready() -> void:
	cam.fov = fov
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event : InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event is InputEventMouseMotion:
		rotate_y(sens * -0.001 * event.relative.x)
		
		var y_rot : float = sens * -0.001 * event.relative.y
		y_rot = clamp(total_y_rot + y_rot, -0.4 * PI, 0.4 * PI) - total_y_rot
		cam.rotate(cam.transform.basis.x, y_rot)
		total_y_rot += y_rot

func _process(delta):
	var result : Dictionary = get_world().direct_space_state.intersect_ray(
		cam.global_transform.origin, cam.global_transform.basis.z * -10,
		[], 0x7FFFFFFF,
		false, true
	)
	print(result)

func _physics_process(delta : float) -> void:
	var dir_x : float = 1 if Input.is_action_pressed("right") else 0
	dir_x -= 1 if Input.is_action_pressed("left") else 0
	
	var dir_y: float = 1 if Input.is_action_pressed("back") else 0
	dir_y -= 1 if Input.is_action_pressed("forward") else 0
	
	var dir : Vector2 = Vector2(dir_x, dir_y).normalized()
	
	var target : Vector3 = ((dir.x * transform.basis.x) + (dir.y * transform.basis.z)) * speed
	
	if (vel - target).length() > 0.1:
		pass
		vel += (target - vel) * (accel_weight * delta)
	else:
		vel = target
	
	move_and_slide(vel, Vector3.UP)
