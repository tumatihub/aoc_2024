extends Node

var input: String = "res://day_02/d02_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D02Pt02")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	var report_list := ReportList.new()
	while file.get_position() < file.get_length():
		var line_numbers: PackedStringArray = file.get_line().split(" ")
		var report := Report.new()
		report.numbers = get_report_from_strings(line_numbers)
		report_list.add_report(report)
	
	print("Number of safe reports: " + str(report_list.calc_number_of_safe_reports()))
	file.close()

func get_report_from_strings(string_report: PackedStringArray) -> Array[int]:
	var report: Array[int] = []
	for i in string_report:
		report.append(int(i))
	return report
