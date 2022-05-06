extends KinematicBody2D

const WALK_SPEED = 200

var dead = false
var direction = Vector2()
var current_animation = "idle"

var can_drop_bomb = true
onready var tilemap = get_node("/root/Arena/TileMap")
onready var bomb_scene = preload("res://scenes/Bomb.tscn")


func _physics_process(delta):
	if dead:
		return
	
	if (Input.is_action_pressed("ui_up")):
		direction.y = -WALK_SPEED
	elif (Input.is_action_pressed("ui_down")):
		direction.y = WALK_SPEED
	else:
		direction.y = 0
	
	if (Input.is_action_pressed("ui_left")):
		direction.x = -WALK_SPEED
	elif (Input.is_action_pressed("ui_right")):
		direction.x = WALK_SPEED
	else:
		direction.x = 0
	
	move_and_slide(direction)
	rotation = atan2(direction.y, direction.x)
	var new_animation = "idle"
	if direction:
		new_animation = "walking"
	if new_animation != current_animation:
		$AnimationPlayer.play(new_animation)
		current_animation = new_animation

func _process(delta):
	if dead:
		return
	
	if Input.is_action_just_pressed("ui_select") and can_drop_bomb:
		dropbomb(tilemap.centered_world_pos(position))
		can_drop_bomb = false
		$DropBombCooldown.start()

sync func dropbomb(pos):
	var bomb = bomb_scene.instance()
	bomb.position = pos
	bomb.owner = self
	get_node("/root/Arean").add_child(bomb)


func _on_DropBombCooldown_timeout():
	can_drop_bomb = true

