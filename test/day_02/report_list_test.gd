class_name ReportListTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

func test_find_4_safe_reports_from_example_set() -> void:
	var report_list := ReportList.new()
	report_list.add_report(Report.new(Array([7, 6, 4, 2, 1], TYPE_INT, "", null)))
	report_list.add_report(Report.new(Array([1, 2, 7, 8, 9], TYPE_INT, "", null)))
	report_list.add_report(Report.new(Array([9, 7, 6, 2, 1], TYPE_INT, "", null)))
	report_list.add_report(Report.new(Array([1, 3, 2, 4, 5], TYPE_INT, "", null)))
	report_list.add_report(Report.new(Array([8, 6, 4, 4, 1], TYPE_INT, "", null)))
	report_list.add_report(Report.new(Array([1, 3, 6, 7, 9], TYPE_INT, "", null)))
	assert_int(report_list.calc_number_of_safe_reports()).is_equal(4)
