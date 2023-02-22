extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var texture: Texture
export(String, MULTILINE) var poem: String

# Called when the node enters the scene tree for the first time.
func _ready():
	var dims := texture.get_size()
	var pixel_size := 4.0 * 0.98 / dims.x
	var height := pixel_size * dims.y
	
	for child in [$Left, $Right, $Into, $Out, $Up]:
		child.pixel_size = pixel_size
		child.translation.y = height / 2
		child.texture = texture
		
	$Up.translation.y = height
	$"SpotLight-Z".translation.y = height / 2
		

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
