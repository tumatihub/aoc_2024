extends Node

var input: String = "res://day_02/d02_pt01_input.txt"
var report_list: Array[Report] = []

func _ready() -> void:
	run()

func run() -> void:
	print("running: D02Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	while file.get_position() < file.get_length():
		var line_numbers: PackedStringArray = file.get_line().split(" ")
		var report := Report.new()
		report.numbers = get_report_from_strings(line_numbers)
		report_list.append(report)
	
	print("Number of safe reports: " + str(calc_number_of_safe_reports()))
	file.close()

func calc_number_of_safe_reports() -> int:
	var result := 0
	for report in report_list:
		if report.is_report_safe():
			result += 1
	return result

func get_report_from_strings(string_report: PackedStringArray) -> Array[int]:
	var report: Array[int] = []
	for i in string_report:
		report.append(int(i))
	return report
