class_name Calculator
extends RefCounted

func find_expressions(string: String) -> Array[RegExMatch]:
	var offset := 0
	var end := 0
	var operation_list: Array[RegExMatch]
	var regex := RegEx.new()
	regex.compile(r'(mul)\((\d{1,3}),(\d{1,3})\)')
	var do_regex := RegEx.new()
	do_regex.compile(r'do\(\)')
	var dont_regex := RegEx.new()
	dont_regex.compile(r'don\'t\(\)')
	while offset < string.length():
		var result := dont_regex.search(string, offset)
		if !result:
			end = string.length()
		else:
			end = result.get_end()
		var operations := regex.search_all(string, offset, end)
		operation_list.append_array(operations)
		offset = end
		result = do_regex.search(string, offset)
		if !result:
			offset = string.length()
		else:
			offset = result.get_end()
	return operation_list
	
func evaluate_operations(operation_list: Array[RegExMatch]) -> int:
	var result := 0
	for operation in operation_list:
		result += int(operation.get_string(2)) * int(operation.get_string(3))
	return result
