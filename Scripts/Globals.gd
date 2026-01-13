extends Node

# https://gist.github.com/laundmo/b224b1f4c8ef6ca5fe47e132c8deab56

func lerp(a: float, b: float, t: float) -> float:
	"""Linear interpolate on the scale given by a to b, using t as the point on that scale.
	Examples
	--------
		50 == lerp(0, 100, 0.5)
		4.2 == lerp(1, 5, 0.8)
	"""
	return (1 - t) * a + t * b


func inv_lerp(a: float, b: float, v: float) -> float:
	"""Inverse Linar Interpolation, get the fraction between a and b on which v resides.
	Examples
	--------
		0.5 == inv_lerp(0, 100, 50)
		0.8 == inv_lerp(1, 5, 4.2)
	"""
	return (v - a) / (b - a)


func remap(i_min: float, i_max: float, o_min: float, o_max: float, v: float) -> float:
	"""Remap values from one linear scale to another, a combination of lerp and inv_lerp.
	i_min and i_max are the scale on which the original value resides,
	o_min and o_max are the scale to which it should be mapped.
	Examples
	--------
		45 == remap(0, 100, 40, 50, 50)
		6.2 == remap(1, 5, 3, 7, 4.2)
	"""
	return lerp(o_min, o_max, inv_lerp(i_min, i_max, v))

# https://github.com/nealholt/TargetLeadExample/blob/main/Scripts/gun.gd
func get_intercept(shooter_pos:Vector3,
					bullet_speed:float,
					target_position:Vector3,
					target_velocity:Vector3) -> Vector3:
	var a:float = bullet_speed*bullet_speed - target_velocity.dot(target_velocity)
	var b:float = 2*target_velocity.dot(target_position-shooter_pos)
	var c:float = (target_position-shooter_pos).dot(target_position-shooter_pos)
	# Protect against divide by zero and/or imaginary results
	# which occur when bullet speed is slower than target speed
	var time:float = 0.0
	if bullet_speed > target_velocity.length():
		time = (b+sqrt(b*b+4*a*c)) / (2*a)
	return target_position+time*target_velocity

# https://easings.net/
func EaseIOCubic(x: float) -> float:
	"""Cubic easing in/out - acceleration until halfway, then deceleration.
	Examples
	--------
		0.5 == easeInOutCubic(0.5)
		0.896 == easeInOutCubic(0.8)
	"""
	if x < 0.5:
		return 4 * x * x * x
	else:
		return 1 - pow(-2 * x + 2, 3) / 2
