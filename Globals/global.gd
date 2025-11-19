extends Node

signal money_changed(value)

var money : int = 0:
	set(value):
		money = value
		money_changed.emit(money)

#change this later when we are making main menu, this allows player to move
var has_focus : bool = true
