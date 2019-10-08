function getAudio()
	musicList = {}
	sfxList = {}

	interactSound = love.audio.newSource("audio/sfx/interact.ogg", "static")
	runNeutralSound = love.audio.newSource("audio/sfx/runNeutral.ogg", "static")
	runGrassSound = love.audio.newSource("audio/sfx/runGrass.ogg", "static")
	jumpNeutralSound = love.audio.newSource("audio/sfx/jumpNeutral.ogg", "static")
	landNeutralSound = love.audio.newSource("audio/sfx/landNeutral.ogg", "static")
	landGrassSound = love.audio.newSource("audio/sfx/landGrass.ogg", "static")

	menuMoveSound = love.audio.newSource("audio/sfx/menuMove.wav", "static")
	menuConfirmSound = love.audio.newSource("audio/sfx/menuConfirm.wav", "static")
	menuBackSound = love.audio.newSource("audio/sfx/menuBack.wav", "static")


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

	caveMusic = love.audio.newSource("audio/music/cave.ogg", "stream")
	shopMusic = love.audio.newSource("audio/music/shop.ogg", "stream")
	bossMusic = love.audio.newSource("audio/music/boss.ogg", "stream")
	grasslandMusic = love.audio.newSource("audio/music/grassland.ogg", "stream")

	table.insert(musicList, caveMusic)
	table.insert(musicList, shopMusic)
	table.insert(musicList, bossMusic)
	table.insert(musicList, grasslandMusic)

	for i, music in ipairs(musicList) do
		music:setLooping(true)
		-- music:play()
		music:setVolume(0)
	end

	caveMusicVolume = 0
	shopMusicVolume = 0
	bossMusicVolume = 0
	grasslandMusicVolume = 0
end

function updateVolume()
	if (mapNumber == 2 or mapNumber == 4) and indoor then -- if inside cave
		grasslandMusicVolume = grasslandMusicVolume - 0.05
		caveMusicVolume = caveMusicVolume + 0.05
		shopMusicVolume = shopMusicVolume - 0.05
	elseif mapNumber == 3 and indoor then -- if inside shop
		grasslandMusicVolume = grasslandMusicVolume - 0.05
		caveMusicVolume = caveMusicVolume - 0.05
		shopMusicVolume = shopMusicVolume + 0.05
	else
		grasslandMusicVolume = grasslandMusicVolume + 0.05
		caveMusicVolume = caveMusicVolume - 0.05
		shopMusicVolume = shopMusicVolume - 0.05
	end

	if grasslandMusicVolume > 1 then
		grasslandMusicVolume = 1
	elseif grasslandMusicVolume < 0 then
		grasslandMusicVolume = 0
	end

	if caveMusicVolume > 1 then
		caveMusicVolume = 1
	elseif caveMusicVolume < 0 then
		caveMusicVolume = 0
	end

	if shopMusicVolume > 1 then
		shopMusicVolume = 1
	elseif shopMusicVolume < 0 then
		shopMusicVolume = 0
	end

	caveMusic:setVolume(caveMusicVolume*musicVolume)
	shopMusic:setVolume(shopMusicVolume*musicVolume)
	bossMusic:setVolume(bossMusicVolume*musicVolume)
	grasslandMusic:setVolume(grasslandMusicVolume*musicVolume)

	for i, music in ipairs(musicList) do
		if music:getVolume() > 0 then
			music:play()
		else
			music:stop()
		end
	end

	for i, sfx in ipairs(sfxList) do
		sfx:setVolume(sfxVolume*0.5)
	end
end