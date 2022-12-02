extends Node2D



func _on_Arrow1_pressed() -> void:
	if $ColorRect/RichTextLabel.text.length()>0:
		var controller = load("res://Assets/Scenes/PageManager.tscn").instance()
		add_child(controller)
		controller.personID = $ColorRect/RichTextLabel.text
	else:
		$ColorRect/error.visible = true
