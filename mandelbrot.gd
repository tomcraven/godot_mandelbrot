extends Control

onready var mat: Material = $ViewportContainer.get_material()
onready var initial_pos: Vector2 = mat.get_shader_param("position")
onready var initial_zoom: float = mat.get_shader_param("zoom")
onready var initial_detail: int = mat.get_shader_param("detail")

func _ready():
	mat.set_shader_param("palette", $ViewportContainer/Viewport/TextureRect.texture)

func _process(delta: float):
	var pos: Vector2 = mat.get_shader_param("position")
	var zoom: float = mat.get_shader_param("zoom")
	var detail: int = mat.get_shader_param("detail")
	
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
		zoom += 1.0 * delta * zoom
	if Input.is_action_pressed("zoom_out"):
		zoom -= 1.0 * delta * zoom

	if Input.is_action_pressed("detail_up"):
		detail += 1.0
	if Input.is_action_pressed("detail_down"):
		detail -= 1.0

	if Input.is_action_just_pressed("reset"):
		pos = initial_pos
		zoom = initial_zoom
		detail = initial_detail
		
	mat.set_shader_param("position", pos)
	mat.set_shader_param("zoom", zoom)
	mat.set_shader_param("detail", detail)
