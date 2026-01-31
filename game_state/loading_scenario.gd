extends State

var path: String
var progress_value: float = 0


# From the example at
# https://docs.godotengine.org/en/stable/tutorials/io/background_loading.html#using-resourceloader
func load(path_to_load: String):
	path = path_to_load
	ResourceLoader.load_threaded_request(path)


func on_enter_state() -> void:
	print("on_enter_state ", name)


func on_exit_state() -> void:
	print("on_exit_state ", name)


func _process(_delta: float):
	if not path:
		return

	var progress = []
	var status = ResourceLoader.load_threaded_get_status(path, progress)

	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
		progress_value = progress[0] * 100
		#progress_bar.value = move_toward(progress_bar.value, progress_value, delta * 20)

	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		progress_value = 100
		# zip the progress bar to 100% so we don't get weird visuals
		#progress_bar.value = move_toward(progress_bar.value, 100.0, delta * 150)

	# "done" loading :)
	if progress_value >= 99.99:
		manager.scenario = ResourceLoader.load_threaded_get(path)
		manager.run_dialogue()
