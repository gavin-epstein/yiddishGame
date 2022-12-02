extends Control
signal completed
export var correct = 0
var controller
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func setup(controller):
	print("setup" + self.name)
	self.controller = controller
	for child in self.get_children():
		if child.has_method('setup'):
			child.setup(controller)


func _on_Any_Button_pressed(button: int) -> void:
	var resulttext= "wrong"
	if correct == button:
		resulttext = "correct"
	controller.Log("answer" , str(button)+"_" + resulttext)
	if correct == button:
		
		#print("woo")
		emit_signal('completed')
		if controller.groupID == 1:
			$GoodSound.play()
		elif controller.groupID == 3:
			$BadSound.play()
	else:
		if controller.groupID == 3:
			$GoodSound.play()
		elif controller.groupID == 1:
			$BadSound.play()
		


func _on_finishButton_pressed() -> void:
	
	controller.upload()
