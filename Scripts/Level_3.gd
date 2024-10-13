extends LEVEL
class_name LevelWithWave3

func wait_timer_reduced(kills):
	if kills == kills_needed[0]:
		print("wave_1")
		spawn_aliens.timer.wait_time=wait_times[0]
	elif kills== kills_needed[1]:
		print("wave_2")
		spawn_aliens.wave_setter(wave_number[0])
		spawn_aliens.timer.wait_time=wait_times[1]
	if kills== kills_needed[2]:
		print("wave_3")
		spawn_aliens.timer.wait_time=wait_times[2]
		spawn_aliens.wave_setter(wave_number[1])
	if kills==texture_progress_bar.max_value:
		GameManager._level_completed(name_level)
		$AnimationPlayer.play("Next_plant")
		spawn_aliens._level_finished()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file(next_level)
