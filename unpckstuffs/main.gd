extends CanvasLayer

var dirs = ["res://"]
var dir
var filedi
func _ready():
	dir = Directory.new()
	var button = Button.new()
	add_child(button)
	button.text = "Load Pck"
	button.anchor_bottom = 0.5
	button.anchor_top = 0.5
	button.anchor_left = 0.5
	button.anchor_right = 0.5
	button.rect_position = Vector2(478,290)
	button.rect_size = Vector2(68,20)
	button.connect("button_up",self,"loadbutton")
	filedi = FileDialog.new()
	add_child(filedi)
	filedi.anchor_bottom = 0.5
	filedi.anchor_top = 0.5
	filedi.anchor_left = 0.5
	filedi.anchor_right = 0.5
	filedi.rect_size = Vector2(700,400)
	filedi.filters = ["*.pck"]
	filedi.access = FileDialog.ACCESS_FILESYSTEM
	filedi.mode = FileDialog.MODE_OPEN_FILE
	filedi.show_hidden_files = true
	filedi.connect("file_selected",self,"_on_FileDialog_file_selected")
func loadbutton():
	filedi.popup_centered()
func _on_FileDialog_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	while dirs.size() != 0:
		print(dirs)
		extract(dirs[0])
		dirs.remove(0)
	OS.shell_open(OS.get_user_data_dir())
	filedi.hide()
func extract(path):
	var formpath = path
	formpath.erase(0,3)
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				if not file_name == "unpckstuffs":
					dirs.insert(dirs.size(),path+file_name+"/")
					dir.make_dir("user"+formpath+file_name)
			else:
				dir.copy(path+file_name,"user"+formpath+file_name)
			file_name = dir.get_next()