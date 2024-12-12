class_name PagesUpdateTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_create_update() -> void:
	var update := PagesUpdate.new([75, 47, 61, 53, 29])
	assert_int(update.size()).is_equal(5)

func test_get_middle_page() -> void:
	var update := PagesUpdate.new([75, 47, 61, 53, 29])
	assert_int(update.get_middle_page()).is_equal(61)

func test_correct_ordered_update() -> void:
	var update := PagesUpdate.new([75, 47, 61, 53, 29])
	var rules := UpdateRules.new()
	rules.add(75, 47)
	assert_bool(update.is_ordered(rules)).is_true()

func test_incorrect_ordered_update() -> void:
	var update := PagesUpdate.new([75, 47, 61, 53, 29])
	var rules := UpdateRules.new()
	rules.add(47, 75)
	assert_bool(update.is_ordered(rules)).is_false()
