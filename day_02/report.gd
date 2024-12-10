class_name Report
extends RefCounted

const TOLERANCE = 1

var numbers: Array[int] = []

func _init(numbers: Array[int] = []) -> void:
	self.numbers = numbers

func is_report_safe(strikes: int = 0) -> bool:
	var index := 0
	var sign := 0
	var bad_level_found := false
	
	while index < numbers.size() - 1:
		var dif := numbers[index] - numbers[index+1]
		if absi(dif) < 1 or absi(dif) > 3:
			bad_level_found = true
		if sign == 0:
			sign = signi(dif)
		elif sign != signi(dif):
			bad_level_found = true
		if bad_level_found:
			if strikes >= TOLERANCE:
				return false
			else:
				for idx in range(numbers.size()):
					var new_report := Report.new(Array(numbers.duplicate(), TYPE_INT, "", null))
					new_report.numbers.remove_at(idx)
					if new_report.is_report_safe(1):
						return true
				return false
		index += 1
	return true
