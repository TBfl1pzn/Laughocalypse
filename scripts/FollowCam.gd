extends Camera2D

@export var tilemap: TileMap

func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPx = mapRect.size * tileSize
	limit_right = worldSizeInPx.x
	limit_bottom = worldSizeInPx.y
