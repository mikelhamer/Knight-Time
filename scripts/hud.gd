extends CanvasLayer

@onready var coins_label = $CoinsLabel

func _ready():
	visible = true

func update_coins_label(coins):
	coins_label.text = "Coins: %s" % coins
