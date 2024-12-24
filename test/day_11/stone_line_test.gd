class_name StoneLineTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_create_stone_line() -> void:
	var stone_line := StoneLine.new("0 1 10 99 999")
	assert_int(stone_line.size()).is_equal(5)

func test_one_blink_example() -> void:
	var stone_line := StoneLine.new("0 1 10 99 999")
	stone_line.blink()
	assert_int(stone_line.size()).is_equal(7)
	assert_array(stone_line.stones).is_equal(StoneLine.new("1 2024 1 0 9 9 2021976").stones)

func test_blink_n_times_with_example() -> void:
	var stone_line := StoneLine.new("125 17")
	stone_line.blink_n_times(6)
	assert_int(stone_line.size()).is_equal(22)
	assert_array(stone_line.stones).is_equal(StoneLine.new("2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2").stones)
