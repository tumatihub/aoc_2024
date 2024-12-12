class_name UpdateRulesTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_add_rule() -> void:
	var rules := UpdateRules.new()
	rules.add(47, 53)
	assert_int(rules.size()).is_equal(1)

func test_add_one_rule_and_verify_dependency() -> void:
	var rules := UpdateRules.new()
	rules.add(47, 53)
	assert_bool(rules.has_dependency(47, 53)).is_true()
	
func test_add_two_rules_and_verify_dependency() -> void:
	var rules := UpdateRules.new()
	rules.add(47, 53)
	rules.add(47, 52)
	assert_bool(rules.has_dependency(47, 53)).is_true()

func test_get_subset_rules() -> void:
	var update := PagesUpdate.new([75, 47, 61, 53, 29])
	var rules := UpdateRules.new()
	rules.add(47, 75)
	rules.add(61, 23)
	assert_int(rules.get_subset_from_pages(update.get_pages()).size()).is_equal(1)
