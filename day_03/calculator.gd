class_name Calculator
extends RefCounted

func find_expressions(string: String) -> Array[RegExMatch]:
	var regex := RegEx.new()
	regex.compile(r'(mul)\((\d{1,3}),(\d{1,3})\)')
	return regex.search_all(string)
	
func evaluate_operations(operation_list: Array[RegExMatch]) -> int:
	var result := 0
	for operation in operation_list:
		result += int(operation.get_string(2)) * int(operation.get_string(3))
	return result
