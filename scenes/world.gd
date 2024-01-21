extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/player

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
