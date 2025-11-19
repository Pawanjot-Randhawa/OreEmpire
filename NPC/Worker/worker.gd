extends CharacterBody3D
class_name Worker
#Adding class name help the autocomplete

@onready var animation_player: AnimationPlayer = $Humans_Master/AnimationPlayer
@onready var mining_timer: Timer = $MiningTimer

@onready var skeleton_3d: Skeleton3D = $Humans_Master/CharacterArmature/Skeleton3D


var styles : Dictionary = {
	0: "Swat",
	1: "Adventurer",
	2: "Farmer",
	3: "Worker",
	4: "Punk",
	5: "SpaceSuit",
	6: "King",
	7: "Beach",
	8: "Casual2",
	9: "Casual",
	10: "Suit"
}

@export var head = 10
@export var body = 10
@export var legs = 10
@export var feet = 10
@export var stats : WorkerStats

func _ready() -> void:
	mining_timer.wait_time = stats.mine_timer
	setup_character_model2()

func setup_character_model():
	var headPath = str(skeleton_3d.get_path()) + "/" + styles[head] + "_Head"
	var bodyPath = str(skeleton_3d.get_path()) + "/" + styles[body] + "_Body"
	var legsPath = str(skeleton_3d.get_path()) + "/" + styles[legs] + "_Legs"
	var feetPath = str(skeleton_3d.get_path()) + "/" + styles[feet] + "_Feet"
	var thing :MeshInstance3D = get_node(bodyPath)
	thing.visible = true
	get_node(headPath).visible = true
	get_node(legsPath).visible = true
	get_node(feetPath).visible = true


func setup_character_model2():
	print(str(stats.head))
	var headPath = str(skeleton_3d.get_path()) + "/" + styles[stats.head] + "_Head"
	var bodyPath = str(skeleton_3d.get_path()) + "/" + styles[stats.body] + "_Body"
	var legsPath = str(skeleton_3d.get_path()) + "/" + styles[stats.legs] + "_Legs"
	var feetPath = str(skeleton_3d.get_path()) + "/" + styles[stats.feet] + "_Feet"
	var thing :MeshInstance3D = get_node(bodyPath)
	thing.visible = true
	get_node(headPath).visible = true
	get_node(legsPath).visible = true
	get_node(feetPath).visible = true

func mine():
	pass

#When have time trigger this from animation player to make it look good
func add_money():
	Global.money += 10

func _on_mining_timer_timeout() -> void:
	animation_player.play("CharacterArmature|Sword_Slash")
	await animation_player.animation_finished
	add_money()
	animation_player.play("CharacterArmature|Idle_Sword")
