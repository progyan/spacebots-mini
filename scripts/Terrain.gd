extends StaticBody2D

func _ready():
	var list = []
	for i in range(100):
		list.append(randi() % 300)
	set_terrain(list)

func set_terrain(terrain):
	var polygon = PoolVector2Array([Vector2(1000, 1000), Vector2(0, 1000)])
	for i in range(len(terrain)):
		polygon.append(Vector2(i * 10, terrain[i]))
	$Polygon2D.polygon = polygon
	$CollisionShape2D.shape.segments = polygon
