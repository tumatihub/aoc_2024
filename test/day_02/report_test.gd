class_name ReportTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://day_02/d02_pt01.gd'

var report

func before() -> void:
	report = auto_free(Report.new())

func test_safe_decreasing_report() -> void:
	var report := Report.new()
	report.numbers = Array([7, 6, 4, 2, 1], TYPE_INT, "", null)
	assert_bool(report.is_report_safe()).is_true()

func test_unsafe_big_increase() -> void:
	report.numbers = Array([1, 2, 7, 8, 9], TYPE_INT, "", null)
	assert_bool(report.is_report_safe()).is_false()

func test_unsafe_big_decrease() -> void:
	report.numbers = Array([9, 7, 6, 2, 1], TYPE_INT, "", null)
	assert_bool(report.is_report_safe()).is_false()

func test_unsafe_change_increase_to_decrease() -> void:
	report.numbers = Array([1, 3, 2, 4, 5], TYPE_INT, "", null)
	assert_bool(report.is_report_safe()).is_false()

func test_unsafe_consecutive_equal_numbers() -> void:
	report.numbers = Array([8, 6, 4, 4, 1], TYPE_INT, "", null)
	assert_bool(report.is_report_safe()).is_false()
