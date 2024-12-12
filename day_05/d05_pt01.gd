extends Node

var input: String = "res://day_05/d05_pt01_input.txt"

func _ready() -> void:
	run()

func run() -> void:
	print("running: D05Pt01")
	var file := FileAccess.open(input, FileAccess.READ)
	if !file:
		return
	
	var result := 0
	var updates := PagesUpdateList.new()
	var rules := UpdateRules.new()
	
	var line := file.get_line()
	while !line.is_empty():
		var string_rules := line.split("|")
		rules.add(int(string_rules[0]), int(string_rules[1]))
		line = file.get_line()
	
	while file.get_position() < file.get_length():
		var string_update := file.get_line().split(",")
		var int_update: Array[int]
		for u in string_update:
			int_update.append(int(u))
		updates.add(PagesUpdate.new(int_update))
	
	var correct_updates := updates.get_correct_ordered_updates(rules)
	var middle_page_sum := correct_updates.sum_all_middle_page()
	
	print("Middle pages sum: " + str(middle_page_sum))
	file.close()
