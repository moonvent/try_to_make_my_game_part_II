extends Node


class_name Spawner


var window_size := DisplayServer.window_get_size()
var window_size_half_for_spawn_enemies: Vector2

# @onready var first_level_handler: FirstLevelHandler = %FirstLevelHandler
# @onready var Stages := FirstLevelHandler.Stages


var available_sides: Array

# dict with key - stage, value - handler of this stage
var stage_handler: Dictionary

var spawn_position: Vector2
var spawn_side: int

var enemy: Enemy

var player: Player
var range_between_border_and_invisible_spawn_point: int
var left_top_point_of_camera_view: Vector2
var right_bottom_point_of_camera_view: Vector2
var space_field: SpaceField


func init():
	$SpawnEnemyTimer.timeout.connect(create_new_enemy)

	stage_handler = {
		Constant.Stages.First: create_first_stage_enemy,
		# Constant.Second: create_second_stage_enemy,
		# Constant.Third: create_third_stage_enemy,
		# Constant.Stages.Fourth: create_fourth_stage_enemy,
	}

	available_sides = Array()

	for side in Constant.SpawnSide:
		available_sides.append(Constant.SpawnSide[side])

	player = get_node("../Player")
	space_field = get_node('..')
	get_start_and_end_of_camera()


func get_start_and_end_of_camera():
	var camera = get_viewport().get_camera_2d()
	var primary_size = camera.get_viewport().size
	var zoom = camera.zoom[0]
	var custom_size = primary_size * pow(zoom, -1)
	left_top_point_of_camera_view = Vector2(primary_size) - custom_size
	right_bottom_point_of_camera_view = custom_size
	

func _ready():
	randomize()
	init()


func create_new_enemy():
	get_spawn_coords()
	stage_handler[space_field.current_stage].call()


func create_first_stage_enemy():
	enemy = SceneLoader.Enemy1Scene.instantiate()
	enemy.position = spawn_position
	enemy.init(player)
	add_child(enemy)


# func create_second_stage_enemy():
# 	enemy = GlobalResourceLoader.SecondStageEnemy.instantiate()
# 	enemy.position = spawn_position
# 	add_child(enemy)
#
#
# func create_third_stage_enemy():
# 	enemy = GlobalResourceLoader.ThirdStageEnemy.instantiate()
# 	enemy.position = spawn_position
# 	add_child(enemy)
#
#
# func create_fourth_stage_enemy():
# 	enemy = GlobalResourceLoader.FourthStageEnemy.instantiate()
# 	enemy.position = spawn_position
# 	add_child(enemy)
# 	$SpawnEnemyTimer.stop()


func get_spawn_coords():
	spawn_position = Vector2()

	spawn_side = available_sides[randi() % available_sides.size()]

	var random_x_pos = randi_range(left_top_point_of_camera_view.x, right_bottom_point_of_camera_view.x)	
	var random_y_pos = randi_range(left_top_point_of_camera_view.y, right_bottom_point_of_camera_view.y)	

	match spawn_side:
		Constant.SpawnSide.Up:
			spawn_position.x = random_x_pos
			spawn_position.y = left_top_point_of_camera_view.y - range_between_border_and_invisible_spawn_point
		Constant.SpawnSide.Down:  
			spawn_position.x = random_x_pos
			spawn_position.y = right_bottom_point_of_camera_view.y + range_between_border_and_invisible_spawn_point
		Constant.SpawnSide.Left:  
			spawn_position.x = left_top_point_of_camera_view.x - range_between_border_and_invisible_spawn_point
			spawn_position.y = random_y_pos
		Constant.SpawnSide.Right:  
			spawn_position.x = right_bottom_point_of_camera_view.x + range_between_border_and_invisible_spawn_point
			spawn_position.y = random_y_pos
