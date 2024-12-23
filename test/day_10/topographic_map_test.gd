class_name TopographicMapTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_create_map_and_add_one_line() -> void:
	var map := TopographicMap.new()
	map.add_line("0123")
	assert_int(map.get_width()).is_equal(4)
	assert_int(map.get_height()).is_equal(1)

func test_map_with_one_trail() -> void:
	var map := TopographicMap.new()
	map.add_line("0123")
	map.add_line("1234")
	map.add_line("8765")
	map.add_line("9876")
	assert_int(map.get_width()).is_equal(4)
	assert_int(map.get_height()).is_equal(4)
	assert_int(map.count_all_trails()).is_equal(1)

func test_example() -> void:
	var map := setup_example()
	assert_int(map.count_all_trails()).is_equal(36)

func setup_example() -> TopographicMap:
	var map := TopographicMap.new()
	map.add_line("89010123")
	map.add_line("78121874")
	map.add_line("87430965")
	map.add_line("96549874")
	map.add_line("45678903")
	map.add_line("32019012")
	map.add_line("01329801")
	map.add_line("10456732")
	return map
