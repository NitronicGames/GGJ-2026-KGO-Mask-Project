extends Node

@onready var player := AudioStreamPlayer.new()

var menu_music = preload("res://audio/K,Go! Main Menu Music 2.wav")
var gameplay_music = preload("res://audio/K,Go! Main Menu Music 1.wav")


func _ready() -> void:
	add_child(player)
	player.bus = "Music" # optional; make a Music bus in Audio settings

func play_menu() -> void:
	_play(menu_music)

func play_gameplay() -> void:
	_play(gameplay_music)

func pause_music() -> void:
	player.stream_paused = true

func resume_music() -> void:
	player.stream_paused = false

func stop_music() -> void:
	player.stop()

func _play(stream: AudioStream) -> void:
	if stream == null:
		return
	if player.stream == stream and player.playing:
		return
	player.stream = stream
	player.stream_paused = false
	player.play()
