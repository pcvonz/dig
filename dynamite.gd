
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var fuse_length
var time_elapsed = 0

#bombs
var bomb_size = 20
var bomb_queue = []
var L
var T
var bomb_list
#Explosions
func _process(delta):
	print("fuse", fuse_length)
	if(time_elapsed > fuse_length):
		explosion()
	if(time_elapsed > fuse_length + 1):
		end_explosion()
	time_elapsed += delta

func explosion():
	add_child(bomb_list[rand_range(0,1)])

func end_explosion():
	
	queue_free()

func _ready():
	L = preload("res://L_explosion.scn").instance()
	T = preload("res://L_explosion.scn").instance()
	bomb_list = [L, T]
	set_process(true)
	


