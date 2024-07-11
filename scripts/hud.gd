extends CanvasLayer

@onready var coins_label = $CoinsLabel

func _ready():
	visible = true
	update_coins_label()

func update_coins_label():
	coins_label.text = "Coins: %s" % State.total_coins
