class_name DiskMapTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_create_disk_map() -> void:
	var map := DiskMap.new()
	map.add_dense_line("1234")
	assert_int(map.size()).is_equal(4)

func test_expanded_format() -> void:
	var map := DiskMap.new()
	map.add_dense_line("12345")
	map.expand()
	assert_int(map.expanded_size()).is_equal(15)
	assert_str("".join(map.expanded_map)).is_equal("0..111....22222")

func test_defrag() -> void:
	var map := DiskMap.new()
	map.add_dense_line("12345")
	map.expand()
	map.defrag()
	assert_str("".join(map.expanded_map)).is_equal("022111222......")
	
func test_checksum_after_defrag() -> void:
	var map := DiskMap.new()
	map.add_dense_line("12345")
	map.expand()
	map.defrag()
	assert_int(map.checksum()).is_equal(60)

func test_expand_with_example() -> void:
	var map := DiskMap.new()
	map.add_dense_line("233313312")
	map.add_dense_line("1414131402")
	map.expand()
	assert_str("".join(map.expanded_map)).is_equal("00...111...2...333.44.5555.6666.777.888899")

func test_defrag_with_example() -> void:
	var map := DiskMap.new()
	map.add_dense_line("2333133121414131402")
	map.expand()
	map.defrag()
	assert_str("".join(map.expanded_map)).is_equal("0099811188827773336446555566..............")

func test_checksum_with_example() -> void:
	var map := DiskMap.new()
	map.add_dense_line("2333133121414131402")
	map.expand()
	map.defrag()
	assert_int(map.checksum()).is_equal(1928)
	
func test_compare_string_added_count_with_map_size() -> void:
	var map := DiskMap.new()
	map.add_dense_line("233313312")
	map.add_dense_line("1414131402")
	assert_int(map.string_count).is_equal(map.size())

func test_defrag_keeping_files_together_with_example() -> void:
	var map := DiskMap.new()
	map.add_dense_line("2333133121414131402")
	map.expand()
	map.defrag_keeping_files_together()
	assert_str("".join(map.expanded_map)).is_equal("00992111777.44.333....5555.6666.....8888..")
	assert_int(map.checksum()).is_equal(2858)
