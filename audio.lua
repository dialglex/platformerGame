function getAudio()
	interactSound = love.audio.newSource("audio/interact.ogg", "stream")
	interactSound:setVolume(0.75)

	runNeutralSound = love.audio.newSource("audio/runNeutral.ogg", "stream")
	runGrassSound = love.audio.newSource("audio/runGrass.ogg", "stream")
	runNeutralSound:setVolume(0.25)
	runGrassSound:setVolume(0.25)

	jumpNeutralSound = love.audio.newSource("audio/jumpNeutral.ogg", "stream")
	jumpNeutralSound:setVolume(0.3)

	landNeutralSound = love.audio.newSource("audio/landNeutral.ogg", "stream")
	landGrassSound = love.audio.newSource("audio/landGrass.ogg", "stream")
	landNeutralSound:setVolume(0.3)
	landGrassSound:setVolume(0.3)

	mainMusic = love.audio.newSource("audio/main.ogg", "stream")
	menuMusic = love.audio.newSource("audio/menu.ogg", "stream")
	bossMusic = love.audio.newSource("audio/boss.ogg", "stream")

	mainMusicVolume = 0
	menuMusicVolume = 0
	bossMusicVolume = 0

	mainMusic:setLooping(true)
	menuMusic:setLooping(true)
	bossMusic:setLooping(true)

	mainMusic:setVolume(mainMusicVolume)
    menuMusic:setVolume(menuMusicVolume)
    bossMusic:setVolume(bossMusicVolume)

	mainMusic:play()
	menuMusic:play()
	bossMusic:play()
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