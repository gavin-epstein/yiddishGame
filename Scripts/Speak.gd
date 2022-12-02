extends TextureButton

var controller
func setup(controller):
	self.controller = controller

func _on_SpeakApple_toggled(button_pressed: bool) -> void:
	if button_pressed:
		controller.Log("sound", $AudioStreamPlayer.stream.resource_path)
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer,"finished")
		pressed = false;
	else:
		$AudioStreamPlayer.stop()
