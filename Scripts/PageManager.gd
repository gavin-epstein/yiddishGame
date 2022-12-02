extends Node2D


var pages = []
var index  = 0
var groupID = 0
var personID
var completed = []
var data = []

func _ready():
	Load()
	display()

func Load():
	groupID = randi()%3 +1;
	personID = str(randi())
	var dir = Directory.new()
	dir.open("res://Assets/Scenes/Pages/")
	print(dir.get_current_dir())
	dir.list_dir_begin()

	while true:
		var fname = dir.get_next()
		
		if fname == "":
			break
		elif fname.ends_with(".tscn"):
			var result : Node = null
			var path =dir.get_current_dir()+"/"+fname
			if ResourceLoader.exists(path) :
				result = ResourceLoader.load(path).instance()
			if result :
				result.get_child(0).setup(self)#assigns self to controller in child
				pages.append(result)
				completed.append(false)

	
func display():
	if index== 0:
		$Arrow2.visible=false
	if index == pages.size() - 1:
		$Arrow1.visible = false
	for child in $Page.get_children():
			$Page.remove_child(child)
	$Page.add_child(pages[index])
	pages[index].get_node("Control").connect("completed",self,'complete')
	if completed[index]:
		$Arrow1.modulate = Color(1,1,1);
	else:
		$Arrow1.modulate = Color(.5,.5,.5,.5);
	

func _on_Arrow1_pressed() -> void:
	if completed[index]:
		index+=1
		display()


func _on_Arrow2_pressed() -> void:
	pass # Replace with function body.

func complete():
	completed[index] = true
	$Arrow1.modulate = Color(1,1,1,1)
	
func Log(action, context):
	var dict = {}
	dict["groupID"] = groupID
	dict["personID"] = personID
	dict["page"] = index
	dict["action"] = action
	dict["context"] = context
	data.append(dict);
	
func upload():
	var bodyjson = to_json(data)
	
	print("Submitting")
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_onResponse")
	var error = http_request.request("https://gavinepstein.space/datacollection.php", ["Content-type:text/plain"], true, HTTPClient.METHOD_POST, bodyjson)
	if error != OK:
		print("An error occurred in the HTTP request.")
	print(error)
	#get_tree().paused=false
	yield(http_request,"request_completed")
	get_tree().change_scene_to(load("res://Assets/Scenes/Thanksforplaying.tscn"))
func _onResponse(result, response_code, headers, body):
	print("Response:   ")
	print(body.get_string_from_utf8())
