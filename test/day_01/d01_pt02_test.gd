class_name D01Pt02Test
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://day_01/d01_pt01.gd'

func test_similarity_score_with_example_input() -> void:
	var d01_pt02 := auto_free(D01Pt02.new()) as D01Pt02
	d01_pt02.first_col = [3, 4, 2, 1, 3, 3]
	d01_pt02.second_col = [4, 3, 5, 3, 9, 3]
	assert_int(d01_pt02.similarity_score()).is_equal(31)

func test_zero_similarity_score() -> void:
	var d01_pt02 := auto_free(D01Pt02.new()) as D01Pt02
	d01_pt02.first_col = [3, 3, 3, 3, 3, 3]
	d01_pt02.second_col = [4, 4, 4, 4, 4, 4]
	assert_int(d01_pt02.similarity_score()).is_equal(0)

func test_all_equal_similarity_score() -> void:
	var d01_pt02 := auto_free(D01Pt02.new()) as D01Pt02
	d01_pt02.first_col = [3, 3, 3, 3, 3, 3]
	d01_pt02.second_col = [3, 3, 3, 3, 3, 3]
	assert_int(d01_pt02.similarity_score()).is_equal(108)
