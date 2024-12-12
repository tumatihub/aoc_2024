class_name PagesUpdateListTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_add_middle_pages_from_correct_updates_with_example() -> void:
	var rules := setup_example_rules()
	var updates := setup_example_updates()
	var correct_updates := updates.get_correct_ordered_updates(rules)
	assert_int(correct_updates.sum_all_middle_page()).is_equal(143)
	assert_int(correct_updates.size()).is_equal(3)

func setup_example_rules() -> UpdateRules:
	var rules := UpdateRules.new()
	rules.add(47,53)
	rules.add(97,13)
	rules.add(97,61)
	rules.add(97,47)
	rules.add(75,29)
	rules.add(61,13)
	rules.add(75,53)
	rules.add(29,13)
	rules.add(97,29)
	rules.add(53,29)
	rules.add(61,53)
	rules.add(97,53)
	rules.add(61,29)
	rules.add(47,13)
	rules.add(75,47)
	rules.add(97,75)
	rules.add(47,61)
	rules.add(75,61)
	rules.add(47,29)
	rules.add(75,13)
	rules.add(53,13)
	return rules

func setup_example_updates() -> PagesUpdateList:
	var updates := PagesUpdateList.new()
	updates.add(PagesUpdate.new([75,47,61,53,29]))
	updates.add(PagesUpdate.new([97,61,53,29,13]))
	updates.add(PagesUpdate.new([75,29,13]))
	updates.add(PagesUpdate.new([75,97,47,61,53]))
	updates.add(PagesUpdate.new([61,13,29]))
	updates.add(PagesUpdate.new([97,13,75,29,47]))
	return updates
