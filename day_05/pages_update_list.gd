class_name PagesUpdateList
extends RefCounted

var updates: Array[PagesUpdate] = []

func get_correct_ordered_updates(rules: UpdateRules) -> PagesUpdateList:
	var new_list := PagesUpdateList.new()
	for u in updates:
		if u.is_ordered(rules):
			new_list.add(u)
	return new_list

func sum_all_middle_page() -> int:
	var sum := 0
	for u in updates:
		sum += u.get_middle_page()
	return sum

func size() -> int:
	return updates.size()

func add(update: PagesUpdate) -> void:
	updates.append(update)
