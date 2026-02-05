extends Node

signal framerate_change(new_fr: float)
signal play_toggle

signal load_call
signal save_call

var is_playing = false

var _project: Project

func attach_project(project: Project):
	_project = project

func _on_next_button_pressed() -> void:
	if(_project):
		_project.next_page(false)

func _on_prev_button_pressed() -> void:
	if(_project):
		_project.prev_page()

func _on_play_pressed() -> void:
	play_toggle.emit()
	is_playing = !is_playing

	$HBoxContainer/PlayButton.text = "Pause" if is_playing else "Play"
	$HBoxContainer/NextButton.disabled = ! $HBoxContainer/NextButton.disabled
	$HBoxContainer/PrevButton.disabled = ! $HBoxContainer/PrevButton.disabled

func _on_slider_value_changed(value: float) -> void:
	$HBoxContainer/HBoxContainer/Label.text = str(value)
	framerate_change.emit(value)

func _on_save_button_pressed() -> void:
	save_call.emit()

func _on_load_button_pressed() -> void:
	load_call.emit()
