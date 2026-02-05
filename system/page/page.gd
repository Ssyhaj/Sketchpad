class_name Page
extends Resource

@export var layers: Array[Image] = []
var textures: Array[ImageTexture] = []

func _init(w: int, h: int) -> void:
	create_layer(w, h, Color.WHITE)
	create_layer(w, h)
	print("[Page] Page created")

## Creates a layer in the page. [br]
## [param w] - Width of layer. [br]
## [param h] - Height of layer. [br]
## [param c] - Color of background. Defaults to transparent.
func create_layer(w: int, h: int, c: Color = Color.TRANSPARENT) -> void:
	layers.append(Image.create_empty(w, h, false, Image.FORMAT_RGBA8))
	layers[-1].fill(c)
	textures.append(ImageTexture.create_from_image(layers[-1]))

## Returns the Page as an array of ImageTextures.
func get_content() -> Array[ImageTexture]:
	for i in range(layers.size()):
		if i < textures.size():
			textures[i].update(layers[i])
	return textures

## Updates Page contents with live textures.
func set_content() -> void:
	for i in range(layers.size()):
		if i < textures.size():
			layers[i] = textures[i].get_image()

## Updates layer content with provided image.[br]
## [param idx] - Index of layer. [br]
## [param image] - Image to replace layer with.
func set_layer(idx: int, image: Image) -> void:
	layers[idx] = image
	textures[idx].update(layers[idx])
