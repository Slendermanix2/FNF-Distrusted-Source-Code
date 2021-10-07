local wavy = false
local smallestMove = false
local smallerMove = false
local smallMove = false
local bigMove = false

local camerabeat = false

local BlackFade = nil

function start(song) -- do nothing
    BlackFade = makeSprite('BlackFade','blackfade', false)
    setActorX(200,'blackfade')
	setActorY(500,'blackfade')
	setActorAlpha(1,'blackfade')
	setActorScale(5,'blackfade')
end

function update(elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60)
    if smallestMove then -- not spinning crazy
        for i=0,7 do
        setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
    end
    if smallerMove then -- not spinning crazy
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
    if smallMove then -- not spinning crazy
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
    if bigMove then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*5) * math.pi) ,i)
		end
	end
    
    if wavy then -- not spinning crazy
        camHudAngle = 5 * math.sin(currentBeat * math.pi)
    end
end

function beatHit(beat) -- do nothing
    if beat == 31 then
        smallestMove = true
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 96 then
        smallestMove = false
        smallerMove = true
	end
    if beat == 159 then
        smallestMove = true
        smallerMove = false
	end
    if beat == 263 then
        smallestMove = false
        smallerMove = false
	end
    if beat == 263 then
        smallerMove = true
	end
    if beat == 383 then
        smallerMove = false
        bigMove = true
	end
    if beat == 399 then
        wavy = true
	end
    if beat == 415 then
        wavy = false
        camHudAngle = 0
        bigMove = false
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        tweenFadeIn(BlackFade,1,2)
	end
    if beat == 434 then
        tweenFadeIn(BlackFade,0,3)
	end
    if beat == 455 then
        smallMove = true
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 519 then
        smallMove = false
        bigMove = true
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 548 then
        bigMove = false
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        smallestMove = true
	end
    if beat == 631 then
        smallestMove = false
        smallMove = true
	end
    if beat == 655 then
        smallestMove = false
        smallMove = true
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 657 then
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 663 then
        wavy = true
	end
    if beat == 711 then
        setCamZoom(1)
		setHudZoom(2)
	end
    if beat == 723 then
        tweenFadeIn(BlackFade,1,0.75)
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        camHudAngle = 0
        wavy = false
        smallMove = false
	end
    if beat == 726 then
        tweenFadeIn(BlackFade,0,0.5)
        setCamZoom(1)
		setHudZoom(2)
        wavy = true
        smallMove = true
	end
    if beat == 791 then
        camerabeat = true
	end
    if beat == 795 then
        camerabeat = false
        smallestMove = true
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        camHudAngle = 0
        wavy = false
        smallMove = false
	end
    if beat == 859 then
        setCamZoom(1)
		setHudZoom(2)
        wavy = true
        bigMove = true
	end
    if beat == 891 then
        setCamZoom(1)
		setHudZoom(2)
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        smallMove = false
	end
    if beat == 923 then
        setCamZoom(1)
		setHudZoom(2)
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        camHudAngle = 0
        wavy = false
        bigMove = true
	end
    if beat == 923 then
        setCamZoom(1)
		setHudZoom(2)
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        bigMove = false
        smallestMove = true
	end
    if beat == 1100 then
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
        smallestMove = false
	end
    if beat == 1128 then
        tweenFadeIn(BlackFade,1,5)
	end
    if beat == 1200 then
        tweenFadeIn(BlackFade,0,1)
	end
    if beat == 1211 then
        tweenFadeIn(BlackFade,1,1)
	end
    
end

function stepHit(step) -- do nothing
    if step == 1 then
        tweenFadeIn(BlackFade,0,5)
	end
    if camerabeat then
		setCamZoom(1)
	end
end