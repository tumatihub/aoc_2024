class_name UpdateRules
extends RefCounted

var rules: Array[Rule] = []

func has_dependency(dependency: int, page: int) -> bool:
	for r in rules:
		if r.dependency == dependency and r.page == page:
			return true
	return false

func get_subset_from_pages(pages: Array[int]) -> UpdateRules:
	var rules_subset := UpdateRules.new()
	for r in rules:
		if pages.count(r.dependency) > 0 and pages.count(r.page) > 0:
			rules_subset.add(r.dependency, r.page)
	return rules_subset

func add(dependency: int, page: int) -> void:
	rules.append(Rule.new(dependency, page))

func size() -> int:
	return rules.size()

class Rule:
	var page: int
	var dependency: int
	
	func _init(dependency: int, page: int) -> void:
		self.page = page
		self.dependency = dependency
