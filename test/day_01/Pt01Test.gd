# GdUnit generated TestSuite
class_name Pt01Test
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://day_01/pt_01.gd'


func test_calc_distances_with_example_input_sorting_later() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	pt_01.first_col = [3, 4, 2, 1, 3, 3]
	pt_01.second_col = [4, 3, 5, 3, 9, 3]
	pt_01.first_col.sort()
	pt_01.second_col.sort()
	
	assert_int(pt_01.calc_distances()).is_equal(11)

func test_calc_distances_with_example_input_adding_sorted() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	for i in [3, 4, 2, 1, 3, 3]:
		pt_01.add_to_col_sorted(pt_01.first_col, i)
	for i in [4, 3, 5, 3, 9, 3]:
		pt_01.add_to_col_sorted(pt_01.second_col, i)
	assert_int(pt_01.calc_distances()).is_equal(11)

func test_zero_distance_input_with_sequencial_numbers() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	for i in [1, 2, 3, 4, 5]:
		pt_01.add_to_col_sorted(pt_01.first_col, i)
		pt_01.add_to_col_sorted(pt_01.second_col, i)
	assert_int(pt_01.calc_distances()).is_equal(0)
	
func test_zero_distance_input_with_sequencial_invert_numbers() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	for i in [5, 4, 3, 2, 1]:
		pt_01.add_to_col_sorted(pt_01.first_col, i)
		pt_01.add_to_col_sorted(pt_01.second_col, i)
	assert_int(pt_01.calc_distances()).is_equal(0)

func test_zero_distance_input_with_asc_against_desc() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	for i in [5, 4, 3, 2, 1]:
		pt_01.add_to_col_sorted(pt_01.first_col, i)
	for i in [1, 2, 3, 4, 5]:
		pt_01.add_to_col_sorted(pt_01.second_col, i)
	assert_int(pt_01.calc_distances()).is_equal(0)

func test_zero_distance_input_with_equal_numbers() -> void:
	var pt_01 := auto_free(Day01Pt01.new()) as Day01Pt01
	for i in [1, 1, 1, 1, 1]:
		pt_01.add_to_col_sorted(pt_01.first_col, i)
		pt_01.add_to_col_sorted(pt_01.second_col, i)
	assert_int(pt_01.calc_distances()).is_equal(0)
