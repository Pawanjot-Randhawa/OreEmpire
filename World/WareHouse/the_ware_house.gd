extends Node3D

const MANAGER_ROOM = preload("uid://dqnr5gkp3s550")

@onready var slot_m1: Node3D = $SlotM1
@onready var slot_m2: Node3D = $SlotM2
@onready var slot_m3: Node3D = $SlotM3
@onready var slot_m4: Node3D = $SlotM4

@onready var slot_w1: Marker3D = $SlotW1
@onready var slot_w2: Marker3D = $SlotW2
@onready var slot_w3: Marker3D = $SlotW3
@onready var slot_w4: Marker3D = $SlotW4
@onready var slot_w5: Marker3D = $SlotW5
@onready var slot_w6: Marker3D = $SlotW6
@onready var slot_w7: Marker3D = $SlotW7
@onready var slot_w8: Marker3D = $SlotW8
@onready var slot_w9: Marker3D = $SlotW9
@onready var slot_w10: Marker3D = $SlotW10
@onready var slot_w11: Marker3D = $SlotW11
@onready var slot_w12: Marker3D = $SlotW12
@onready var slot_w13: Marker3D = $SlotW13
@onready var slot_w14: Marker3D = $SlotW14
@onready var slot_w15: Marker3D = $SlotW15
@onready var slot_w16: Marker3D = $SlotW16

const SECOND = preload("uid://coq85v41f2s4t")
const TESTING = preload("uid://c88vg0fdva42s")


const WORKER = preload("uid://banc4kc8yiesu")
var toggleStyle = true
var worker : Worker


@onready var slots : Dictionary = {
	"M1": slot_m1,
	"M2": slot_m2,
	"M3": slot_m3,
	"M4" : slot_m4,
}

@onready var WorkerSlots : Dictionary = {
	0: slot_w1,
	1: slot_w2,
	2: slot_w3,
	3: slot_w4,
	4: slot_w5,
	5: slot_w6,
	6: slot_w7,
	7: slot_w8,
	8: slot_w9,
	9: slot_w10,
	10: slot_w11,
	11: slot_w12,
	12: slot_w13,
	13: slot_w14,
	14: slot_w15,
	15: slot_w16
}

func _ready() -> void:
	SignalBus.connect("warehouse_upgrade_bought", warehouse_upgrade)
	SignalBus.connect("bought_worker", new_worker)

func warehouse_upgrade(upgrade : Array):
	#Incoming array has slot at index 0, upgrade at index 1
	var slot : String = upgrade[0]
	match upgrade[1]:
		"ManagerOffice":
			slots[slot].get_child(0).queue_free()
			slots[slot].add_child(MANAGER_ROOM.instantiate())
		_: #base case
			print("No Match")
func new_worker(slot : int):
	worker = WORKER.instantiate()
	worker.stats = TESTING if toggleStyle else SECOND
	toggleStyle = !toggleStyle
	WorkerSlots[slot].add_child(worker)
