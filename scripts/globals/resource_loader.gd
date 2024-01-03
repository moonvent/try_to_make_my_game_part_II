extends Node


const BulletScene: PackedScene = preload("res://scenes/level_1/bullet.tscn")

const PlayerGunScene: PackedScene = preload("res://scenes/level_1/player_gun.tscn")

const FirstStageEnemy: PackedScene = preload("res://scenes/level_1/first_stage_enemy.tscn")
const FirstStageEnemyGun: PackedScene = preload("res://scenes/level_1/first_stage_enemy_gun.tscn")

const SecondStageEnemy: PackedScene = preload("res://scenes/level_1/second_stage_enemy.tscn")
const SecondStageEnemyGun: PackedScene = preload("res://scenes/level_1/second_stage_enemy_gun.tscn")

const ThirdStageEnemy: PackedScene = preload("res://scenes/level_1/third_stage_enemy.tscn")
const ThirdStageEnemyGun: PackedScene = preload("res://scenes/level_1/third_stage_enemy_gun.tscn")

const FourthStageEnemy: PackedScene = preload("res://scenes/level_1/fourth_stage_enemy.tscn")
const FourthStageEnemyGun: PackedScene = preload("res://scenes/level_1/fourth_stage_enemy_gun.tscn")


const GameOverScene: PackedScene = preload("res://scenes/menu/game_over.tscn")
