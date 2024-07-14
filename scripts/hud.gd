extends CanvasLayer

@onready var coins_label = $CoinsLabel

func _ready():
	Game.coins_updated.connect(_on_coins_updated)
	_on_coins_updated(Game.total_coins)

func _on_coins_updated(total_coins):
	coins_label.text = "Coins: %s" % Game.total_coins
