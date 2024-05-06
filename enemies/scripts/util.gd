class_name Util

static func sum_array_i(array: Array[int]) -> int:
  var result: int = 0;
  for item in array:
    result += item
  return result

static func sum_array_f(array: Array[float]) -> float:
  var result: float = 0;
  for item in array:
    result += item
  return result