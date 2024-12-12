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

func get_middle_page() -> int:
	return pages[size()/2]

func get_pages() -> Array[int]:
	return pages

func size() -> int:
	return pages.size()
