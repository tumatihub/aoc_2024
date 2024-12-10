class_name ReportList
extends RefCounted

var report_list: Array[Report] = []

func calc_number_of_safe_reports() -> int:
	var result := 0
	for report in report_list:
		if report.is_report_safe():
			result += 1
	return result

func add_report(report: Report) -> void:
	report_list.append(report)
