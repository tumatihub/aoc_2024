class_name Report
extends RefCounted

var numbers: Array[int] = []

func is_report_safe() -> bool:
	var index := 0
	var sign := 0
	while index < numbers.size() - 1:
		var dif := numbers[index] - numbers[index+1]
		if absi(dif) < 1 or absi(dif) > 3:
			return false
		if sign == 0:
			sign = signi(dif)
		elif sign != signi(dif):
			return false
		index += 1
	return true
