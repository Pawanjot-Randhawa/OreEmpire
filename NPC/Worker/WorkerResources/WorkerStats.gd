extends Resource
class_name WorkerStats

@export var head : styles
@export var body : styles
@export var legs : styles
@export var feet : styles
@export var mine_timer : float

func _init() -> void:
	head = styles.Farmer
	body = styles.Farmer
	legs = styles.Farmer
	feet = styles.Farmer

enum styles {
	Swat,
	Adventurer,
	Farmer,
	Worker,
	Punk,
	SpaceSuit,
	King,
	Beach,
	Casual2,
	Casual,
	Suit
}
