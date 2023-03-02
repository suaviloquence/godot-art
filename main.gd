extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var texture: Texture
export(String, MULTILINE) var poem: String

# Called when the node enters the scene tree for the first time.
func _ready():
	var dims := texture.get_size()
	var gaps := .9
	var scale := 2.0
	var node_scale := scale * gaps
	var pixel_size := 2.0 * node_scale  / dims.x
	var height := pixel_size * dims.y / gaps
	
	for child in [$Left, $Right, $Into, $Out, $Up]:
		child.pixel_size = pixel_size
		child.scale =  Vector3.ONE * node_scale
		child.translation.y = height / 2
		child.texture = texture
		
	$Up.translation.y = height + gaps
	$"SpotLight-Z".translation.y = height / 2
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


const MOUSE_SENSITIVITY := 0.1
var angle := 0.0

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE)

onready var camera := $CameraContainer/Camera as Camera
onready var camera_container := $CameraContainer as Spatial

# temporary, taken/modified from godot fps tutorial
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY))
		camera_container.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = camera.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		camera.rotation_degrees = camera_rot

		

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
