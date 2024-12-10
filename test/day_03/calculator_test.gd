class_name CalculatorTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_find_expressions_with_example_string() -> void:
	var string := "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
	var calculator := Calculator.new()
	var operation_list := calculator.find_expressions(string)
	assert_str(operation_list[0].get_string()).is_equal("mul(2,4)")
	assert_str(operation_list[1].get_string()).is_equal("mul(5,5)")
	assert_str(operation_list[2].get_string()).is_equal("mul(11,8)")
	assert_str(operation_list[3].get_string()).is_equal("mul(8,5)")

func test_evaluate_operations_with_example_string() -> void:
	var string := "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
	var calculator := Calculator.new()
	var operation_list := calculator.find_expressions(string)
	assert_int(calculator.evaluate_operations(operation_list)).is_equal(161)
