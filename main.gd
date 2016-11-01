extends Node2D

var level_size = 1000
var level_width = 950
#terrain
var dirt
var treasure
var rock
var screen_size
var terrain = []
var dirt_2
var dirt_4
var dirt_3
var x_offset = 128
var y_offset = 128
var treasure_count = 0
var game_end
func _ready():
	#terrain
	dirt = preload("res://dirt.scn").instance()
	treasure = preload("res://treasure.scn").instance()
	dirt_2 = preload("res://dirt_2.scn").instance()
	dirt_3 = preload("res://dirt_3.scn").instance()
	dirt_4 = preload("res://dirt_4.scn").instance()
	screen_size = OS.get_window_size()
	terrain.append(dirt)
	terrain.append(dirt_2)
	terrain.append(dirt_3)
	terrain.append(dirt_4)
	terrain.append(treasure)
	generate_terrain()
	var wall_2 = get_node("Wall_2")
	wall_2.set_global_pos(Vector2(screen_size.x-700, wall_2.get_global_pos().y))
	set_process(true)
	game_end = get_parent().get_parent().get_parent().get_node("game_end")
	game_end.set_percent_visible(0)
	get_parent().set_transparent_background(true)

func _process(delta):
	print(treasure_count)
	print(get_node("character_1").treasure + get_node("character_2").treasure)
	if((get_node("character_1").treasure + get_node("character_2").treasure) <= treasure_count):
		if(get_node("character_1").treasure > get_node("character_2").treasure):
			game_end.set_text("Player one wins!")
		else:
			game_end.set_text("Player two wins!")
		game_end.set_percent_visible(100.0)
	if(get_node("character_1").bomb_count + get_node("character_2").bomb_count == 0):
		treasure_count = 0
	else:
		game_end.set_percent_visible(0)

	
func generate_terrain():
	var node
	
	for i in range(0, level_size):
		randomize()
		node = terrain[rand_range(0,5)].duplicate()
		if node.get_name() == "treasure":
			treasure_count += 1
		node.translate(Vector2(x_offset, y_offset))
		add_child(node)
		x_offset += 64
		if(x_offset > (level_width)):
			x_offset = 128
			y_offset += 64
	get_node("floor").set_global_pos(Vector2(get_node("floor").get_global_pos().x, y_offset-128))




