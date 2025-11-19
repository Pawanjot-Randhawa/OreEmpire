extends Node3D

@onready var animation_player: AnimationPlayer = $"door-rotate-square-c2/AnimationPlayer"
var is_open: bool = false
var can_interact: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if is_open:
			animation_player.play("close")
			is_open = false
		else:
			animation_player.play("open")
			is_open = true

func _on_interaction_range_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		can_interact = true
		SignalBus.emit_signal("change_interaction_UI", "Door")


func _on_interaction_range_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		can_interact = false
		SignalBus.emit_signal("change_interaction_UI", "Empty")
