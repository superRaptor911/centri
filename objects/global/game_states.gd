extends Node

var game_settings = {
	version = 1.0,
	glow = true,
	music = true,
	fps = false
}

var player_info = {
	high_score = 0
}

var main_music = AudioStreamPlayer.new()
var stream = preload("res://music/BoxCat_Games_-_10_-_Epic_Song.ogg")

var admob : Admob = Admob.new()
var retry_count = 0

func _ready():
	add_child(admob)
	add_child(main_music)
	main_music.stream = stream
	if load_data("user://game_settings").has("version"):
		loadEverything()
	else:
		print("first run")
		saveEverything()
	if game_settings.music:
		main_music.play()
	
	#admob.is_real = true
	admob.banner_on_top = false
	admob.load_interstitial()
	admob.load_rewarded_video()


func saveEverything():
	save_data("user://game_settings",game_settings)
	save_data("user://pinfo",player_info)


func loadEverything():
	game_settings = load_data("user://game_settings")
	player_info = load_data("user://pinfo")


func save_data(save_path : String, data : Dictionary,use_enc = true) -> void:
	var data_string = JSON.print(data)
	var file = File.new()
	var json_error = validate_json(data_string)
	if json_error:
		print_debug("JSON IS NOT VALID FOR: " + data_string)
		print_debug("error: " + json_error)
		return
	
	if use_enc:
		file.open_encrypted_with_pass(save_path, File.WRITE, OS.get_unique_id())
	else:
		print("no enc")
		file.open(save_path,File.WRITE)
	file.store_string(data_string)
	file.close()


func load_data(save_path : String = "user://game.dat", use_enc = true) -> Dictionary:
	var file : File = File.new()
	if not file.file_exists(save_path):
		print_debug('file [%s] does not exist; creating' % save_path)
		save_data(save_path, {},use_enc)
	if use_enc:
		file.open_encrypted_with_pass(save_path, File.READ, OS.get_unique_id())
	else:
		print("no enc")
		file.open(save_path,File.READ)
	var json : String = file.get_as_text()
	var data = parse_json(json)
	file.close()
	return data
