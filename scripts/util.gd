class_name Util

static func get_time(time_float: float) -> String:
  var time_int: int = floori(time_float)
  var seconds: int = time_int % 60
  var minutes: int = int(time_int / 60.0)

  return "%02d:%02d" % [minutes, seconds]

static func sum_array_i(array: Array[int]) -> int:
  return array.reduce(func(a: int, b: int): return a + b)

static func sum_array_f(array: Array[float]) -> float:
  return array.reduce(func(a: float, b: float): return a + b)

static func weight_rand(weights: Array[float]) -> int:
  var size = weights.size()
  if size < 2: return size -1

  var total = sum_array_f(weights)
  var random = randf() * total

  var cumulative_weight = 0.0
  for index in size:
    cumulative_weight += weights[index]

    if random <= cumulative_weight:
      return index

  return weights.size() - 1