class_name RepairEquationTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_create_repair_equation() -> void:
	var eq := RepairEquation.new("190: 10 19")
	assert_int(eq.test_value).is_equal(190)
	assert_int(eq.operands.size()).is_equal(2)

func test_combine_operators_with_2_operands() -> void:
	var eq := RepairEquation.new("83: 17 5")
	var results: Array[int] = eq.combine_operators()
	assert_bool(results.count(85) > 0).is_true()
	assert_bool(results.count(22) > 0).is_true()

func test_combine_operators_with_3_operands() -> void:
	var eq := RepairEquation.new("9: 1 2 3")
	var results: Array[int] = eq.combine_operators()
	assert_bool(results.count(6) == 2).is_true()
	assert_bool(results.count(9) == 1).is_true()
	assert_bool(results.count(5) == 1).is_true()

func test_is_valid_equation() -> void:
	var eq := RepairEquation.new("9: 1 2 3")
	assert_bool(eq.is_valid()).is_true()

func test_total_calibration_result_with_example() -> void:
	var eq_list := get_equations_from_example()
	var sum := 0
	for eq in eq_list:
		if eq.is_valid():
			sum += eq.test_value
	assert_int(sum).is_equal(3749)

func get_equations_from_example() -> Array[RepairEquation]:
	var eq_list: Array[RepairEquation] = []
	eq_list.append(RepairEquation.new("190: 10 19"))
	eq_list.append(RepairEquation.new("3267: 81 40 27"))
	eq_list.append(RepairEquation.new("83: 17 5"))
	eq_list.append(RepairEquation.new("156: 15 6"))
	eq_list.append(RepairEquation.new("7290: 6 8 6 15"))
	eq_list.append(RepairEquation.new("161011: 16 10 13"))
	eq_list.append(RepairEquation.new("192: 17 8 14"))
	eq_list.append(RepairEquation.new("21037: 9 7 18 13"))
	eq_list.append(RepairEquation.new("292: 11 6 16 20"))
	return eq_list
