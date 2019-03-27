function getAudio()
	musicList = {}
	sfxList = {}

	interactSound = love.audio.newSource("audio/interact.ogg", "stream")
	runNeutralSound = love.audio.newSource("audio/runNeutral.ogg", "stream")
	runGrassSound = love.audio.newSource("audio/runGrass.ogg", "stream")
	jumpNeutralSound = love.audio.newSource("audio/jumpNeutral.ogg", "stream")
	landNeutralSound = love.audio.newSource("audio/landNeutral.ogg", "stream")
	landGrassSound = love.audio.newSource("audio/landGrass.ogg", "stream")

	menuMoveSound = love.audio.newSource("audio/sfx/menuMove.wav", "stream")
	menuConfirmSound = love.audio.newSource("audio/sfx/menuConfirm.wav", "stream")
	menuBackSound = love.audio.newSource("audio/sfx/menuBack.wav", "stream")


	table.insert(sfxList, interactSound)
	table.insert(sfxList, runNeutralSound)
	table.insert(sfxList, runGrassSound)
	table.insert(sfxList, jumpNeutralSound)
	table.insert(sfxList, landNeutralSound)
	table.insert(sfxList, landGrassSound)
	table.insert(sfxList, menuMoveSound)
	table.insert(sfxList, menuConfirmSound)
	table.insert(sfxList, menuBackSound)

	for i, sfx in ipairs(sfxList) do
		sfx:setVolume(sfxVolume)
	end


	mainMusic = love.audio.newSource("audio/main.ogg", "stream")
	menuMusic = love.audio.newSource("audio/menu.ogg", "stream")
	bossMusic = love.audio.newSource("audio/boss.ogg", "stream")

	table.insert(musicList, mainMusic)
	table.insert(musicList, menuMusic)
	table.insert(musicList, bossMusic)

	for i, music in ipairs(musicList) do
		music:setLooping(true)
		music:play()
		music:setVolume(0)
	end

	mainMusicVolume = 0
	menuMusicVolume = 0
	bossMusicVolume = 0
end

function updateVolume()
	if player.behindWall then
		if mainMusicVolume < 1 then
			mainMusicVolume = mainMusicVolume + 0.01
		end
		if menuMusicVolume > 0 then
			menuMusicVolume = menuMusicVolume - 0.01
		end
	else
		if menuMusicVolume < 1 then
			menuMusicVolume = menuMusicVolume + 0.01
		end
		if mainMusicVolume > 0 then
			mainMusicVolume = mainMusicVolume - 0.01
		end
	end

	mainMusic:setVolume(mainMusicVolume*musicVolume)
	menuMusic:setVolume(menuMusicVolume*musicVolume)
	bossMusic:setVolume(bossMusicVolume*musicVolume)

	for i, sfx in ipairs(sfxList) do
		sfx:setVolume(sfxVolume)
	end
end

function mute()
	if pressInputs.mute then
		if muted then
			mainMusic:play()
			menuMusic:play()
			bossMusic:play()
			muted = false
		else
			mainMusic:pause()
			menuMusic:pause()
			bossMusic:pause()
			muted = true
		end
	end
end