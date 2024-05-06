class_name Util

static func sum_array_i(array: Array[int]) -> int:
  return array.reduce(func(a: int, b: int): return a + b)

static func sum_array_f(array: Array[float]) -> float:
  return array.reduce(func(a: float, b: float): return a + b)

static func weight_rand(weigths: Array[float]) -> int:
  var total = sum_array_f(weigths)
  var size = weigths.size()
  var bet = randf() * total
  var index = 0
  while index < size:
    if bet <= weigths[index]:
      return index
    else:
      bet -= weigths[index]
      index += 1
  return 0