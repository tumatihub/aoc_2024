class_name PagesUpdate
extends RefCounted

var pages: Array[int] = []

func _init(pages: Array[int]) -> void:
	self.pages = pages

func is_ordered(rules: UpdateRules) -> bool:
	for i in size():
		for j in range(i+1,size()):
			if rules.has_dependency(pages[j], pages[i]):
				return false
	return true

func sort(rules: UpdateRules) -> void:
	var sorted := false
	while !sorted:
		var found := false
		for i in size():
			for j in range(i+1,size()):
				if rules.has_dependency(pages[j], pages[i]):
					var tmp := pages[j]
					pages[j] = pages[i]
					pages[i] = tmp
					found = true
					break
		if !found:
			sorted = true

func get_middle_page() -> int:
	return pages[size()/2]

func get_pages() -> Array[int]:
	return pages

func size() -> int:
	return pages.size()
