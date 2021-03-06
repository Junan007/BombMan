extends Sprite

onready var tilemap : TileMap  = get_node("/root/Area/TileMap")
onready var animation = get_node("AnimationPlayer")

func _ready():
	var tile_pos = tilemap.world_to_map(position)
	var tile_background_id = tilemap.tile_set.find_tile_by_name("BackgroundBrick")
	tilemap.set_cellv(tile_pos, tile_background_id)
	
	for player in get_tree().get_nodes_in_group('players'):
		var playerpos = tilemap.world_to_map(player.position)
		if playerpos == tile_pos:
			player.damage()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
