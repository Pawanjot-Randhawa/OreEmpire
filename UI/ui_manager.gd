extends Control

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var money_label: Label = $MarginContainer2/money_label
@onready var buy_menu: MarginContainer = $BuyMenu
@onready var limit_label: Label = $BuyMenu/VBoxContainer/limitLabel

var buyMenuVisible: bool = false
var workerCount: int = 0
var icons : Dictionary = {
	"Mine":"uid://g2xjy64txt27",
	"Door":"uid://b1ogdqhj052uf",
	"Empty":"uid://b08v0lng1pxml"
}

func _ready() -> void:
	buy_menu.visible = false
	SignalBus.connect("change_interaction_UI", update_interaction)
	Global.connect("money_changed", update_money)


func _process(_delta: float) -> void:
	#case for pause menu
	if Input.is_action_just_pressed("pause") || (Input.is_action_just_pressed("left_click") and not Global.has_focus and not buyMenuVisible):
		Global.has_focus = !Global.has_focus
		change_mouse_mode()
	#case for buyu menu
	if Input.is_action_just_pressed("buy_menu"):
		buyMenuVisible = !buyMenuVisible
		buy_menu.visible = buyMenuVisible
		Global.has_focus = !buyMenuVisible #remove player movement if buy menu is on
		change_mouse_mode()

func change_mouse_mode():
	if Global.has_focus: 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func update_interaction(action : String):
	texture_rect.texture = load(icons[action])

func update_money(value : int):
	money_label.text = "$" + str(value)


func _on_slot_m_3_pressed() -> void:
	if Global.money >= 600:
		SignalBus.emit_signal("warehouse_upgrade_bought", ["M3", "ManagerOffice"])
		Global.money -= 600
		%SlotM3.modulate = Color(0.0, 0.796, 0.0, 1.0)
		%SlotM3.disabled = true

func _on_slot_m_2_pressed() -> void:
	if Global.money >= 400:
		SignalBus.emit_signal("warehouse_upgrade_bought", ["M2", "ManagerOffice"])
		Global.money -= 400
		%SlotM2.modulate = Color(0.0, 0.796, 0.0, 1.0)
		%SlotM2.disabled = true

func _on_slot_m_1_pressed() -> void:
	if Global.money >= 200:
		SignalBus.emit_signal("warehouse_upgrade_bought", ["M1", "ManagerOffice"])
		Global.money -= 200
		%SlotM1.modulate = Color(0.0, 0.796, 0.0, 1.0)
		%SlotM1.disabled = true
		

func _on_slot_m_4_pressed() -> void:
	if Global.money >= 800:
		SignalBus.emit_signal("warehouse_upgrade_bought", ["M4", "ManagerOffice"])
		Global.money -= 800
		%SlotM4.modulate = Color(0.0, 0.796, 0.0, 1.0)
		%SlotM4.disabled = true


func _on_worker_button_pressed() -> void:
	if Global.money >= 150 and workerCount != 16:
		SignalBus.emit_signal("bought_worker", workerCount)
		workerCount += 1
		Global.money -= 150
		limit_label.text = "Workers: " + str(workerCount) + "/16"
	
