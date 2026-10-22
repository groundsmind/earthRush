extends Node

func get_audio_streams_in_folder(path: String) -> Array[AudioStream]:
	var streams: Array[AudioStream] = []
	var dir := DirAccess.open(path)
	
	if dir == null:
		printerr("Could not open directory: ", path)
		return streams
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		if not dir.current_is_dir():
			if file_name.ends_with(".import"):
				file_name = file_name.trim_suffix(".import")
				
			if file_name.ends_with(".wav") or file_name.ends_with(".ogg") or file_name.ends_with(".mp3"):
				var full_path = path.path_join(file_name)
				var stream = load(full_path) as AudioStream
				if stream:
					streams.append(stream)
					
		file_name = dir.get_next()
		
	dir.list_dir_end()
	return streams
