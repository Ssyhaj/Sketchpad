class_name Project
extends Resource

signal new_current_page(page: Page)

@export var title: String = "New Animation"
@export var framerate: float = 1.0

@export var width: int = 256
@export var height: int = 192

@export var frames: Array[Page]

@export var audio: AudioStream
@export var audio_clips: Dictionary[int, AudioStream]

var _current_layer: int = 0
var _current_frame: int = 0

## Initializes a new project. [br]
## Used instead of [code]_init[/code] to avoid overwriting loaded data.
func new_project(w: int, h: int) -> void:
	width = w
	height = h

	frames.append(Page.new(width, height))
	new_current_page.emit(frames[0])
	print("[Project] New project created")

## Returns the current focused page in the project.
func get_current_page() -> Page:
	return frames[_current_frame]

## Returns a page some distance removed from the focused page in the project. [br]
## Returns [code]null[/code] if the page does not exist. [br]
## [param distance]: Determines how far to grab the page.
func get_distant_page(distance: int = 1) -> Page:
	if _current_frame + distance >= 0 and _current_frame + distance < len(frames):
		return frames[_current_frame + distance]
	return null

## Changes the current project page to the next page. [br]
## [param is_loop]: Goes back to page 0 if at the end. Adds a new page otherwise.
func next_page(is_loop: bool) -> Page:
	_current_frame += 1
	if len(frames) < (_current_frame + 1):
		if is_loop:
			_current_frame = 0
		else: frames.append(Page.new(width, height))
	new_current_page.emit(frames[_current_frame])
	return frames[_current_frame]

## Changes the current project page to the previous page. Stops at frame 0.
func prev_page() -> Page:
	if(_current_frame > 0):
		_current_frame -= 1
	new_current_page.emit(frames[_current_frame])
	return frames[_current_frame]
