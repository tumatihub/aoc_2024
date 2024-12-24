class_name StoneLine
extends RefCounted

const THIRD_RULE_MULT = 2024

var stones: PackedStringArray

func _init(string: String) -> void:
	stones = string.split(" ")

func blink_n_times(n: int) -> void:
	for i in n:
		blink()

func blink() -> void:
	var new_stones: PackedStringArray = []
	for stone in stones:
		if stone == "0":
			new_stones.append("1")
		elif _has_even_num_digits(stone):
			new_stones.append_array(_split_stone(stone))
		else:
			new_stones.append(str(int(stone)*THIRD_RULE_MULT))
	stones = new_stones

func _has_even_num_digits(stone: String) -> bool:
	return stone.length() % 2 == 0

func _split_stone(stone: String) -> PackedStringArray:
	var new_stones: PackedStringArray
	var mid := stone.length() / 2
	new_stones.append(str(int(stone.substr(0, mid))))
	new_stones.append(str(int(stone.substr(mid, -1))))
	return new_stones

func size() -> int:
	return stones.size()
