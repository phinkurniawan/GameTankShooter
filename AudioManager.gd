extends Node


func Music(music):
	$Music.stream = music
	$Music.play()

func play_effect(clip):
	var n = $GameEffects.get_child_count()
	
	for i in range(n):
		var child = $GameEffects.get_child(i)
		if !child.playing:
			child.stream = clip
			child.play()
			return
