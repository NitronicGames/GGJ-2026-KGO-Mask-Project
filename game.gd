class_name Game
extends Node2D

var left_npc: AnimatedSprite2D
var right_npc: AnimatedSprite2D

@onready var left_npc_mark: Marker2D = $LeftNPCMark
@onready var right_npc_mark: Marker2D = $RightNPCMark
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	var vp_rect: Rect2i = get_viewport_rect()
	animated_sprite_2d.hide()
	animated_sprite_2d.position = vp_rect.get_center()
	animated_sprite_2d.animation_finished.connect(animated_sprite_2d.hide)


func show_k_go() -> Signal:
	animated_sprite_2d.play("default")
	animated_sprite_2d.show()
	return animated_sprite_2d.animation_finished


func add_left_npc(npc: NPC) -> void:
	if is_instance_valid(left_npc):
		left_npc.queue_free()
	left_npc = instantiate_npc(npc)	
	left_npc.global_position = left_npc_mark.global_position
	left_npc.show()


func add_right_npc(npc: NPC) -> void:
	if is_instance_valid(right_npc):
		right_npc.queue_free()
	right_npc = instantiate_npc(npc)
	right_npc.global_position = right_npc_mark.global_position
	right_npc.flip_h = true
	right_npc.show()


func remove_left_npc() -> void:
	if is_instance_valid(left_npc):
		left_npc.queue_free()
	left_npc = null


func remove_right_npc() -> void:
	if is_instance_valid(right_npc):
		right_npc.queue_free()
	right_npc = null


func left_npc_speaking() -> void:
	if is_instance_valid(left_npc):
		left_npc.play("idle")
	if is_instance_valid(right_npc):
		right_npc.play("default")


func right_npc_speaking() -> void:
	if is_instance_valid(left_npc):
		left_npc.play("default")
	if is_instance_valid(right_npc):
		right_npc.play("idle")


func no_npc_speaking() -> void:
	if is_instance_valid(left_npc):
		left_npc.play("default")
	if is_instance_valid(right_npc):
		right_npc.play("default")


func instantiate_npc(_npc: NPC) -> Node2D:
	var scene: PackedScene = load(_npc.scene_file)
	var npc: AnimatedSprite2D = scene.instantiate()
	npc.hide()
	add_child(npc)
	return npc
