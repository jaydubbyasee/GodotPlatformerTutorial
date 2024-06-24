extends Control

@export var player: PlayerCharacter


func _ready():
	player.coins_update.connect(_update_label)
	_update_label(0)


func _update_label(coins_count: int):
	$Label.text = "Coins: %d" % coins_count
