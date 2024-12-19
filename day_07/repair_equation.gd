class_name RepairEquation
extends RefCounted

var test_value: int
var operands: Array[int] = []

func _init(equation: String) -> void:
	_create_from_string(equation)

func is_valid() -> bool:
	return test_value in combine_operators()

func combine_operators(operands: Array[int] = self.operands) -> Array[int]:
	var result: Array[int] = []
	if operands.size() == 2:
		result.append(operands[0] + operands[1])
		result.append(operands[0] * operands[1])
		result.append(int(str(operands[0]) + str(operands[1])))
	else:
		for value in combine_operators(operands.slice(0, operands.size()-1)):
			var op := operands[operands.size()-1]
			result.append(value + op)
			result.append(value * op)
			result.append(int(str(value) + str(op)))
	return result

func _create_from_string(equation: String) -> void:
	var regex = RegEx.new()
	regex.compile(r'(^\d+): (.*)')
	var result := regex.search(equation)
	test_value = int(result.get_string(1))
	var string_array := result.get_string(2).split(" ")
	for s in string_array:
		operands.append(int(s))
