extends Control

onready var mat: Material = $ViewportContainer.get_material()
onready var initial_pos: Vector2 = mat.get_shader_param("position")
onready var initial_re_bounds: Vector2 = mat.get_shader_param("re_bounds")
onready var initial_im_bounds: Vector2 = mat.get_shader_param("im_bounds")

var zoom = 1.0

func _process(delta: float):
	var pos: Vector2 = mat.get_shader_param("position")
	var re_bounds: Vector2 = mat.get_shader_param("re_bounds")
	var im_bounds: Vector2 = mat.get_shader_param("im_bounds")
	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		direction.x += 1.0
	if Input.is_action_pressed("ui_up"):
		direction.y += 1.0
	if Input.is_action_pressed("ui_down"):
		direction.y -= 1.0

	direction = direction.normalized() * zoom * delta
	pos += direction
	
	if Input.is_action_pressed("zoom_in"):
		zoom -= 1.0 * delta * zoom
	if Input.is_action_pressed("zoom_out"):
		zoom += 1.0 * delta * zoom

	# https://stackoverflow.com/a/60815690
	var re_range = 3.5 * zoom;
	var im_range = 2.0 * zoom;
	re_bounds = Vector2(0.5 - re_range / 2.0, 0.5 + re_range / 2.0)
	im_bounds = Vector2(0.5 - im_range / 2.0, 0.5 + im_range / 2.0)

	if Input.is_action_just_pressed("reset"):
		pos = initial_pos
		zoom = 1.0
		re_bounds = initial_re_bounds
		im_bounds = initial_im_bounds

	mat.set_shader_param("position", pos)
	mat.set_shader_param("re_bounds", re_bounds)
	mat.set_shader_param("im_bounds", im_bounds)
