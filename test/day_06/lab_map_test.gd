class_name LabMapTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_add_line() -> void:
	var map := LabMap.new()
	map.add("....#.....")
	assert_int(map.get_width()).is_equal(10)
	assert_int(map.get_height()).is_equal(1)

func test_setup_guard_up() -> void:
	var map := LabMap.new()
	map.add("....^.....")
	map.setup_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.UP)

func test_setup_guard_right() -> void:
	var map := LabMap.new()
	map.add("....>.....")
	map.setup_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.RIGHT)

func test_setup_guard_down() -> void:
	var map := LabMap.new()
	map.add("....v.....")
	map.setup_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.DOWN)

func test_setup_guard_left() -> void:
	var map := LabMap.new()
	map.add("....<.....")
	map.setup_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.LEFT)

func test_setup_guard_with_2_lines() -> void:
	var map := LabMap.new()
	map.add("..........")
	map.add("....^.....")
	map.setup_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 1))
	assert_vector(map.guard.dir).is_equal(Vector2i.UP)

func test_move_guard_no_obstacle() -> void:
	var map := LabMap.new()
	map.add("....<.....")
	map.setup_guard()
	map.move_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(3, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.LEFT)
	assert_str(map.get_pos(Vector2i(4, 0))).is_equal("X")

func test_inside_map_pos() -> void:
	var map := LabMap.new()
	map.add("....<.....")
	assert_bool(map.is_pos_inside_map(Vector2i(9, 0))).is_true()
	
func test_outside_map_pos() -> void:
	var map := LabMap.new()
	map.add("....<.....")
	assert_bool(map.is_pos_inside_map(Vector2i(10, 0))).is_false()
	assert_bool(map.is_pos_inside_map(Vector2i(-1, 0))).is_false()
	assert_bool(map.is_pos_inside_map(Vector2i(4, 1))).is_false()

func test_move_guard_with_obstacle() -> void:
	var map := LabMap.new()
	map.add("...#<.....")
	map.setup_guard()
	map.move_guard()
	assert_vector(map.guard.position).is_equal(Vector2i(4, 0))
	assert_vector(map.guard.dir).is_equal(Vector2i.UP)

func test_move_guard_outside() -> void:
	var map := LabMap.new()
	map.add("....^.....")
	map.setup_guard()
	map.move_guard()
	assert_bool(map.guard.left_map).is_true

func test_count_path_position() -> void:
	var map := LabMap.new()
	map.add("..........")
	map.add("....^.....")
	map.setup_guard()
	map.move_guard()
	map.move_guard()
	assert_int(map.count_path_positions()).is_equal(2)

func test_walk_guard_path() -> void:
	var map := LabMap.new()
	map.add("..........")
	map.add("...#<.....")
	map.setup_guard()
	map.do_walk_guard_path()
	assert_int(map.count_path_positions()).is_equal(2)

func test_walk_guard_with_example() -> void:
	var map = setup_example_map()
	map.setup_guard()
	map.do_walk_guard_path()
	assert_int(map.count_path_positions()).is_equal(41)

func test_walk_guard_and_mark_path() -> void:
	var map := LabMap.new()
	map.add("..........")
	map.add("..#.<.....")
	map.setup_guard()
	map.do_walk_guard_path_finding_loop()
	assert_str(map.get_pos(Vector2i(3, 1))).is_equal(map.guard.CROSS_CHAR)
	assert_str(map.get_pos(Vector2i(3, 0))).is_equal(map.guard.directions[Vector2i.UP].char)

func test_find_corner() -> void:
	var map := LabMap.new()
	map.add(".#+.....<.")
	map.setup_guard()
	assert_bool(map.guard.find_corner(map.guard.position, map.guard.dir, map)).is_true()

func test_walk_and_find_corner_to_the_right() -> void:
	var map := LabMap.new()
	map.add(".......#..")
	map.add(".......+..")
	map.add("........<.")
	map.setup_guard()
	map.move_guard()
	assert_bool(map.find_corner(map.guard.position, map.guard.rotate(), map)).is_true()

func test_find_obstacle_with_no_corner() -> void:
	var map := LabMap.new()
	map.add(".#......<.")
	map.setup_guard()
	assert_bool(map.guard.find_corner(map.guard.position, map.guard.dir, map)).is_false()

func test_find_obstructions_positions_with_example() -> void:
	var map := setup_example_map()
	map.setup_guard()
	map.do_walk_guard_path_finding_loop()
	assert_int(map.obstructions.size()).is_equal(6)

func test_marked_path_and_x_path_should_be_equal() -> void:
	var map = setup_example_map()
	map.setup_guard()
	map.do_walk_guard_path()
	var map_2 = setup_example_map()
	map_2.setup_guard()
	map_2.do_walk_guard_path_finding_loop()
	assert_int(map.count_path_positions()).is_equal(map_2.count_marked_path())

func test_find_loop_with_corner_never_collided_before() -> void:
	var map := LabMap.new()
	map.add(".#..#.....")
	map.add(".........#")
	map.add("....^.....")
	map.add("..........")
	map.add("........#.")
	map.setup_guard()
	map.do_walk_guard_path_finding_loop()
	assert_int(map.obstructions.size()).is_equal(2)

func test_avoid_infinite_recursion() -> void:
	var map := LabMap.new()
	map.add("....#.....")
	map.add(".#.......#")
	map.add("....^.#...")
	map.add("..........")
	map.add("#.......#.")
	map.add(".....#....")
	map.setup_guard()
	map.do_walk_guard_path_finding_loop()
	assert_int(map.obstructions.size()).is_equal(4)

func setup_example_map() -> LabMap:
	var map := LabMap.new()
	map.add("....#.....")
	map.add(".........#")
	map.add("..........")
	map.add("..#.......")
	map.add(".......#..")
	map.add("..........")
	map.add(".#..^.....")
	map.add("........#.")
	map.add("#.........")
	map.add("......#...")
	return map
