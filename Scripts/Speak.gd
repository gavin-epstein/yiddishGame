extends TextureButton




func _on_SpeakApple_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer,"finished")
		pressed = false;
	else:
		$AudioStreamPlayer.stop()
