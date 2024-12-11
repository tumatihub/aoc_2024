class_name XmasMatrixTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_add_line_from_string() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MMMSXXMASM")
	assert_int(matrix.get_height()).is_equal(1)
	assert_int(matrix.get_width()).is_equal(10)
	assert_str(matrix.get_pos(0, 4)).is_equal("X")

func test_add_2_lines_from_string() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MMMSXXMASM")
	matrix.add_line("MMMSXXMASM")
	assert_int(matrix.get_height()).is_equal(2)
	assert_int(matrix.get_width()).is_equal(10)
	assert_str(matrix.get_pos(1, 2)).is_equal("M")

func test_if_valid_position() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MMMSXXMASM")
	assert_bool(matrix.is_valid_pos(-1, -1)).is_false()
	assert_bool(matrix.is_valid_pos(0, 10)).is_false()
	assert_bool(matrix.is_valid_pos(0, 9)).is_true()

func test_find_right_xmas() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MMMSXXMASM")
	assert_int(matrix.count_xmas()).is_equal(1)

func test_find_left_xmas() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MSAMXMSMSA")
	assert_int(matrix.count_xmas()).is_equal(1)
	
func test_find_xmas_with_example() -> void:
	var matrix := XmasMatrix.new()
	matrix.add_line("MMMSXXMASM")
	matrix.add_line("MSAMXMSMSA")
	matrix.add_line("AMXSXMAAMM")
	matrix.add_line("MSAMASMSMX")
	matrix.add_line("XMASAMXAMM")
	matrix.add_line("XXAMMXXAMA")
	matrix.add_line("SMSMSASXSS")
	matrix.add_line("SAXAMASAAA")
	matrix.add_line("MAMMMXMMMM")
	matrix.add_line("MXMXAXMASX")
	assert_int(matrix.count_xmas()).is_equal(18)
