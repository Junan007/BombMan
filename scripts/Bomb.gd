extends StaticBody2D


const EXPLOSION_RADIUS = 2
onready var explosion_scene = preload("res://scenes/Explosion.tscn")
onready var tilemap = get_node("/root/Area/TileMap")
onready var tile_solid_id = tilemap.tile_set.find_tile_by_name("SolidBrick")


func propagate_explosion(centerpos, propagation):
	for i in range(1, EXPLOSION_RADIUS + 1):
		var tilepos = centerpos + propagation * i
		if tilemap.get_cellv(tilepos) != tile_solid_id:
			var explosion = explosion_scene.instance()
			explosion.position = tilemap.center_world_pos_from_tilepos(tilepos)
			get_parent().add_child(explosion)
		else:
			break
			

func _on_AnimationPlayer_animation_finished(anim_name):
	propagate_explosion(position, Vector2(0, 1))
	propagate_explosion(position, Vector2(0, -1))
	propagate_explosion(position, Vector2(1, 0))
	propagate_explosion(position, Vector2(-1, 0))
	
