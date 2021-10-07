local wavy = false
local smallestMove = false
local smallerMove = false
local smallMove = false
local bigMove = false
local biggerMove = false

local camerabeat = false

function start(song) -- do nothing
end

function update(elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60)
    if smallestMove then -- not spinning crazy
        for i=0,7 do
        setActorY(defaultStrum0Y + 50 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
    end
    if smallerMove then
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
    if smallMove then
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
    if bigMove then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 128 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*5) * math.pi) ,i)
		end
	end
    if biggerMove then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
	end
    
    if wavy then -- not spinning crazy
        camHudAngle = 5 * math.sin(currentBeat * math.pi)
    end
end

function beatHit(beat) -- do nothing
    if beat == 48 then
        wavy = true
	end
    if beat == 80 then
        smallestMove = false
        bigMove = true
        wavy = false
	end
    if beat == 112 then
        biggerMove = true
        bigMove = false
	end
    if beat == 128 then
        biggerMove = false
        for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
	end
    
end

function stepHit(step) -- do nothing
    if step == 1 then
        smallestMove = true
	end
    if camerabeat then
		setCamZoom(1)
	end
end