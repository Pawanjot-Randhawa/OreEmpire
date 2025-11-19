extends StaticBody3D

var can_interact: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		Global.money += 10

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		can_interact = true
		SignalBus.emit_signal("change_interaction_UI", "Mine")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		can_interact = false
		SignalBus.emit_signal("change_interaction_UI", "Empty")
