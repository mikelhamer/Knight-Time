extends CanvasLayer

@onready var coins_label = $CoinsLabel

func _ready():
	Game.coins_updated.connect(_on_coins_updated)

func _on_coins_updated(total_coins):
	coins_label.text = "Coins: %s" % total_coins
