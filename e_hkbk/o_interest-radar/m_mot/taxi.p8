pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- wHIPLASH tAXI cOMPANY
-- bY MOt

-- main
sdist,vany,farz,camyoffs=120,32,7,-0.15
vvgrad=64/sdist
mperu=8 -- metres per unit

function _init() 
	cartdata("mot_whiplashtaxi")

	-- palette
	poke(0x5f2e,1)	-- keep palette
	?"\^!5f1001ˇ5●?█░◆9☉6=<3⬅️"

	loaddata()
	loadscores()

	-- misc
	frame,diffi,circi,gametype=0,max(dget(63),1),max(dget(62),1),0

	toggletilt()
	-- menuitem(5,"copy pos",function()
	-- 	printh((player.x&63|64)..":"..(player.y&31),"circuit")
	-- 	prvx,prvy=player.x,player.y
	-- end)

	-- menu mode
	initmenu()
end

function _draw()
	if mode=="game" then
		drawgame()
	elseif mode=="menu" then
		drawmenu()
	elseif mode=="postgame" then
		drawpostgame()
	end
	if tran then
		local ismore,canrun=tran(trant)
		if not ismore then
			local a=aftertran
			tran,aftertran,pause=nil,nil,nil
			if(a)a()
		else
			pause=not canrun
		end
	end	
--	print(stat(1),1,11,10)
--	print(stat(0))
--	print(#activeobj)
--  if player then
-- 	print((player.x&63|64)..","..(player.y&31))
-- 	end
	-- print(player and player.xi,0,64,10)
end

st,stback,stcent=0.085,0.175,0.07

function _update()
	frame+=1

	if(tran)trant+=1/30

	if(pause)return

	if mode=="game" then
		updategame()
	elseif mode=="menu" then
		updatemenu()
	elseif mode=="postgame" then
		updatepostgame()
	end
end

function initgame()
	mode="game"

	-- misc
	zbuf,colsfxi,colsfxtimer,carct,msgq,msgx={},0,0,0,{},0
	displayedscore,speed=0,0
	skew,vanytilt=0,32

	-- game state
	activeobj={}
	initobjgrid()
	local saveseed=rnd(0xffff.ffff)
	srand(123)
	spawnobjects()
	if gametype==1 then
		-- taxi
		srand(321)
		spawnpassengers()
		timer=9000  -- 5 minutes
	elseif gametype==2 then
		-- circuit race
		spawncircuitwaypts(circuits[circi])
	elseif gametype==3 then
		-- free drive
		srand(321)
		spawnpassengers()
	end
    srand(saveseed)

	-- player
	player={x=84.7,y=15.9,h=0,xd=0,yd=0,hd=0,ang=0,typ=objtyps.player,dir=0,xi=0,yi=0,score=0}
	if gametype==2 then		
		local wp1,wp2=circuitwaypts[#circuitwaypts],circuitwaypts[1]
		player.nextwp,player.lap,player.x,player.y,player.lapt,player.laptbest=1,0,wp1.x,wp1.y,0,10000
		player.ang=aimat(wp2.x,wp2.y,wp1.x,wp1.y)
	end

	-- active npc car region
	cx0,cy0=player.x\1,player.y\1
	cx1,cy1=cx0,cy0

	menuitem(1,"quit to menu",function()
		music(-1,2)
		transition(tran_circleout,initmenu)
	end)

	transition(tran_circlein,function()
		transition(tran_321,function()music(4,1,0b11)end)
		sfx(20,2)
	end)
end

function drawgame()
	camera()
	rectfill(0,0,127,vany+5,1)
	drawscene(player.x,player.y,player.h+camyoffs,player.ang)
	drawmap(player.x,player.y)
	if(player.passenger)drawpassengerui()
	if gametype==2 then
		local wp=circuitwaypts[player.nextwp]
		palt(0,true)
		drawdestindicator(wp.x,wp.y,-1)
	end
	drawhud()
	drawmessages()	
	prettyprint(player.placename or "",nil,2,5)
end

function updategame()
	updatescore()

	if gametype==1 then
		if timer>0 then 
			timer-=1
			if timer<=300 and timer%30==0 then
				sfx(16,3)
			end
			if timer<=0 then
				-- round finished
				sfx(-1,-2)
				music(0)
				transition(tran_msg("time's up!",5),function()transition(tran_circleout,initpostgame)end)
			end
		end

		if(timer<=0)return
	end

	-- update gameplay
	updatecarregion()

	-- "simulate" player car
	local xi,yi=0,0
	if(btn(⬆️)or btn(🅾️))yi-=1
	if(btn(⬇️)or btn(❎))yi+=1
	if(btn(⬅️))xi-=1
	if(btn(➡️))xi+=1

	nskew,nvany=0,32
	speed=simulatecar(player,xi,yi)*mperu*-108
	local pcxd,pcyd=rotate(player.xd,player.yd,sin(-player.ang),cos(-player.ang))
	moveobject(player)	

	-- update moveable objects
	doobjectcollisions(player)
	moveactiveobjects()
	player.hd=0

	-- update passengers
	updatepassengers()

	-- shake camera based on collisions
	local cxd,cyd=rotate(player.xd,player.yd,sin(-player.ang),cos(-player.ang))
	nvany+=(cyd-pcyd)*-3000

	-- camera shake/tilt logic
	skew=skew*0.8+nskew*0.2
	if(abs(skew)<0.004)skew=0
	vanytilt=vanytilt*0.8+nvany*0.2
	vany=(vanytilt+0.5)\1

	-- misc
	if colsfxtimer>0 then
		colsfxtimer-=1
	else
		colsfxi=0
	end
	if(frame%30==0)player.placename=getplacename(player.x,player.y)

	-- game rules
	if player.passenger then
		player.fare=max(player.fare-difficulties[diffi].rate,10)
	end

	if gametype==2 then
		if(player.lap>0)player.lapt+=1
		local wp=circuitwaypts[player.nextwp]
		local dx,dy=relpos(player.x,player.y,wp.x,wp.y)
		if length(dx,dy)<1 then
			if player.nextwp==1 then
				if player.lap>0 then
					player.laptlast=player.lapt
					player.laptbest=min(player.laptbest,player.lapt)
				end
				player.lap+=1
				player.lapt=0
				if player.lap>3 then
					sfx(-1,-2)
					music(0)
					transition(tran_msg("rACE cOMPLETED!",5),function()transition(tran_circleout,initpostgame)end)
				else
					transition(tran_msg(player.lap==3 and "fINAL lAP!" or ("lap "..player.lap),1.9,true))
				end
				-- todo: sfx			
			end
			player.nextwp=player.nextwp%#circuitwaypts+1
			sfx(15)
		end
	end
end

function initpostgame()
	music(-1,2)
	mode="postgame"
	displayedscore=0
	frame=0
	menuitem(1)
	sfx(-1,-2)

	-- update scores
	lastgametype=gametype
	if gametype==1 then
		local scores=taxiscores[diffi]
		lastdiff,lastrank=diffi,#scores+1
		while lastrank>1 and scores[lastrank-1]<player.score do 
			if(lastrank<=#scores)scores[lastrank]=scores[lastrank-1]
			lastrank-=1
			scores[lastrank]=player.score
		end
	else
		local times=circuits[circi].times
		lastcirci,lastrank=circi,#times+1
		while lastrank>1 and times[lastrank-1]>player.laptbest do 
			if(lastrank<=#times)times[lastrank]=times[lastrank-1]
			lastrank-=1 
			times[lastrank]=player.laptbest
		end
	end
	savescores()
	transition(tran_circlein)
end

function drawpostgame()
	cls(1)
	if gametype==1 then
		prettyprint("round over!",nil,8,5,true,true)
		prettyprint("yOU eARNED",nil,25,4)
		prettyprint("$"..tostr(displayedscore),nil,40,9,true,true)
	elseif gametype==2 then
		prettyprint("race over!",nil,8,5,true,true)
		prettyprint("bEST lAP",nil,25,4)
		prettyprint(timestr(player.laptbest/30,true),nil,40,9,true,true)
		drawcircstars(player.laptbest,98,42)
	end

	-- car
	local car=objtyps.car1
	pal(carpals.yellow)
	palt(0,true)
	map(car.mx,car.my,64-car.mw*4,55,car.mw,car.mh)
	pal(defpal)

	if(lastrank and lastrank<=3)prettyprint(gametype==1 and "nEW tOP sCORE!" or "nEW bEST tIME!",nil,80,10,true,true,true)
	
	if frame>60 and frame%30<20 then
		prettyprint("press ❎ to continue",nil,110,4)
	end
end

function updatepostgame()
	if(gametype==1)updatescore()

	-- return to menu when ❎ or 🅾️ pressed
	if frame>60 and (btnp(❎) or btnp(🅾️)) then
		transition(tran_circleout,initmenu)
	end
end

function transition(_tran,_aftertran)
	tran,aftertran,trant=_tran,_aftertran,0
end

function tran_circleout(t)
	r=t*20
	for x=0,130,10 do
		for y=0,130,10 do
			circfill(x,y,r,0)
		end
	end
	return t<0.5
end

function tran_circlein(t) 
	tran_circleout(0.5-t)
	return t<0.5
end

text321=split("3,2,1,gO!",",",false)
function tran_321(t)
	local i=t\1+1
	if(i>#text321)return false
	if i<#text321 and t%1<0.5 or i>=#text321 and t%0.25<0.125 then
		prettyprint(text321[i],nil,30,9,true,true,true)
	end
	return true,i>=#text321
end

function tran_msg(text,duration,nopause)	
	return function(t)
		if(t%1<0.5)prettyprint(text,nil,30,9,true,true,true)
		return t<duration,nopause
	end
end

-->8
-- data

function loaddata()
	objtyps=data([[name,mx,my,mw,mh,w,h,rad,mass,bounce,hoffs,frames,yspinf
player,,,,,,0.5,0.8,360,0.3,-0.1,,
barrel,10,32,2,2,1,1.25,1,40,0.4,-0.6,,
bush,10,37,5,3,2.5,1.5,0,0,,,,
bushsml,10,34,2,2,1,1,0,0,,,,
table,12,32,2,2,1.5,0.8,1.5,15,0.4,-0.5,,0.15
tree1,0,32,5,8,5,8,0.5,0,,,,
tree2,5,32,5,8,5,8,0.5,0,,,,
tree3,15,32,3,8,3,8,1,0,,,,
tree4,15,32,3,5,3,5,1,0,,,,
lamp,18,32,1,8,0.5,4,0.1,0,,,,
booth,19,32,2,5,1.2,3,1,300,0.3,-0.5,,
mailbox,12,34,2,3,0.8,1.2,1,40,0.4,-0.5,,
car1,0,42,8,6,,1.31,0.8,300,0.2,-0.6,,
car2,8,42,12,6,,1.31,0.8,300,0.2,-0.6,,
car3,20,42,15,6,,1.31,0.8,300,0.2,-0.6,,
car4,35,42,12,6,,1.31,0.8,300,0.2,-0.6,,
car5,47,42,8,6,,1.31,0.8,300,0.2,-0.6,,
car,,,,,,1.8,0.8,360,0.2,-0.6,{obj.car1:obj.car2:obj.car3:obj.car4:obj.car5},
truck1,55,42,8,6,,1.31,0.8,300,0.2,-0.6,,
truck2,24,36,12,6,,1.31,0.8,300,0.2,-0.6,,
truck3,36,36,15,6,,1.31,0.8,300,0.2,-0.6,,
truck4,51,36,12,6,,1.31,0.8,300,0.2,-0.6,,
truck5,63,36,8,6,,1.31,0.8,300,0.2,-0.6,,
truck,,,,,,1.8,0.8,360,0.2,-0.6,{obj.truck1:obj.truck2:obj.truck3:obj.truck4:obj.truck5},
arrow,64,32,4,4,,2,0,0,,,,
wparrow,64,32,4,4,,3,0,0,,,,
wparrowl,80,32,4,4,,3,0,0,,,,
wparrowr,76,32,4,4,,3,0,0,,,,
waypt,,,,,,3,0,0,,,{obj.wparrow:obj.wparrowr:obj.wparrowr:obj.wparrowl:obj.wparrow},
flag,68,32,8,4,,3,0,0,,,,
cross,71,32,6,6,8,4,0,0,,,,
person1,21,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person2,23,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person3,25,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person4,27,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person5,29,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person6,31,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person7,33,32,2,3,,1.6,0.1,25,0.05,-0.4,,
person8,35,32,2,3,,1.6,0.1,25,0.05,-0.4,,
veg,10,36,1,1,1.1,0.9,0.05,4,0.4,-0.2,,
weed,14,35,2,1,,0.8,0,0,,,,]],"obj")
	surftyps=data[[name,f_roll,f_grip,f_slide,slidesfx,tiles,shake
road,0.0125,0.005,0.0025,8,{32:33:34:35:36:48:50:51:52:64:65:80:81:96:97},0
pavement,0.025,0.004,0.002,9,{1:2:16:17:18:66:67:82:83:98:112:113:114},2
grass,0.075,0.003,0.0015,10,{3:4},5]]
	bldtyps=data[[name,mx,my,mw,mh
town1,48,0,8,16
town2,48,24,16,11
hedge,56,11,8,5
cabin,48,16,16,8
wall,56,6,8,5
house,56,0,8,5]]

	-- navigation data
	local navraw=data[[tile,entry,exit,weight
0,4,1,
0,0,5,
4,4,3,
4,2,5,
16,4,3,
16,2,5,
17,2,7,
17,6,3,
17,4,3,
17,4,7,
17,6,5,0.3
17,2,5,0.3
19,2,7,
19,3,6,
19,2,6,0.08
19,3,7,0.08
33,2,7,
33,6,3,
33,4,3,
33,4,7,
33,6,5,0.3
33,2,5,0.3
33,0,7,
33,0,3,
33,2,1,0.3
33,6,1,0.3
33,4,1,
33,0,5,]]
	local navdup=data[[base,dups,spd
0,{0:1},
4,{4:5:21:20},
16,{16:18:50:48},
17,{17:34:49:32},
19,{19:37:35:36},1.5
33,{33},]]
	carpals=data[[name,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
none,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
gray,0,1,2,3,4,5,6,2,5,4,3,11,12,13,14,15
dkgray,0,1,2,3,4,5,6,6,4,3,2,11,12,13,14,15
blue,0,1,2,3,4,5,6,1,11,13,12,11,12,13,14,15
dkblue,0,1,2,3,4,5,6,6,13,12,1,11,12,13,14,15
green,0,1,2,3,4,5,6,6,11,15,14,11,12,13,14,15
red,0,1,2,3,4,5,6,2,8,10,7,11,12,13,14,15
yellow,0,1,2,3,4,5,6,2,5,9,7,11,12,13,14,15]]
	defpal=carpals.none
	del(carpals,defpal)

	placenames=data[[name,x,y
bob's farm,104,2
central suburbs,93,18
downtown,108,25
east district,100,15
east suburbs,116,25
fred's farm,85,22
the hospital,93,13
minitown,77,25
mot manor,71,15
noisy row,79,5
mot industries,103,7
shady hotels,112,18
south district,100,24
the highrises,119,15
the historic library,98,2
the markets,112,13
the new flats,70,3
the old farmhouse,86,26
the prison,86,3
the countryside,121,5
the countryside,68,27
west district,85,15]]

	passdata=data[[x,y,tx,ty
98.1084,20.8558,87.707,1.4339
91.7229,16.7262,101.7158,26.8265
111.7078,13.8393,70.8448,14.7424
97.3748,1.4395,123.7748,16.0028
110.2483,23.9516,117.9506,15.0639
110.5929,18.0993,93.5675,13.0486
88.1938,13.9783,66.3229,22.3148
119.0581,19.6032,86.6904,27.9301
84.0517,22.881,95.2024,16.9814
103.1727,8.8742,70.9899,15.4027
71.108,13.4886,97.6207,25.0056
86.4869,1.4996,93.385,18.0666
80.8687,16.2836,99.7402,7.2283
80.6628,4.5779,103.5181,5.9873
67.432,3.1676,109.942,11.1629
107.0666,27.4554,97.9634,15.4053
97.9258,12.6989,118.0748,24.5025
115.0449,27.2141,87.2295,12.9108
87.531,17.9446,105.1772,0.6427
105.184,2.4825,118.0954,24.4984
76.7791,27.4347,104.6785,15.4622
99.1559,15.4746,98.5029,4.0949
71.0142,1.1401,66.483,22.6243
72.9185,28.1206,116.9763,27.1508
111.935,3.0372,101.2928,26.9842
99.2633,26.1972,100.8697,8.9106
105.8658,6.0092,109.5124,20.5269
118.0991,24.4475,95.5094,13.4313
97.4516,10.4177,72.9071,1.6817
64.9713,13.9296,77.5009,24.0226
84.0188,19.0365,101.4193,12.9468
104.2423,21.0061,98.0309,15.3775
102.6929,13.1065,91.4398,26.0576
91.4509,21.1768,68.4027,18.5539
84.8762,10.7115,97.0195,18.6857
94.3521,22.462,95.9354,13.2881]]
	passpal=data([[name,1,2,3
skin,8,7,9
hair,2
shirt,3,6,4
pants,15,14
shoes,11
gray,3,6,4
ltgray,4,3,5
blue,12,1,13
ltblue,13,12,11
green,15,14,5
brown,7,2,7
pink,8,7,9
red,10,7,8
yellow,9,7,5]],"passpal")
	crashquotes=mp(split([[


	whoops!,never mind!,oh dear!,careful!,you have insurance right?
	my spleen!,well that hurt..,try driving around things..,careful!,well the airbags work..]],"\n"),split)

	circuits=data[[name,traffic,stars,waypts
wEST,true,{18:19:22},85:18 82:18 82:15 84:15 84:12 86:12 89:12 89:10 91:10 96:15 96:17 90:17 88:18
dOWNTOWN,true,{26:28:31},107:22 107:24 110:24 110:28 114:28 117:25 117:23 113:23 113:16 114:14 114:8 107:8 107:16
mOT mANOR rALLY,true,{44.75:46:50},65:15 65:10 67:10 69:8 72:8 74:10 77:10 77:16 69:16 68:18 71:18 71:13 74:13 75:16 80:16 80:21 74:21 72:23 68:23 65:20
mARKET lOOP,true,{19:20:23},114:10 110:10 111:14 112:15 119:15 119:20 124:20 124:15 124:10 119:10
tHE fARMS,true,{35:39:50},93:25 88:25 88:28 85:28 85:0 89:0 90:2 90:5 88:5 87:7 95:7 96:6 102:6 108:6 111:3 114:1 114:28 110:28 110:24 101:24 98:25
eAST,true,{10.25:11:13},100:12 103:12 103:14 104:16 104:18 102:19 98:19 98:12
sHORTCUTS,true,{28:30:35},94:17 96:17 98:18 98:19 96:21 92:25 89:25 87:28 81:28 79:27 75:27 73:27 70:23 72:23 75:21 82:21 85:18 88:18 90:17
fLATS,true,{14.3:15:17},68:7 72:7 73:5 70:5 68:3 68:2 70:2 70:0 66:0 65:1 65:3
bIG lOOP,true,{49:52:56},77:8 88:8 94:7 96:6 103:6 107:6 107:8 114:8 114:14 113:16 113:24 106:24 101:24 98:25 89:25 86:25 82:21 75:21 72:23 68:23 65:20 65:14 65:10 68:10 68:8
aLLEYS,true,{31:33:36},107:24 110:24 110:22 113:22 113:24 112:26 114:26 114:28 111:28 109:27 107:27 105:28 103:27 99:24 99:22 98:19 98:15 101:16 104:16 104:17 104:21 104:24]]
	for c in all(circuits) do
		c.waypts=mp(split(c.waypts," "),function(wp)return split(wp,":")end)
	end

    difficulties=data[[name,factor,rate
eASY,2.5,0.02
mEDIUM,5,0.06
hARD,7.5,0.15]]

	-- add in any missing object type widths.
	-- calculate to give 1-1 aspect ratio.
	for typ in all(objtyps) do
		typ.w=typ.w or typ.mw and typ.h*typ.mw/typ.mh
	end

	-- navigation waypoint offsets
	navwp=ptlist"0.3125,0 0.6875,0 1,0.3125 1,0.6875 0.6875,1 0.3125,1 0,0.6875 0,0.3125"
	navwpneighbors=ptlist"0,-1 0,-1 1,0 1,0 0,1 0,1 -1,0 -1,0"
	navwplinks=split"5,4,7,6,1,0,3,2"

	-- create tile map lookups for surfaces
	for surf in all(surftyps) do
		surf.tmap={}
		for t in all(surf.tiles) do
			surf.tmap[t]=true
		end
	end

	-- build navigation data
	nav={}
	for dup in all(navdup) do
		for r,t in ipairs(dup.dups) do
			local tile,adj={spd=dup.spd or 1},(r-1)*2

			-- find base tile navigation data
			for dat in all(navraw) do
				if dat.tile==dup.base then
					add(tile,{
						entry=(dat.entry+adj)%8,
						exit=(dat.exit+adj)%8,
						weight=dat.weight or 1
					})
				end
			end

			nav[t]=tile
		end
	end
end

function initmenu()
	sfx(-1,-2)
	mode,menuoption,vismenuoption="menu",1,1
	gametype%=3
	if gametype==0 then menuitems=split"tAXI dRIVER,sTREET rACE,fREE eXPLORE"
	elseif gametype==1 then menuitems=split"dIFFICULTY,dRIVE,bACK"
	elseif gametype==2 then menuitems=split"cIRCUIT,rACE,bACK"
	end
	transition(tran_circlein)
end

medalnames,medalcols=split"gl,sl,br",split"9,4,7"

function drawmenu()
	cls(1)

	-- car
	local car=objtyps.car2
	pal(carpals.yellow)
	palt(0,true)
	map(car.mx,car.my,64-car.mw*4,40,car.mw,car.mh)
	pal(defpal)

	-- title
	if gametype==0 then
		prettyprint("wHIPLASH",nil,4,9,true,true,true)
		prettyprint("tAXI cO",nil,20,9,true,true,true)
		prettyprint("-MOt",90,30,3)
	else
		prettyprint(gametype==1 and "tAXI dRIVER" or "sTREET rACE",nil,4,9,false,false,true)
		if gametype==1 then
			prettyprint("tOP sCORES fOR "..difficulties[diffi].name,nil,20,5)
			for i,score in ipairs(taxiscores[diffi]) do
				prettyprint(i..") $"..padnum(score,4),nil,i*15+16,lastgametype==gametype and lastdiff==diffi and lastrank==i and 5 or 4,false,false,true)
			end
		else
			local c=circuits[circi]
			prettyprint("tOP tIMES fOR "..c.name,nil,20,5)
			for i,time in ipairs(c.times) do
				prettyprint(i..") "..timestr(time/30,true),nil,i*15+16,lastgametype==gametype and lastcirci==circi and lastrank==i and 5 or 4,false,false,true)
				drawcircstars(time,90,i*15+15)
			end
			for j=1,3 do
				prettyprint(medalnames[j]..":"..timestr(c.stars[j],true),j*43-42,80,medalcols[j],false,false,true)
			end
		end
	end

	-- menu select bar
	local y=90+vismenuoption*8
	rectfill(0,y,128,y+8,12)
	
	-- menu items
	for i,txt in ipairs(menuitems) do
		prettyprint(txt,nil,92+i*8,menuoption==i and 5 or 4,false,false,true)
	end
end

function updatemenu()
    local xi=0
	if(btnp(⬆️))menuoption-=1
	if(btnp(⬇️))menuoption+=1
    if(btnp(⬅️))xi-=1
    if(btnp(➡️))xi+=1
	menuoption=mid(menuoption,1,#menuitems)
	vismenuoption=slideto(vismenuoption,menuoption,1/4)

	if btnp(🅾️) or btnp(❎) then
		if gametype==0 then
			transition(tran_circleout,function()
				gametype=menuoption 
				if gametype==3 then 
					initgame() 
				else
					initmenu() 
				end
			end)
			sfx(38)
		else
			if menuoption==1 then xi=1
			elseif menuoption==2 then
				transition(tran_circleout,initgame)
				sfx(38)
			elseif menuoption==3 then
				transition(tran_circleout,function()gametype=0 initmenu() end)
				sfx(38)
			end
		end
	end
    if menuoption==1 then
        if gametype==1 then
            diffi=(diffi+xi-1)%#difficulties+1
            dset(63,diffi)
        elseif gametype==2 then
            circi=(circi+xi-1)%#circuits+1
            dset(62,circi)
        end
    end    

	if gametype==1 then
		menuitems[1]="dIFFICULTY:"..difficulties[diffi].name
	elseif gametype==2 then
		menuitems[1]="cIRCUIT:"..circuits[circi].name
	end
end

function drawcircstars(time,x,y)
	for j=1,3 do
		if(time/30<circuits[circi].stars[j])spr(90,x+j*10-10,y)
	end
end

-->8
-- object grid

objgridsize=2

function initobjgrid()
	objgrid={}
	for x=0,63\objgridsize do
		local col={}
		for y=0,31\objgridsize do
			add(col,{})
		end
		add(objgrid,col)
	end	  
end

function gridcoords(x,y)
	return x%64\objgridsize+1,y%32\objgridsize+1
end

function addobj(ob)
	local gx,gy=gridcoords(ob.x,ob.y)
	add(objgrid[gx][gy],ob)
end
   
function removeobj(ob)
	local gx,gy=gridcoords(ob.x,ob.y)
	del(objgrid[gx][gy],ob)
end

function spawnobj(typ,x,y,ang)
	local ob={
		x=x,
		y=y,
		h=0,
		typ=typ,
		xd=0,
		yd=0,
		hd=0,
		ang=ang or 0,
		yang=0,
		yspin=0
	}
	if typ==objtyps.car or typ==objtyps.truck then
		ob.pal=rnd(carpals)
	end
	addobj(ob)
	return ob
end

function getmaptyp(x,y)
 -- get texture index
	local t=mget(x&63|64,y&31)-192
	if(t<0)t=3
	
	-- get texture tile
	local tx,ty=(t%16+x%1)*8\1,(t\16+y%1)*8\1
	local m=mget(tx,ty)
	return t,m
end

function getplacename(x,y)
	local nearest,name=10000
	for n in all(placenames) do
		local dx,dy=relpos(n.x,n.y,x,y)
		local dist=length(dx,dy)
		if dist<nearest then
			name=n.name
			nearest=dist
		end
	end
	return name
end

function spawnobjects()
 
	-- lamp posts
	addroadside(64,0,128,32,2,1,"-1,0 1,0 0,-1 0,1",{objtyps.lamp})

	-- barrels
	addroadside(64,0,128,32,1,0.33,"-1,0.75 1,0.75 0.75,-1 0.75,1",{objtyps.barrel,objtyps.barrel,objtyps.booth,objtyps.mailbox,objtyps.mailbox}) 

	-- trees and bushes
	-- blue noise, on grass
	local ttyps,fatyps=arraydata"obj.tree1:obj.tree2:obj.tree3:obj.tree4:obj.bush:obj.bushsml",arraydata"obj.veg:obj.weed"
	local grtiles,fatiles=split"3,4",split"99,115,207"
	for x=64,127,2 do
		for y=0,31,2 do
			for i=1,rnd(5)\1 do
				local ox,oy=x+rnd(2),y+rnd(2)
				t,m=getmaptyp(ox,oy)
				if contains(grtiles,m) then
					spawnobj(rnd(ttyps),ox,oy)
				elseif contains(fatiles,m) then
					spawnobj(rnd(fatyps),ox,oy)
				end
			end
		end
	end

	-- placed
	addspaced({objtyps.table},"85,14 87,12 88,12 80,19 102,18",0.25,3,2)
	addspaced({objtyps.table},"102,18 97,12 70,13 78,25 75,27 115,26.7",0.35,1,2)
	addspaced({objtyps.table},"109.3,13 109.3,11 111,12.5",0.25,2,2)
	addspaced({objtyps.barrel},"105,28 100,16 111,22",0.35,3,2)
	addspaced(arraydata"obj.car:obj.car:obj.truck","97,20.4 77,24 102,26.3 81.5,5",0.35,2,1)
	addspaced(arraydata"obj.car:obj.car:obj.truck","103,20",0.4,2,1)
	addspaced(arraydata"obj.car:obj.car:obj.truck","88.4,10 111,20 109,18",0.35,1,2,-0.25)
	addspaced({objtyps.truck},"87,27",0.35,2,1)
	addspaced({objtyps.car},"123,19",0.35,2,1)
	addspaced({objtyps.mailbox},"102,21.8 88,1",0.25,2,2)
	addspaced({objtyps.veg},"110,1 87,22 83,30",0.25,2,2)
end

function spawnpassengers()
	pass={}
	local passobjtyps=arraydata"obj.person1:obj.person2:obj.person3:obj.person4:obj.person5:obj.person6:obj.person7:obj.person8"
	local mpals=arraydata"passpal.skin:passpal.shirt:passpal.pants:passpal.shoes:passpal.hair"
	local skinpals=arraydata"passpal.pink:passpal.brown"
	local hairpals=arraydata"passpal.blue:passpal.brown:passpal.gray:passpal.yellow:passpal.hair"
	local clothpals=arraydata"passpal.gray:passpal.ltgray:passpal.blue:passpal.ltblue:passpal.green:passpal.red:passpal.yellow"
	for pdat in all(passdata) do
		-- build random palette
		local ppal={}

		-- loop through materials
		for mpal in all(mpals) do
			-- choose random colour for each
			local cpal=clothpals
			if mpal==passpal.skin then cpal=skinpals 
			elseif mpal==passpal.hair then cpal=hairpals 
			end
			local cpal=rnd(cpal)
			-- assign to palette slots
			for i,m in ipairs(mpal) do
				ppal[m]=cpal[i]
			end
		end

		-- create passenger object
		local p={
			obj=spawnobj(rnd(passobjtyps),pdat.x,pdat.y),
			arrowobj=spawnobj(objtyps.arrow,pdat.x,pdat.y),
			tx=pdat.tx,
			ty=pdat.ty
		}
		p.obj.pal=ppal
		p.obj.passenger=p
		add(pass,p)
	end	
end

local rtex=split"0,1,16,17,18,32,33,34,48,49,50"

function isvalidroadside(x,y,dx,dy)
	local ox,oy=x+dx*0.4375,y+dy*0.4375
	local nx,ny=x,y
	if abs(dx)>abs(dy) then
		nx+=sgn(dx)
	else
		ny+=sgn(dy)
	end
	local t,m=getmaptyp(ox,oy)
	local nt=getmaptyp(nx,ny)
 	return contains(rtex,t) and m==16 and nt<56,ox,oy
end

function addroadside(x0,y0,x1,y1,s,r,offs,typs)
	offs=ptlist(offs)
	for x=x0+0.5,x1-0.5,s do
		for y=y0+0.5,y1-0.5,s do
			for o in all(offs) do
				if rnd(1)<=r then
					local valid,ox,oy=isvalidroadside(x,y,o[1],o[2])
					if valid then
						spawnobj(rnd(typs),ox,oy)
					end
				end
			end
		end
	end
end

function addspaced(typs,locs,s,w,h,ang)
 s&=0xffff.fffe
	locs=ptlist(locs)
	for loc in all(locs) do
		for x=loc[1]+0.5-s*(w-1)/2,loc[1]+0.5+s*(w-1)/2,s do
			for y=loc[2]+0.5-s*(h-1)/2,loc[2]+0.5+s*(h-1)/2,s do
				spawnobj(rnd(typs),x,y,ang)
			end
		end		
	end
end

function spawncircuitwaypts(c)
	circuitwaypts={}
	for i,wp in ipairs(c.waypts) do
		local wpn=c.waypts[i%#c.waypts+1]
		local waypt=spawnobj(i==1 and objtyps.flag or objtyps.waypt,wp[1]+0.5,wp[2]+0.5,aimat(wpn[1],wpn[2],wp[1],wp[2]))
		waypt.h=-0.25
		add(circuitwaypts,waypt)
	end	
end

-->8
-- rendering

basetline=tline
skewedtline=function(x,y,x1,y1,mx,my,mdx,mdy,layers)
	basetline(x,y+x*skew,x1,y1+x1*skew,mx,my,mdx,mdy,layers)
end

prvx,prvy=0,0

function toggletilt()
	local txt
	if tline==basetline then
		tline=skewedtline
		txt="tilt:on"
	else
		tline=basetline
		txt="tilt:off"
	end
	menuitem(2,txt,toggletilt)
end

function drawscene(x,y,h,ang)
	camera(-64,-vany)
	drawground(x,y,h,ang)
	drawbuildings(x,y,h,ang)
	drawobjects(x,y,h,ang)
end

function drawground(x,y,h,ang)
	poke(0x5f36,8) -- tile 0 not "empty" 
	palt(0,false)
	local s,c=sin(ang),cos(ang)

	-- iterate scanlines
	for scany=1,128-vany do
	
		-- distance to ground intercept  	 
		local d=-h*sdist/scany		
		if d<farz then
		
			-- find map coords for left and
			-- right hand side of screen
			local x0,y0=rotate(-vvgrad*d,-d,s,c)
			local x1,y1=rotate( vvgrad*d,-d,s,c)
			x0+=x y0+=y x1+=x y1+=y
			groundscanline(scany,x0,y0,x1,y1)
		end
	end
end

function groundscanline(scany,x0,y0,x1,y1)

	-- key map delta per pixel
	-- and texture delta per pixel
	local dx,dy=(x1-x0)/128,(y1-y0)/128
	local tdx,tdy=(x1-x0)/16,(y1-y0)/16
	local dlen=length(dx,dy)

	-- avoid divide by 0
	if(abs(dx)<0.0001)dx=0.0001
	if(abs(dy)<0.0001)dy=0.0001

	-- start from pt 0
	local x,y,scanx=x0,y0,-64
	setgroundtex(x,y)

	-- initial horizontal intercept
	local hx,hy,hdx,hdy=x,y,sgn(dx),dy/abs(dx)
	local hdz,hz=length(hdx,hdy)/dlen,scanx

	local hstep=hx%1
	if(hdx>0)hstep=(1-hstep)
	hx+=hdx*hstep
	hy+=hdy*hstep
	hz+=hdz*hstep		
	if(hdx<0)hx-=1 

	-- initial vertical intercept
	local vx,vy,vdx,vdy=x,y,dx/abs(dy),sgn(dy)
	local vdz,vz=length(vdx,vdy)/dlen,scanx
	 
	local vstep=vy%1
	if(vdy>0)vstep=(1-vstep)
	vx+=vdx*vstep
	vy+=vdy*vstep
	vz+=vdz*vstep
	if(vdy<0)vy-=1 
	
	-- render spans
	x*=8 y*=8
	while scanx<64 do

		local tx,ty,nscanx

		-- is closest intercept horizontal or vertical?
		if hz<vz then
			-- horizontal
			tx,ty,nscanx=hx,hy,hz

			hx+=hdx
			hy+=hdy
			hz+=hdz
		else
			-- vertical
			tx,ty,nscanx=vx,vy,vz

			vx+=vdx
			vy+=vdy
			vz+=vdz
		end

		-- render line segment
		nscanx=ceil(nscanx)
		if nscanx>scanx then
			clip(scanx+64,0,nscanx-scanx,128)
			-- local adj=-64-scanx
			tline(-64,scany,64,scany,x,y,tdx,tdy)

			-- tline(scanx,scany,nscanx-1,scany,x,y,tdx,tdy)
			-- x+=tdx*(nscanx-scanx)
			-- y+=tdy*(nscanx-scanx)
			scanx=nscanx
		end
		setgroundtex(tx,ty)
	end
	clip()
end

function setgroundtex(x,y)
	
	-- map cell contains texture
	local m=mget(x&63|64,y&31)-192
	if(m<0)m=3

	local tx,ty=m%16,m\16

	settex(tx,ty)
end

function settex(tx,ty)
	-- select 8x8 texture
	poke(0x5f3a,tx*8)
	poke(0x5f3b,ty*8)
	poke2(0x5f38,0x0808) -- always 8x8 map section
end

function drawmap(x,y)
	x%=64 y%=32
	palt(0,false)
	camera(-16,-112)
	clip(0,96,32,32)
	for ox=-512,0,512 do
		for oy=-256,0,256 do
			map(64,0,ox-x*8,oy-y*8,64,32)
		end
	end
	clip()
	camera()
	circfill(16,112,1,10)
end

function drawbuildings(x,y,h,ang)
	palt(0,false)
	poke4(0x5f38,0) -- no texture repeat
	local sa,ca=sin(ang),cos(ang)
	for scanx=-64,63 do
		local maxy=128-vany
		local dx,dy=rotate(scanx,-sdist,sa,ca)
		if(abs(dx)<0.01)dx=0.01
		if(abs(dy)<0.01)dy=0.01
			
		local hx,hy,hdx,hdy=x,y,sgn(dx),dy/abs(dx)
		local hdz,hz=-hdx*sa-hdy*ca,0
			
		local hstep=hx%1
		if(hdx>0)hstep=(1-hstep)
		hx+=hdx*hstep
		hy+=hdy*hstep
		hz+=hdz*hstep		
		if(hdx<0)hx-=1 
			
		local vx,vy,vdx,vdy=x,y,dx/abs(dy),sgn(dy)
		local vdz,vz=-vdx*sa-vdy*ca,0
		 
		local vstep=vy%1
		if(vdy>0)vstep=(1-vstep)
		vx+=vdx*vstep
		vy+=vdy*vstep
		vz+=vdz*vstep
		if(vdy<0)vy-=1 

  		zbuf[scanx]=farz
		local z,u=0
		while z<farz do
			local m
			if hz<vz then
				m,z,u=mget(hx&63|64,hy&31),hz,hy
				hx+=hdx
				hy+=hdy
				hz+=hdz
			else
				m,z,u=mget(vx&63|64,vy&31),vz,vx
				vx+=vdx
				vy+=vdy
				vz+=vdz
			end
			if m>=248 then
				local b=bldtyps[m-247]

				u=(u*8)%b.mw

				-- project to get y and height
				local scale=sdist/z
				local y1,sh=-h*scale,b.mh/8*scale
				local y0=y1-sh

				-- texture delta
				local mdy=b.mh/sh

				-- sub-pixel adjustments
				local py0=y0
				y0,y1=max(ceil(y0),-vany),min(ceil(y1),maxy)
				if y1>y0 then
					local v=(y0-py0)*mdy

					-- render tline
					tline(scanx,y0,scanx,y1-1,b.mx+u,b.my+v,0,mdy) 

					-- write to z buffer
					zbuf[scanx]=min(zbuf[scanx],z)

					-- exit while loop
					maxy=y0
					if(maxy<=-vany)z=10000
				end
			end
		end	   
	end
end

function drawobjects(x,y,h,ang)
	-- transform and sort
	local sobj=transformobjects(x,y,h,ang)

	-- render
	palt(0,true)
	poke(0x5f36,0) -- tile 0 "empty" 
	for ob in all(sobj) do
		local typ,flipx=ob.typ,false
		
		-- handle multi-frame objects
		if typ.frames then
			local ang=-aimat(ob.x,ob.y,x,y)+ob.ang
			typ,flipx=getspriteframe(typ,ang)
		end

		-- project
		local scale=sdist/ob.ry
		local px,py=ob.rx*scale,ob.rh*scale
		local w,h=typ.w/8*scale,typ.h/8*scale

		-- bounds
		local x0,x1=px-w/2,px+w/2
		local y0,y1=py-h,py

		-- texture delta
		local mdx,mdy=typ.mw/w,typ.mh/h
		local u,v=typ.mx,typ.my
		if(flipx)       mdx=-mdx u+=typ.mw-0.0001
		if(ob.yang&1==1)mdy=-mdy v+=typ.mh-0.0001		

		-- clip and adj texture coords
		local ox0,oy0=x0,y0
		x0,y0=max(ceil(x0),-64),max(ceil(y0),-vany)
		x1,y1=min(ceil(x1), 64),min(ceil(y1),128-vany)
		u+=(x0-ox0)*mdx
		v+=(y0-oy0)*mdy

		-- render vertical spans
		if x1>x0 and y1>y0 then
			if(ob.pal)pal(ob.pal)
			for sx=x0,x1-1 do
			 	if ob.ry<zbuf[sx] then
					tline(sx,y0,sx,y1-1,u,v,0,mdy)
				end
				u+=mdx
			end
			if(ob.pal)pal(defpal)
		end
	end
end

function transformobjects(x,y,h,ang)
	local sa,ca=sin(-ang),cos(-ang)
	local sobj={} -- sorted objs

	-- iterate object grid around player
	for ob in all(getnearobjects(x,y,farz)) do

		-- camera relative position
		local rx,ry=relpos(ob.x,ob.y,x,y)
		local rh=ob.h-h

		-- near camera?
		if abs(rx)<farz and abs(ry)<farz then

			-- transform into camera space
			rx,ry=rotate(rx,ry,sa,ca)
			ry=-ry
			ob.rx,ob.ry,ob.rh=rx,ry,rh

			-- in view?
			if ry>=0.1 and ry<farz and abs(rx)-ob.typ.rad<ry*vvgrad then
				-- insertion sort based on ry
				add(sobj,ob)
				local i=#sobj
				while i>1 and sobj[i-1].ry<ry do
					sobj[i]=sobj[i-1]
					i-=1
				end
				sobj[i]=ob
			end
		end
	end

	return sobj
end

function showmessage(msg)
	if msg and msg~="" then
		add(msgq,msg)
	end
end

function drawmessages()
	if #msgq>0 then
		-- ease message in/out
		local x=0
		if msgx>=2 then
			x=2-msgx
		elseif msgx<=1 then
			x=1-msgx
		end
		x=sgn(x)*(abs(x)^2.5)
		local txt=msgq[1]
		prettyprint(txt,64-#txt*2+x*(64+#txt*2),120,9)

		-- next message in queue?
		msgx+=0.035
		if msgx>=3 then
			deli(msgq,1)
			msgx=0
		end
	end
end

function drawpassengerui()
	local p=player.passenger

	-- destination
	prettyprint(player.destname,nil,10,5)

	-- portrait
	pal(p.obj.pal)
	palt(0,true)
	map(p.obj.typ.mx,p.obj.typ.my,33,112,2,2)		
	pal(defpal)

	-- fare
	if(gametype==1)prettyprint("$"..padnum(player.fare,3),34,105,10)

	-- destination indicator
	drawdestindicator(p.tx,p.ty,passdropoff)
end

function drawhud()
	-- speedo
	for s=0,100,10 do
		speedoline(s,s%50==0 and 30 or 37,40,5)
	end
	prettyprint("\^t\^w"..padnum(abs(speed),3),105,105,5)
	circfill(127,127,10,2)
	speedoline(abs(speed),8,40,9,1)
	circfill(127,127,8,10)

	if gametype==1 then
		-- score
		prettyprint("\^t$"..padnum(displayedscore,4),107,2,10)

		-- time
		prettyprint("\^t"..timestr(ceil(timer/30)),2,2,9)
	elseif gametype==2 then
		prettyprint("\^t"..timestr(player.lapt/30,true),2,2,9)
		if player.lap>1 then
			prettyprint("last:"..timestr(player.laptlast/30,true),2,14,5)
			prettyprint("best:"..timestr(player.laptbest/30,true),2,22,5)
			drawcircstars(player.laptbest,98,2)
		end
	end
end

function speedoline(speed,d0,d1,col,thick)
	local ang=speed*0.0025
	local s,c=sin(ang),cos(ang)
	if thick then
		thickline(128-c*d0,128+s*d0,128-c*d1,128+s*d1,thick,col)
	else
		line(128-c*d0,128+s*d0,128-c*d1,128+s*d1,col)
	end
end

function drawdestindicator(tx,ty,stopdist)

	-- destination indicator
	camera(-64,-vany)
	local x,y=relpos(tx,ty,player.x,player.y)
	x,y=rotate(x,y,sin(-player.ang),cos(-player.ang))
	y=-y
	local px,py
	if abs(x)<vvgrad*y then
		-- project
		local scale=sdist/y
		px,py=x*scale,-camyoffs*scale
		spr(11,px-4,py-4)
	else
		px,py=sgn(x)*60,0
		spr(12,px-4,py-4,1,2,x<0)
	end

	-- distance indicator
	local d=length(x,y)
	local txt=d>stopdist and (d*mperu\1).."m" or "stop!"
	local w=#txt*2
	px=mid(px,-64+w+1,64-w-1)
	prettyprint(txt,px-w,py-10,5)

	camera()
end

-->8
-- gameplay

f_air,brake,enginemax,accelf,steerf=0.01,0.005,0.4,0.002,0.35
gravity=0.002
maxcars=12
passpickup,passdropoff=0.5,0.7

function simulatecar(car,xiraw,yiraw)
	local x,y,xd,yd,ang,slide,xi,yi=car.x,car.y,car.xd,car.yd,car.ang,car.slide,car.xi,car.yi

	-- steering input
	if xiraw>0 then 
		xi+=xi>=0 and st or stback
	elseif xiraw<0 then 
		xi-=xi<=0 and st or stback
	else
		xi=slideto0(xi,stcent)
	end
	xi=mid(xi,-1,1)

	-- acceleration/braking input
	yi=yi*0.7+yiraw*0.3

	-- get surface under car
	local t,m=getmaptyp(x,y)
	local surf=surftyps.grass
	for s in all(surftyps) do
		if(s.tmap[m])surf=s
	end

	-- air friction applied to overall velocity
	-- proportional to vel^2
	local vel2=xd*xd+yd*yd
	local fair=-vel2*f_air	-- todo

	-- convert vel to car space
	local cxd,cyd=rotate(xd,yd,sin(-ang),cos(-ang))

	-- target velocity (in car space)
	local txd,tyd=0,cyd

	-- rolling friction
	tyd-=cyd*surf.f_roll

	-- accelerate/brake
	local accel=(1-abs(cyd)/enginemax)*accelf
	if abs(cyd)>0.002 then 
		car.dir=sgn(cyd)
	elseif yiraw==0 then		-- must release input in order to change direction
		car.dir=0
	end
	if car.dir>=0 and yi>0
	or car.dir<=0 and yi<0 then
		tyd+=yi*accel
	else
		tyd+=yi*brake
		if(sgn(tyd)==-car.dir)tyd=0 yi=0
	end

	local pcxd,pcyd=cxd,cyd

	-- apply friction
	local fr=slide and surf.f_slide or surf.f_grip
	cxd,cyd=slideto(cxd,txd,fr),slideto(cyd,tyd,fr)
	slide=cxd~=txd or cyd~=tyd
	setslidesfx(slide and surf.slidesfx or -1)

	if car==player then
		nskew+=(cxd-pcxd)*-20
		nvany+=(cyd-pcyd)*-3000+(rnd(2)-1)*surf.shake*cyd*35
	end

	-- convert back to world space
	xd,yd=rotate(cxd,cyd,sin(ang),cos(ang))

	-- update position
	x+=xd y+=yd

	-- steering
	ang-=cyd*xi*steerf

	car.xd,car.yd,car.ang,car.slide,car.xi,car.yi=xd,yd,ang,slide,xi,yi
	return cyd
end

function setslidesfx(s)
	if slidesfx~=s then
		slidesfx=s
		sfx(s,2)
	end
end

function collidesfx(i)
	i=mid(ceil(i),0,4)
	if i>colsfxi then
		if(i>0)sfx(15-i,3)
		colsfxi=i
		colsfxtimer=i>1 and 10 or 2
		if(i>=1 and player.passenger and #msgq<=1 and rnd()<i*0.2)showmessage(rnd(crashquotes[i]))
	end
end

function moveobject(obj)
	local pxd,pyd,rad,bounce=obj.xd,obj.yd,obj.typ.rad/8,-obj.typ.bounce
	local xok,yok=true,true
	if issolidcollision(obj.x+obj.xd,obj.y+obj.yd,rad) then
		local xcol,ycol=issolidcollision(obj.x+obj.xd,obj.y,rad),issolidcollision(obj.x,obj.y+obj.yd,rad)
		xok=ycol and not xcol
		yok=xcol and not ycol
	end
	if xok then obj.x+=obj.xd else obj.xd*=bounce end
	if yok then obj.y+=obj.yd else obj.yd*=bounce end

	obj.h+=obj.hd
	if obj.h>0 then
		obj.h=0
		obj.hd=abs(obj.hd)*bounce
	end

	-- collision sfx
	if obj==player then
		collidesfx((abs(obj.xd-pxd)+abs(obj.yd-pyd))*40)
	end
end

function issolidcollision(x,y,size)
	return isbuildingcollision(x,y,size) or issolidobjcollision(x,y,size)
end

function isbuildingcollision(x,y,size)
	for gx=(x-size)\1,(x+size)\1 do
		for gy=(y-size)\1,(y+size)\1 do
			if(mget(gx&63|64,gy&31)>=248)return true
		end
	end
end

function issolidobjcollision(x,y,size)
	for ob in all(getnearobjects(x,y,size+0.2)) do
		if ob.typ.mass==0 and ob.typ.rad>0 then
			local xd,yd=relpos(ob.x,ob.y,x,y)
			if abs(xd)<size+ob.typ.rad/8 and abs(yd)<size+ob.typ.rad/8 then
				return true
			end					
		end
	end
end

function doobjectcollisions(obj)
	local typ=obj.typ
	for other in all(getnearobjects(obj.x,obj.y,typ.rad/8+0.5)) do
		local otyp=other.typ
		g={other=other,otyp=otyp}
		if otyp.rad>0 and otyp.mass>0 and other.h>=obj.h-typ.h/8 and other.h-otyp.h/8<=obj.h then

			-- find relative position
			local xd,yd=relpos(other.x,other.y,obj.x,obj.y)
			local d=length(xd,yd)

			-- less than added radius?
			if d<typ.rad/8+otyp.rad/8 then

				-- potential collision normal (approximated)
				local h,oh=obj.h+typ.hoffs/8,other.h+otyp.hoffs/8
				local hd=oh-h
				d=sqrt(xd*xd+yd*yd+hd*hd)
				local nx,ny,nh=xd/d,yd/d,hd/d

				-- relative velocity
				local vx,vy,vh=obj.xd-other.xd,obj.yd-other.yd,obj.hd-other.hd

				-- dot product with "normal" to determine if objects are moving 
				-- towards each other
				local dot=nx*vx+ny*vy+nh*vh
				if dot>0 then

					-- velocity change based on relative masses
					-- (not real physics!)
					local tmass=typ.mass+otyp.mass
					local dv=otyp.mass/tmass*2*0.8*dot
					local dvo=typ.mass/tmass*2*0.8*dot

					-- apply collision to objects
					objectcollision(obj,dv,nx,ny,nh)
					objectcollision(other,dvo,-nx,-ny,-nh)

					-- activate other object
					if not other.isactive then
						other.isactive=true
						add(activeobj,other)
					end

					if(obj==player)collidesfx(dot*30)
				end				
			end
		end
	end
end

function objectcollision(obj,dv,nx,ny,nh)
	-- update velocity
	obj.xd-=nx*dv
	obj.yd-=ny*dv
	obj.hd-=nh*dv

	-- set object yspin
	obj.yspin=(obj.typ.yspinf or 0)*dv*250*abs(nh)

	-- special logic for cars
	if obj.iscar then
		obj.stun=abs(dv)*4000
	end	
end

function moveactiveobjects()
	local objs=activeobj
	activeobj={}

	-- remove objects from game
	for o in all(objs) do
		removeobj(o)
	end

	-- move objects one-by-one, and add back to game
	local i=1
	while i<=#objs do
		local o,keep=objs[i]
		if o.iscar then
			keep=movecar(o)
			if(not keep)carct-=1
		else
			keep=moveactiveobject(o)
		end
		if keep then
			-- add object back into game
			addobj(o)
			i+=1
		else
			deli(objs,i)
		end
	end
end

function moveactiveobject(o)
	moveactiveobjectmain(o)

	if o.isactive then
		-- move object and apply collisions
		doobjectcollisions(o)
		moveobject(o)

		-- object is still active
		add(activeobj,o)
	end

	return true
end

function moveactiveobjectmain(o)
	-- gravity and ground friction
	if o.h<0 then
		-- gravity
		o.hd+=gravity
		-- spin
		o.yang+=o.yspin
	else
		-- ground friction
		local f=0.005
		local v=length(o.xd,o.yd)
		if v<f then
			o.xd,o.yd=0,0
		else
			-- adjust velocity
			local factor=(v-f)/v
			o.xd*=factor
			o.yd*=factor
		end
	end

	-- has object come to rest?
	if o.h==0 and o.xd==0 and o.yd==0 and abs(o.hd)<0.01 then
		o.hd,o.isactive,o.yspin=0,false,0
	end
end

function movecar(car)

	-- remove cars when outside car region
	local pdx,pdy=relpos(car.gx\1,car.gy\1,player.x\1,player.y\1)
	if(max(abs(pdx),abs(pdy))>carregionsize)return false

	if car.stun>0 then

		-- move car like a regular object
		moveactiveobjectmain(car)
		if not car.isactive then
			-- car has come to rest
			-- car can recover if not too far from waypoint
			local angd,wpdist=getcaraiinfo(car)
			if(wpdist<1.15 and abs(angd)<0.25)car.stun-=1
		end
	else
		if(not cardrivingai(car))return false
	end

	-- move object and apply collisions
	doobjectcollisions(car)
	moveobject(car)

	-- object is still active
	car.isactive=true
	add(activeobj,car)

	return true
end

function getcaraiinfo(car)
	local tx,ty=wayptpos(car.gx,car.gy,car.exit)
	local ang,dx,dy=aimat(tx,ty,car.x,car.y)
	local angd=(ang-car.ang)%1
	if(angd>0.5)angd-=1
	return angd,length(dx,dy)
end

function cardrivingai(car)

	-- turn towards target
	local angd,wpdist=getcaraiinfo(car)
	car.ang=slideto(car.ang,car.ang+angd,0.015)
	car.xd,car.yd=-sin(car.ang)*0.025*car.spd,-cos(car.ang)*0.025*car.spd

	-- if reached target, transition to next tile
	if wpdist<0.15 then

		-- find corresponding entrypt on neighbouring tile
		local noffs=navwpneighbors[car.exit+1]
		car.gx+=noffs[1] car.gy+=noffs[2]
		car.entry=navwplinks[car.exit+1]

		-- get navigation info for tile
		local t=getmaptyp(car.gx,car.gy)
		local paths=nav[t]

		if not paths then
			-- todo
			return false
		else
			-- choose next exit
			local validpaths,weight={},0
			for p in all(paths) do
				if(p.entry==car.entry)add(validpaths,p) weight+=p.weight
			end
			if(#validpaths==0)validpaths=paths

			-- weighted random select from valid paths
			local r,i=rnd(weight),1
			while r>validpaths[i].weight do
				r-=validpaths[i].weight
				i+=1
			end
			car.exit,car.spd=validpaths[i].exit,paths.spd
		end
	end

	return true
end

function spawncar(gx,gy,entry,exit)
	local x,y=wayptpos(gx,gy,entry)
	local tx,ty=wayptpos(gx,gy,exit)
	local car=spawnobj(rnd({objtyps.car,objtyps.car,objtyps.truck}),x,y)
	car.gx,car.gy,car.entry,car.exit=gx,gy,entry,exit
	car.ang=atan2(y-ty,x-tx)
	car.isactive,car.iscar,car.spd,car.stun=true,true,1,0
	add(activeobj,car)
	carct+=1
end

carregionsize=8

function updatecarregion() 

	-- new region size
	local x0,y0=player.x\1-carregionsize,player.y\1-carregionsize
	local x1,y1=player.x\1+carregionsize,player.y\1+carregionsize

	-- spawn cars in new region
	if x0~=cx0 or y0~=cy0 or x1~=cx1 or y1~=cy1 then
		for x=x0,x1 do
			for y=y0,y1 do
				if carct<maxcars and (x<cx0 or x>cx1 or y<cy0 or y>cy1) and rnd(10)<1 then
					local t=getmaptyp(x,y)
					local paths=nav[t]
					if paths then
						local path=rnd(paths)
						spawncar(x,y,path.entry,path.exit)
					end
				end
			end
		end
	end

	cx0,cy0,cx1,cy1=x0,y0,x1,y1
end

function updatepassengers()
	local stopped,arrowh=player.xd==0 and player.yd==0,-0.35+sin(frame/30)*0.05

	for p in all(pass) do
		if p.atdest then
			-- passengers at their destination disappear once
			-- out of car region
			local pdx,pdy=relpos(p.obj.x\1,p.obj.y\1,player.x\1,player.y\1)
			if max(abs(pdx),abs(pdy))>carregionsize then
				removeobj(p.obj)
				del(pass,p)
			end
		else		
			-- animate arrows
			p.arrowobj.h=arrowh

			-- ensure they follow the passenger (as passenger can be moved by collisions)
			if p.obj.isactive then
				removeobj(p.arrowobj)
				p.arrowobj.x,p.arrowobj.y=p.obj.x,p.obj.y
				addobj(p.arrowobj)
			end
		end
	end

	if stopped then
		local p=player.passenger
		if p then
			-- drop off passenger
			local dx,dy=relpos(p.tx,p.ty,player.x,player.y)
			if length(dx,dy)<passdropoff then
				-- put player object back in game
				p.obj.x,p.obj.y,p.atdest=p.tx,p.ty,true
				add(pass,p)
				addobj(p.obj)

				-- remove from car
				player.passenger=nil
				showmessage(rnd({"thanks!","thank you!","later!"}))
				sfx(17,3)

				if gametype==1 then
					-- update score				
					player.score+=player.fare\1
					showmessage("$"..tostr(player.fare\1).." earned")
				end
			end		
		else
			-- pickup passengers		
			for ob in all(getnearobjects(player.x,player.y,passpickup)) do
				local p=ob.passenger
				if p and not p.atdest and not p.obj.isactive and not player.passenger then
					local dx,dy=relpos(ob.x,ob.y,player.x,player.y)
					if length(dx,dy)<passpickup then
						
						-- pickup passenger
						player.passenger=p

						-- remove passenger object
						removeobj(p.obj)
						removeobj(p.arrowobj)
						del(pass,p)

						-- display requested destination
						local name=getplacename(p.tx,p.ty)
						player.destname="to: "..name
						showmessage(rnd({"hi driver.","hello.","hey there.",""}))
						showmessage(name.." please.")
						showmessage(rnd({"","and step on it!","i'm in a hurry."}))

						-- calculate initial fare
						dx,dy=relpos(p.tx,p.ty,ob.x,ob.y)
						player.fare=length(dx,dy)*difficulties[diffi].factor
						
						sfx(17,3)
					end
				end
			end			
		end
	end
end

function updatescore()
 if frame%3==0 and displayedscore<player.score and colsfxtimer==0 then
  sfx(15,3)
 end
	displayedscore=slideto(displayedscore,player.score,mode=="game" and 2 or 5)
end

function loadscores()
	local datai=0
	taxiscores={}
	for d=1,3 do
		local scores={}
		for i=1,3 do
			local score=dget(datai)
			datai+=1
			add(scores,score==0 and 100*d or score) 
		end
		add(taxiscores,scores)
	end
	for c in all(circuits) do
		c.times={}
		for i=1,3 do
			local time=dget(datai)
			datai+=1
			add(c.times,time==0 and (c.stars[3]+5*i)*30 or time)
		end
	end
end

function savescores()
	local datai=0
	for taxiscore in all(taxiscores) do
		for score in all(taxiscore) do
			dset(datai,score)
			datai+=1
		end
	end
	for c in all(circuits) do
		for time in all(c.times) do
			dset(datai,time)
			datai+=1
		end
	end
end

-->8
-- routines

glob={
	["true"]=true,
	["false"]=false
}

-- like map in javascript
function mp(array,fn)
	local r={}
	for e in all(array) do
		add(r,fn(e))
	end
	return r
end

function fixval(v)
	if v=="" then
		return nil
	elseif type(v)=="string" and v[1]=="{" then
	 	return arraydata(sub(v,2,#v-1))
	elseif glob[v]~=nil then
		return glob[v]
	end
	return v
end

function arraydata(str)
	return mp(split(str,":"),fixval)
end

function data(str,globname)
	local lines=split(str,"\n")
	local props,d=split(deli(lines,1)),{}
	for l in all(lines) do
		local o,v={class=globname},split(l)
		for i=1,#v do
			o[props[i]]=fixval(v[i])
		end
		add(d,o)
		if o.name then
			d[o.name]=o.idx or o
			if(globname)glob[globname.."."..o.name]=o.idx or o
		end
	end
	return d
end

function contains(a,e)
 for ae in all(a) do
  if(ae==e)return true
 end
end

function slideto0(v,d)
	return abs(v)<d and 0 or (v-sgn(v)*d)
end

function slideto(v,t,d)
	return t+slideto0(v-t,d)
end

function getnearobjects(x,y,dist)
	local obj={}
	for gx=(x-dist)\objgridsize,(x+dist)\objgridsize do
		for gy=(y-dist)\objgridsize,(y+dist)\objgridsize do
			for ob in all(objgrid[gx%(64/objgridsize)+1][gy%(32/objgridsize)+1]) do
				add(obj,ob)
			end
		end
	end
	return obj
end

function relpos(x,y,bx,by)
	local xd,yd=(x-bx)%64,(y-by)%32
	if(xd>32)xd-=64
	if(yd>16)yd-=32
	return xd,yd
end

function ptlist(txt)
	return mp(split(txt," "),split)
end

function wayptpos(gx,gy,wpi)
	local wp=navwp[wpi+1]
	return gx+wp[1],gy+wp[2]
end

function prettyprint(text,x,y,col,wide,tall,fancy)
	x=x or 64-#text*(wide and 4 or 2)
	if(wide)text="\^w"..text
	if(tall)text="\^t"..text
	if fancy then
		for px=x-1,x+1 do
			for py=y-1,y+1 do
				print(text,px,py,0)
			end
		end
	else
		print(text,x,y+1,0)
	end
	print(text,x,y,col)
end

function thickline(x0,y0,x1,y1,thick,col)
	local xd,yd
	if abs(x1-x0)>abs(y1-y0) then
		xd,yd=0,1
	else
		xd,yd=1,0
	end
	for i=-thick,thick do
		line(x0+i*xd,y0+i*yd,x1+i*xd,y1+i*yd,col)
	end
end

function padnum(n,dp)
	local txt=tostr(n\1)
	return sub("0000000000",1,dp-#txt)..txt
end

function getspriteframe(typ,ang)
	local framei,flipx=(ang*8+0.5)\1%8
	if framei>4 then
		framei=8-framei
		flipx=true
	end
	if(framei==3)flipx=not flipx	-- frame 3 already flipped due to sprite constraints

	return typ.frames[framei+1],flipx
end

function aimat(tx,ty,x,y)
	local dx,dy=relpos(tx,ty,x,y)
	return atan2(-dy,-dx),dx,dy
end

function timestr(sec,includems)
	local str=tostr(sec\60)..":"..padnum(sec%60,2)
	if(includems)str..="."..padnum(sec%1*100,2)
	return str
end


-->8
-- trig

function length(x,y)
	local d=max(abs(x),abs(y))
	x/=d y/=d
	return sqrt(x*x+y*y)*d
end

function normalise(x,y)
	local l=length(x,y)
	return x/l,y/l
end

function rotate(x,y,s,c)
	return c*x+s*y,-s*x+c*y
end

__gfx__
eeeeeeee4444444444444444eeeeeeee04b5b4002222222222222222bbbbbbbbbbbbbb43bbbbbbbbbb34c34baa0000aaa0000000666666622222222222222226
eeeeeeee4333333333333332eeeeeeee34b5b4362666666666666666bbbbbbbbbbbbbb43bbb33bbbbb34c34b2aa00aa2aa0000006bbb55522777772222227772
eefeeeee4333333333333332eeeee4ee34b5b43626cccccccccccc26bbbbbbbbbbbbb443bb3543bbbb34c34b02aaaa20aaa000006bb555b27777777777777772
eeeeeeee4333333333333332eeeeeeee34b5b43626cddddcccdddb26bbbbbbbbbbbbb443bb34c34bbb34c34b002aa200aaaa00006b555bb27777777777777772
eeeeeeee4333333333333332eeeeeeee34b5b43626cdddcccdddbb26bbbbbbbbbbbbb443bb34c34bbb34c34b00aaaa00aaaaa0006555bbb22222277772222772
eeeeeeee4333333333333332eeeeeeee34b5b43626cddcccdddbbb26444bbb44bbb444434434c3444434c3440aa22aa0aaaaaa00655bbbb22222222222222226
eeeeefee4333333333333332eeeeeeee334b433626cdcccdddbbbb2644444444444444434434c3444434c344aa2002aaaaaaaaa065bbbbb26662226666666666
eeeeeeee4333333333333332eeeeeeee3000003626ccccdddbbbbd2633333333333333333334c3333334c33322000022aaaaaaaa222222226666666666666666
444444444333333333333332444444444444442626cccdddbbbbdd266785587887772c26bb34c343bb34c3432aaaaaaaaaaaaaa2aaaaaaaa300000000000000f
433333324333333333333332444444444444442626ccdddbbbbddd260627877272261660bb34c343bb34c34302aaaaaaaaaaaa20aaaaaaaae00000000000000f
433333324333333333333332444444444444422626cdddbbbbdddd26067858878772c260bb34c343bb34c343002aaaaaaaaaa200aaaaaaaae3000000000000ee
433333324333333333333332444444444444422626cddbbbbddddd26067858878772c260bb34c343bb34c3430002aaaaaaaa2000aaaaaaaae00000000000000e
433333324333333333333332444444444444422626cdbbbbdddddd26067858878772c260bb3cc343bb34c34300002aaaaaa20000aaaaaaaa3030000000000eff
43333332433333333333333222244422444222267777777777777777067858878772c260bbb33443bb34c343000002aaaa200000aaaaaaaae0e00000000000ef
43333332433333333333333222222222222222267777777777777777067858878772c260444444434434c3430000002aa2000000aaaaaaaaee3300000000f0fe
222222222222222222222222666666666666666622222222222222226785587887772c26333333333334c3330000000220000000aaaaaaaae300000000000eee
2022225555222222202222220022262220262202222222222222222233333333333333330000999999990000ee3efefffffeeee30000f0f0fff0000023444432
2222325555223202222232020626320222220260b55555555555555b32222222222222230999999999999990e33fffffffffff33000ffff0ff00ff002344c432
22222255552222222222222200622222262226624b666666666666b432222222222222239999999999999999efeffeeffefefeee0f00feeffe0ef0002c444432
2220225555202222222022226660262222202260c46666666666664c32777772277777239999999999999999fffffffeeeffeefffff00ffeeeffeee023c444c2
2322225555222222232222220322222223622060c41666666666614c32777772277777235999999999999995ffffefffeffeeeeeffffefffeffe00ee234444c2
2222225555222202222222020662222222226666c41222222222214c32777772277777237555999999995557effffffeeeeee3e300fffffeeeeee3e323444432
22220255552202225555555560220222622202003c122222222221c332777772277777230777555555557770fffefeeee3e33ee3f0fefeeee3e33e002c444432
22222255552222235555555562262223222622033c122222222221c332777772277777230022777777772200ffffefee33eeee33ffffefee33eee03323444c32
20222222002436005555555520262222060060063cccccccccccccc332777772277777230077220000227700feefe3e33feeeee3feefe3e33feeeee3045b4c30
22223202002436005555555522223202006006623cccccccccccccc332777772277777230097270000727900fffeeee3ffee333efffeeee3ffee300045b444c3
22222222002436002222222222622062262220663cccccccccccccc332777772277777230099770000779900efeee3eefeee333eefeee3eefeee303039555593
22202222002436002220222262206226266062603cccccccccccccc332777772277777230099770000779900efe33efeeee33e330fe33efeeee33e3339555593
23222222002436002322222223606022236226223cccccccccccccc332777772277777230099770000779900efefeeeeee33e33e0fefeeeeee33e33039555593
22222202002436002222220206226602602222023cccccccccccccc332777772277777230099770000779900f3e3eee3eeee3e3e0e0eee03eee0303039555593
22220222002436002222022260066026222602223cccccccccccccc332777772277777230099700000079900ee33e333e3e3ffe3000e3003e3e0000045b444c3
22222223002436002222222300600000262222233cccccccccccccc332777772277777230009000000009000ee3eee33333eee3e0000ee03303e0000045b4c30
3333333233333324333333323333332400077777777770009999999927aa99999999999927aa9999999aaa729999aa7200000022220008809999999999999999
23333326233332432333332ee33332430772222222222770888888886277aaaa99999999227aaaaaaaaaa722aaaa772600002222222204409999999999999999
3233320222332433323332eeee3324337227777557777227999999996222777aaaaaaaaa02777aaaaaa77720a77722260000222992220440aaaaaaaaaaaaaaaa
332320060023433333232eeeeee343332777777557777772aaaaaaaa62322777777777770227777777777220777223260002291881922440ccccbbbbbbbbbccc
33320622230233333332eeeee4ee33332722222222222272aaaaaaaa62332227777777770022277777722200722233260002288888822440cccbbbbbbbbbcccc
3326260202662333332eeeeeeeeee33327555555555555729999999962333622222222220002222222222000226333260002298778922440ccbbbbbbbbbccccc
320602222202023332ee4eeeeeee4e3327555555555555729999999962333366222222220000666666660000663333260000009889004430cbbbbbbbbbcccccc
20262623222000232eeeeeeeeeeeeee327777777777777729999999962333336666666660000066666600000633333260000000770044300bbbbbbbbbccccccc
30202622206226043eeeeeeeeeeeeee4276666666666667299999999622222220000fe000000000a00191000222222260000000000000000999988999a66a998
330032022222364333eeee4eeeeeee43276bd6ddbb6bb6729999999962333333000ee000000000aa0019100033333326999aa0000000000099988899a6666a98
3332622202600433333eeeeeeeeee433276dd6dbbb6bd6729999999962222222079e970000000aaa119591102222222699999aaa000000009998899a66666699
33330020262043333333eeeeeeee4333276dd6bbbb6dd6729999999962222222798989700000aaaa995889902222222699999999a70000009988999a662266a9
332430222064333333243eeeeee433332767777777777672999999996226666679797970000aaaaa7798977066666226999999999a700000998899a662362669
3243330660432333324333eeee432333276db2bbbd2dd67299999999662222227979797000aaaaaa01979100222222669999999999a70000998999a62333626a
24333332043332332433333ee4333233276bb2bbdd2db6729999999966666666079797000aaaaaaa19717910666666669999999999a7000099899a6623336266
43333333433333234333333343333323276bb2bddd2bb672999999990666666600777000aaaaaaaa071017006666666099999999999a700099999a6623336266
205222222222252320222222272e22222767777777777672999aa999aaaaaaaa0000099999900000779999999999999900000009999a700099999a6233333626
255532022022555222223202227fe722276bb2dddb2bb67299a44a99333333330009999999999000779999999999999900000099999aa70099999a6232623626
55555222222555552222222277eff777276bd2ddbb2bd6729a4544a94444444400999aaaaaa9990077999999aaaaaaaa0000099a999aa700aaaaa76232323626
255555222355555299999999effeeffe276dd2dbbb2dd67293444439333333330099acccccca99007799999999accccc000099ac999aa7007777726232433626
2355555225555522999999997efeef7727777777777777729334433922222222099acccccccca9907799999999accccc00099acc999aa7007777726232433626
222555555555522299999999727fe7ee27777777777777729933339933333333099acccccccca9907799999999accccc0099accc999aa7002222266232323626
22225552055532229999999977fff7e72777777777777772999339994444444499acccccccccca997799999999accccc099acccc999aa7002222266232623626
22222523225222222222222322ee72772777777777777772999999993333333399acccccccccca997799999999accccc99accccc999aa7006666666233333626
2029999229999222202222222222722200000effffe0000099a99a9900000009cccccccc999999999000000099accccc90000000000006222222226623336266
2229999229999202999999997772272700000effffe000009a4aa4a900000009cccccccc999999999000000099accccc99000000000006233333326623336262
2229999229999222999999992777727700000efeefe000009a5aa5a900000099ccccccccaaaaaaaa9900000099accccca9900000000006222222226623336260
2229999229999222999999997227777700000890098000009343343900000099cccccccccccccccc9900000099acccccca990000000000622222222662362620
232999922999922299999999777777220000089009800000934334390000099acccccccccccccccca990000099accccccca99000000000662266622666226600
222999922999920222222202772772770000089009800000993993990000099acccccccccccccccca990000099acccccccca9900000000066222226666666200
222999922999922222220222777777770000b890098b000099399399000099acccccccccccccccccca99000099accccccccca990000000006666666666662000
22299993299992232222222327722272000bbbb00bbbb00099999999000099acccccccccccccccccca99000099acccccccccca99000000000666666666220000
000000000000d2e20000718192a200d2b2e20044546c7c6c7c6c7c6c7cc4d4c4d4c4d4c4d4000000000000000000000041d0d0d0d0d0d03141d0d0d041728231
00d1d100d100d100d100d1000000c000009500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f1e20000d2b3c3e200718193a300b2c2c2f345556d7d6d7d6f7f6f7f6d7d6d7d6f7f6f7f000000000000000000000031d0d0d0d0d0d04131d0d0d031738341
00d1d10000d100d100d100d1d1d1d1c095d1d1d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d2b2e200d3b2c2c3e2d2e2526200d3c3e31345556e7e47576e7e47576e7e47576e7e4757000000000000000000000041314131413141314131413141738331
b1d1d1c1d100d100d100d100d1d1d1c1b1d1d1d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f1b3b3c3e1d2b3c3b2c2b3c35363d2e2f20013455500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b1c10000d100d100d100d10000c10000b100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d2b2c2b2e2d3e3f2d3e3850053630000f2001346560000000000000086e4f4b696000000000000000000b69797c7000000000000000086e4f4b6960000000000
8697e4f4979600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b3b2c2b2c20000f2000000d2b2e20000f20013000000000000000077dcec87b787a70000000000000000b7878787c700000000000077dcec87b787a700000077
87dcec878787a7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d3b3c3b3e30000f20000d2b3b3c3e200f200130000000000fe2c2c2c2cfe2c2c6565c5d5fe2c2c2c2c2c65656565656565c5d5bccccececefd6565fe2c2c2cbe
cecececececede000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000f200000000f20000d3c3b3b3e300f200130000000000fe2c2c2c2cfe2c2c65e5f5d6fe2c2c2c2c2c656565658c9cac65d66776767667e5f565fe2c2c2c66
66767676766666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000eeeeeeeeeeeeeeee84e6f6a4eeeeeeeeeeee848484848d9dad84a49484848484e6f684eeeeeeee74
848484848484b4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000d7e7f700d7e7f700d7e7f70000008e9eae00000000008e9eae0000d7e7f700d7e7f700d7e7f70075
b50000000075b5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
008697e4f4979600000086e4f4b6979600000000000000c69797e4f4c70000000000000000000086e4f4b697960000008697e4f4979600008697e4f497960000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7787dcec878787a70077dcec87b78787a70000000000c68787dcec8787c7000000000000000077dcec87b78787a7007787dcec878787a77787dcec878787a700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
64646464646464646464646464a66565a665c5d565656565656565a66565656565c5d5bccccececefd6565a6656565bececececececede2c2c2c2c2c2c2c2c00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66667676767666666776767667e5f565a6e5f5d665658c9cac6565a665658c9cac65d6bded76cdede5f565a6e5f565cddd65767665dded2c2c2c2c2c2c2c2c00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
74848484848484b49484848484e6f68484e6f6a494848d9dad84848484848d9dad84a49484848484e6f68484e6f6a474848484848484b4eeeeeeeeeeeeeeee00
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
75b50000000075b5d7e7f700d7e7f700d7e7f70000008e9eae00000000008e9eae0000d7e7f700d7e7f700d7e7f70075b50000000075b575b50000000075b500
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
322222233333333344444444eeeeeeeeeeeeeee33eeeeeee000000000000088099988999aa6666aa999889990000000000000000cccccccbbbbbbbbb272e2222
322222232222222244444444eee4eeeeeeeeee3223eeeeee0000002222000440988899aa66666666aa99888900000000000aa998ccccccbbbbbbbbbc227fe722
322522232222222244444444eeeeeeeeee4ee322223eeeee000002299220044098899a666666666666a998890000000aaaa99888cccccbbbbbbbbbcc77eaa777
322522232255552244444444eeeeeeeeeeee32222223eeee00002918819204408899a66662222226666a998800000aaa99998888ccccbbbbbbbbbcccefa58afe
322522232222222244444444eeeeee4eeee3222222223eee0000288888820440899a6662223333222666a998000aa99999888888cccbbbbbbbbbcccc7ea89a77
322522232222222244444444eeeeeeeeee322252252223ee000009877890044099a666223333333322666a9900aa999aaaaaaaaaccbbbbbbbbbccccc727aa7ee
322222232222222244444444e4eeeeeee32225222252223e00000098890044309a66622333333333322666a90aa9aaa999999999cbbbbbbbbbcccccc77fff7e7
322222233333333344444444eeeeeeee322222222222222300000007700443009a66223333333333332266a90aaa999999999999bbbbbbbbbccccccc22ee7277
3333333333333333333333332222222232222222222222230000443333444000a6662333333333333332666a7aa99aaa99999aaaaaaaaaaaaaa9999988999aaa
32222222222222222222222322222222e32225222252223e0004433333343000a6622333332662333332266a7aa9accc9999acccccccccccccca9999899aa999
32222222222222222222222322222222ee322252252223ee00443633336300007662333332633623333326677aa9acc59999acc5cccccccc5cca999999a99999
32255522225555222255222355225522eee3222222223eee04436633336600002662333336344363333326627aa9accc9999acccccccccccccca99999a999999
32252222222222222225222322222222eeee32222223eeee04406633336600002662333336344363333326627aa9abbb9999abbbbbbbbbbbbbba99999a999999
32252222222222222225222322222222eeeee322223eeeee04406633336600006662633332633623333626667aa9abbb9999abbbbbbbbbbbbbba9999a9999999
32222222222222222222222322222222eeeee43223eee4ee04406633336600006662233333266233333226667aa9abbb9999abbbbbbbbbbbbbba999999999999
32222223322222233222222399999999eeeeeee33eeeeeee00006633336600006666263333333333336266667aa9988899999888888888888889999999999999
32222223322222233222222399999999222222299222222200000effffe00000066622633333333336226660000aa99988888888999aa0003333333334444444
32222222222222222222222322222222222222299222222200000effffe00000026662263333333362266620000a9999888888889999a0004444444434444444
32252222222222222225222322222222222522299222522200000efeefe0000000266622663333662266620000aa9998888888888999aa003333333334444444
32252222225555222225222322222222222522299222522200000ef00fe0000000026662226666222666200000a999988888888889999a003333333334444444
32252222222222222225222355225522222222299222222200000ef00fe000000000266662222226666200000aa999988888888889999aa03333333334444444
32252222222222222225222322222222222222299222222200000ef00fe000000000026666666666662000000a99aaaaaaaaaaaaaaaa99a02222222234444444
3222222222222222222222232222222222252229922252220000bff00ffb00000000002666666666620000000aaa9999999999999999aaa02222222234444444
322222233222222332222223222222222225222992225222000bbbb00bbbb000000000002266662200000000a9999999999999999999999a6666666634444444
32222223322222233222222327222222000000000000000000004433334440003bbbbb6333333333feefe3e33333333333333333333333330000000000000000
32222222222222222222222327777777000000000000000000044344443430003414146333333333fffeeee33333333333333333333333330000000000000000
32252222222222222225222377e772e7000000000000000000443344443300003bbbbb633ccccc63efeee3ee3333333344444444333333330000000000000000
32255522225555222255222377777772000000000000000004436344443600003414146332121263efe33efe37777763bb4bbb4b333333330000000000000000
32222222222222222222222372222222000000000000000004406344443600003bbbbb633ccccc63efefeeee32121263444444443ccccc630000000000000000
32222222222222222222222377777777000000000000000004406344443600003414146332121263f3e3eee3377777634bbb4bbb321212630000000000000000
32222222222222222222222377e777e7000000000000000004406344443600003bbbbb633ccccc63ee33e33332121263444444443ccccc630000000000000000
33333333333333333333333322272277000000000000000000006666666600003333333333333333ee3eee333333333333333333333333330000000000000000
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111110000000011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111110990099011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111110990099000000000000000001100000000001111110000001100000000000000111111111111111111111111111111111
11111111111111111111111111111110990099009900990099999901109999009901111110999901109999009900990111111111111111111111111111111111
11111111111111111111111111111110990099009900990099999900009999009901111000999900009999009900990111111111111111111111111111111111
11111111111111111111111111111110990099009900990000990000990099009901111099009900990000009900990111111111111111111111111111111111
11111111111111111111111111111110990099009900990110990110990099009901111099009900990000009900990111111111111111111111111111111111
11111111111111111111111111111110999999009999990110990110999999009901111099999900000099009999990111111111111111111111111111111111
11111111111111111111111111111110999999009999990000990000999999009900000099999900000099009999990111111111111111111111111111111111
11111111111111111111111111111110999999009900990099999900990000000099990099009900999900009900990111111111111111111111111111111111
11111111111111111111111111111110999999009900990099999900990111111099990099009900999901109900990111111111111111111111111111111111
11111111111111111111111111111110000000000000000000000000000111111000000000000000000001100000000111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111000000001111111111111111111111111111111111000000111111111111111111111111111111111111111111111
11111111111111111111111111111111111099999901111111111111111111111111111111111099990111111111111111111111111111111111111111111111
11111111111111111111111111111111111099999901100000000000000000000001111111100099990110000001111111111111111111111111111111111111
11111111111111111111111111111111111000990001109999009900990099999901111111109900000110999901111111111111111111111111111111111111
11111111111111111111111111111111111110990110009999009900990099999901111111109901111000999901111111111111111111111111111111111111
11111111111111111111111111111111111110990110990099000099000000990001111111109901111099009901111111111111111111111111111111111111
11111111111111111111111111111111111110990110990099011099011110990111111111109901111099009901111111111111111111111111111111111111
11111111111111111111111111111111111110990110999999011099011110990111111111109901111099009901111111111111111111111111111111111111
11111111111111111111111111111111111110990110999999000099000000990001111111109900000099009901111111111111111111111111111111111111
11111111111111111111111111111111111110990110990099009900990099999901111111100099990099990001111111111111111111111111111111111111
11111111111111111111111111111111111110990110990099009900990099999901111111111099990099990111111111111111111111111111111111111111
11111111111111111111111111111111111110000110000000000000000000000001111111111000000000000111111111111155511111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111115551155105011111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111155515551505115111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100015051515115111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111115151550115111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110101001110111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111119999999999999999999999999999999999999911111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111999999999999999999999999999999999999999999111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111999kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk99911111111111111111111111111111111111111111111111111
111111111111111111111111111111111199kddddddd666666666ddd99kddddddddddddddddk9911111111111111111111111111111111111111111111111111
11111111111111111111111111111111199kddddddd666666666dddd99kdddddddddddddddddk991111111111111111111111111111111111111111111111111
11111111111111111111111111111111199kdddddd666666666ddddd99kdddddddddddddddddk991111111111111111111111111111111111111111111111111
1111111111111111111111111111111199kdddddd666666666dddddd99kddddddddddddddddddk99111111111111111111111111111111111111111111111111
1111111111111111111111111111111199kddddd666666666ddddddd99kddddddddddddddddddk99111111111111111111111111111111111111111111111111
11111111111111111111111111111119ddddddd666666666dddddddd99kddddddddddddddddddddd911111111111111111111111111111111111111111111111
11111111111111111111111111111119dddddd666666666ddddddddd99kddddddddddddddddddddd911111111111111111111111111111111111111111111111
11111111111111111111111111111199ddddd666666666dddddddddd99kddddddddddddddddddddd991111111111111111111111111111111111111111111111
11111111111111111111111111111199dddd666666666ddddddddddd99kddddddddddddddddddddd991111111111111111111111111111111111111111111111
1111111111111111111111111111199kddd666666666dddddddddddd99kdddddddddddddddddddddk99111111111111111111111111111111111111111111111
1111111111111111111111111111199kdd666666666ddddddddddddd99kdddddddddddddddddddddk99111111111111111111111111111111111111111111111
111111111111111111111111111199kdd666666666dddddddddddddd99kddddddddddddddddddddddk9911111111111111111111111111111111111111111111
111111111111111111111111111199kd666666666ddddddddddddddd99kddddddddddddddddddddddk9911111111111111111111111111111111111111111111
11111111111111119999999999999999999999999999999999999999ll9999999999999999999999ll9999999999999911111111111111111111111111111111
1111111111111111ffffffffffffffffffffffffffffffffffffffffll9999999999999999999999ll99999999999999999kk111111111111111111111111111
11111111111111119999999999999999999999999999999999999999ll9999999999999999999999ll9999999999999999999kkk111111111111111111111111
1111111111111111kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkll9999999999999999999999ll9999999999999999999999kl1111111111111111111111
1111111111111111kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkll9999999999999999999999ll99999999999999999999999kl111111111111111111111
11111111111111119999999999999999999999999999999999999999ll9999999999999999999999ll999999999999999999999999kl11111111111111111111
11111111111111119999999999999999999999999999999999999999ll9999999999999999999999ll999999999999999999999999kl11111111111111111111
11111111111111119999999999999999999999999999999999999999ll9999999999999999999999ll9999999999999999999999999kl1111111111111111111
111111111111111199k99k99kkkkkkkkkkkkkkkkkkkkkkkk99k99k999999ff999kggk99f99999999ll9999999999ff999kggk99f999kl1111111111111111111
11111111111111119kmkkmk95555555555555555555555559kmkkmk9999fff99kggggk9f99999999ll999999999fff99kggggk9f999kkl111111111111111111
11111111111111119kfkkfk9mmmmmmmmmmmmmmmmmmmmmmmm9kfkkfk9999ff99kgggggg9999999999ll999999999ff99kgggggg99999kkl111111111111111111
111111111111111195m55m5955555555555555555555555595m55m5999ff999kggllggk999999999ll99999999ff999kggllggk9999kkl111111111111111111
111111111111111195m55m59llllllllllllllllllllllll95m55m5999ff99kggl5glgg999999999ll99999999ff99kggl5glgg9999kkl111111111111111111
1111111111111111995995995555555555555555555555559959959999f999kgl555glgk99999999ll99999999f999kgl555glgk999kkl111111111111111111
111111111111111199599599mmmmmmmmmmmmmmmmmmmmmmmm9959959999f99kggl555glgg99999999ll99999999f99kggl555glgg999kkl111111111111111111
1111111111111111999999995555555555555555555555559999999999999kggl555glgg99999999ll99999999999kggl555glgg999kkl111111111111111111
1111111111111111llkk99999999999999999999999999999999999999999kgl55555glg999999999999999999999kgl55555glg999kkkll1111111111111111
1111111111111111lllkkkkk9999999999999999999999999999999999999kgl5lgl5glg999999999999999999999kgl5lgl5glgkkkkklll1111111111111111
11111111111111111llllkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkklgl5l5l5glgkkkkkkkkkkkkkkkkkkkkklgl5l5l5glgkkkllll11111111111111111
11111111111111111lllllllllllllllllllllllllllllllllllllllllllllgl5lm55glgllllllllllllllllllllllgl5lm55glglllllll11111111111111111
111111111111111111llllllllllllllllllllllllllllllllllllllllllllgl5lm55glgllllllllllllllllllllllgl5lm55glgllllll111111111111111111
1111111111111111111llllllllllllllllllllllllllllllllllllllllllggl5l5l5glglllllllllllllllllllllggl5l5l5glglllll1111111111111111111
11111111111111111111gggglllllllllllllllllllllllllllllllllllllggl5lgl5glglllllllllllllllllllllggl5lgl5glggggg11111111111111111111
111111111111111111111ggggggggggggggggggggggggggggggggggggggggggl55555glggggggggggggggggggggggggl55555glgggg111111111111111111111
111111111111111111111gllllllllggl555glgg1111111111111gllllllllggl555glgg1111111111111gllllllllggl555glgg111111111111111111111111
111111111111111111111gl555555lggl555glgl1111111111111gl555555lggl555glgl1111111111111gl555555lggl555glgl111111111111111111111111
111111111111111111111gllllllllggl555glg11111111111111gllllllllggl555glg11111111111111gllllllllggl555glg1111111111111111111111111
1111111111111111111111gllllllllggl5glgl111111111111111gllllllllggl5glgl111111111111111gllllllllggl5glgl1111111111111111111111111
11111111111111111111111gllgggllgggllgg11111111111111111gllgggllgggllgg11111111111111111gllgggllgggllgg11111111111111111111111111
11111111111111111111111gglllllgggggggl11111111111111111gglllllgggggggl11111111111111111gglllllgggggggl11111111111111111111111111
111111111111111111111111ggggggggggggl1111111111111111111ggggggggggggl1111111111111111111ggggggggggggl111111111111111111111111111
111111111111111111111111ggggggggggll11111111111111111111ggggggggggll11111111111111111111ggggggggggll1111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddd00000ddddddddddddddd0000ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddd0fff0000000000000ddd0ff000000000000000000000ddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddd00f000ff0f0f0fff0ddd0f0f0ff00fff0f0f0fff0ff00dddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddd0f00f0f00f000f00ddd0f0f0f0f00f00f0f0ff00f0f0dddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddd0f00fff00f000f00ddd0f0f0ff000f00fff0f000ff00dddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddd0f00f0f0f0f0fff0ddd0fff0f0f0fff00f000ff0f0f0dddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddd0000000000000000ddd0000000000000000d00000000dddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
11111111111111111111111111111111111111111100001111111111111111111111100000111111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111111111100mm0000000000000000000001110mmm0000000000000111111111111111111111111111111111111111111
111111111111111111111111111111111111111110m000mmm0mm00mmm0mmm0mmm01110m0m00mm00mm0mmm0111111111111111111111111111111111111111111
111111111111111111111111111111111111111110mmm00m00m0m0mm00mm000m001110mm00m0m0m000mm00111111111111111111111111111111111111111111
11111111111111111111111111111111111111111000m00m00mm00m000m0000m011110m0m0mmm0m000m000111111111111111111111111111111111111111111
111111111111111111111111111111111111111110mm000m00m0m00mm00mm00m011110m0m0m0m00mm00mm0111111111111111111111111111111111111111111
11111111111111111111111111111111111111111000010000000000000000000111100000000000000000111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111100000111111111111111000001111111111111111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111111110mmm00000000000001110mmm00000000000110000000000001111111111111111111111111111111111111111
1111111111111111111111111111111111111110m000mm00mmm0mmm01110m000m0m00mm0m0100mm0mm00mmm01111111111111111111111111111111111111111
1111111111111111111111111111111111111110mm00m0m0mm00mm001110mm000m00m0m0m010m0m0m0m0mm001111111111111111111111111111111111111111
1111111111111111111111111111111111111110m000mm00m000m0001110m0000m00mmm0m000m0m0mm00m0001111111111111111111111111111111111111111
1111111111111111111111111111111111111110m010m0m00mm00mm01110mmm0m0m0m0000mm0mm00m0m00mm01111111111111111111111111111111111111111
11111111111111111111111111111111111111100010000000000000111000000000001100000000000000001111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

__map__
10233030303024101010101010101010010210020102010203c303c303030303c3c303c303c3035352c303c30303c30309080708070807080404040404040404c3c4c1c1c1c1d1c1c1e2c3c3c3c3c3c3c3c3c3c3c3d4d1c1c1c5c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c4c1c5c3f3f3f3f3c3c0c3c3c3c3c3c3c3c3c3c3c3c3c3
102330202130241034343434343434341112101211121112c303c30303c303c3c303c3c3c303534041520303030303c31a050607080506071314131413141314c3c0fbc3fdfdc0c3c3c0c3c3c3c3c3c3c3c3c4c1c1c1d5c2c2d4c5c3c3c3c3c3c3c4c1c5c3fac3fbfbc0c3c0c3f3f3c3c3c4d5c3c3c3c3c3c3c3c3c3c3c3c3c3
10233020213024103030303030303030010201020102010203030303c303c303c3c3c3c3c353403030415203c30303030a15160807151608140d0d0d14272813c3e0c1c1d1c1e2fdfde0c1c1d1c1c1c1c1d1d5c3c3fcfcfdfcc3c0c3c3c3c3c4c1e2f9c0c3fac3c3c3d4c5c0c3f3f3c3c4d5c3c3c3c3c3c3c3c3c3c3c3c3c3c3
10233030303024103022223030222230111211121112111203c3c3c3030303c303c3030353403030303041520303c3c31a07080708070807130d0d0d13373814c3c0fbc3c0fbf0c1c1e2c3c3d4c5c3c3c4d5c3c3c3fcf9f9fcc3c0c3c3c3c4d5c3d4c1d5c3fac3fdc3c3d4e2c3c3c3c4d5c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
102330303030241030323230303232300102101001020102c3030303c3c30303c30303534030306130303041520303030a080708070807081413141314373813c3d4c5c3d4c5f9c3fbc0c3c3c3d4c1c1d5c3c3c3c3fcfcfcfcc3c0c3c3c4d5c3c3c3c3c3c3fafafafafafac0c3c3c4d5c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
1023302021302410303030303030303011121010101011120303c3030303c303c3c3534030303030306030304152c30319050607080506090708070807081314c3c3d4c5fdd4c1c1c1e2c3c3c3fdc3fbfbc3c3fbc3c3c3c3c4c1f1c1c1d5c3c3fafafafac2c2c2c2c2c2c2c0c3c4d5c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
10233020213024103333333333333333010201020102010203c30303c3c303c3c3534030306130303030303030415203071516080715161a0813140708070807c3c3c3d4c5c3c3c3c4d5c3c3fafafafafafafafafac3c3c4d5fafafafafafac4c1c1c1c1c1c1c1c1c1c1c1e1c1d5c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
102330303030241010101010101010101112111211121112030303c30303030353403030303030515030306030304152080708070807080a0708070807081314c3c3c3c3e0d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d5fbfbc3c3f8fcf8c2f8fcf8c0c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3
101010101010101010101010101010101010101010101010343434343434343443503030303030414030306130305142070807080708071a0807080708131407c3c3c3c3e0e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3c5c3c3c3c4c1c1c1c1c1c1d1e1c1c1c1c1c1c1d2c3c3c3c3c3c3c3c3c3c3c3c3c3
103434343434343434343434343434343434343434343410303030303030303003435030306030303030303030514203080506070805060a0708131407080708c3c3c3c3c0fcfcfcfcc2fcfcfcfcfcfcc2c2c2c2c2c4d5fafafafafafafafad4c5fdc4d5c2c2c2c2c2c2e4e5fcfcfcfcfcfcc0c3c3c3c3c3c3c3c3c3c3c3c3c3
1023303030303030303030303030303030303030303024103030303030303030030343503030303030613030514203c3071516080715161a1407080708070813c3d0c1c1d5c3c3c3c3c3c3c3c3c3c3fcfcfcfcfcc2c0c2c2c2d0c1c1c5fbfbc4e2c4d5c3fafafafafafce4e5fcf9d0c1c1c1e1c1c1c1c1d1c1c1c1c1d2c3c3c3
1023303030222230302222303022223030222230303024103022302230223022c3c303435030306030303051420303c308070807080708192b2b3b3c2b2c2b2cc3c0fafafafafafafafafafafac3c3fcc2f8f9c2c2c0f8c2f8c0f8c3d4c5c4d5e0d5c3c3c3fbc3c3c3fce4e5fcc2c0f8f9f8c0c2c2c2c2c0c2c2c2c2c0c3c3c3
102330303032323030323230303232303032323030302410303030303030303003030303435030303030514203c3030307080708090807083b3b2b2c3b3c2c3cc3c0fac3c3c3c3c3c3c3c3c3fac3c3fcd0c1c1c1d1f1d2c2c2c0c2d0c1f1e2f8c0c2d0c1c1c1c1d2fdfce4e5fcf8c0c2d0c1e2c2f8f8c2c0c2f8f8c2c0c3c3c3
102330202130303030303030303030303030302021302410303030303030303003c303030343503030514203030303c3082728071a0506073b2b3b3c3b3b3c3cc3c0fac3fbfbc3d0c1c1d2c3fac3c3f9c0c2c2c2c0f8e0c1c1e2f9c0f8c3d4c5c0f9c0f9fbc2c3c0fbfce4e5fcc2c0c2c0f9c0c2f8f8c2c0c2f8f8c2c0c3c3c3
1023302021303033333030303030303333303020213024103030303030303030030303c3c3034350514203c303c30303073738080a1516082b3b3c2b2c3b3c2cc3c0fac3fbfbc3c0c3c3c0c3fac3c3f8c0c2f9f9c0c2c0c3c3c0f8f0c1d2c3d4e2f9c0c2c2c2c3c0f8fce4e5fcf8e0c1e2fdc0c2c2c2c2c0c2c2c2c2c0c3c3c3
102330303030241010233030323232101023303030302410626262626262626203c3c303030303434203c30303c30303083738071a0708073b3c3b3b3c3c3b3cc1e2fac3fbfbc3c0c3c3d4c5fac3c3f8c0c2d0c1f2f8f0c1c1e2fcfcfcc0fcfcc0c2c0c2c2f9f8d4c5fce4e5fcc2c0f9f0d1f1c1c1c1c1e1c1c1c1c1e1c1c1c1
10233030303024101022222230302410102330303030241072727272727272722330302030303070713030302130302404040404040404040404040404040404c3c0fac3c4c1c1e1c1c1c1f1c1c1c1c1e2c2c0c2c2c2f8f8fcc0f8c3fdc0fbc3c0c2c0f8c2d0c1c1e2fce4e5fcf9c0fcfcc0fcc2c2c2c2c0c2c2c2c2c0c3c3c3
1023302021303021343030303030303434303020213024103030303030303030233030303030307071303030303030240e05060e0506060e050506060e05060fc3c0fac3c0c3c3c0c3c3c3c3fac3c3f9c0f8c0f8f9c2f8c2fce0c1d1c1f1c1c1e1c1e2f9f9c0fdf9c0fce4e5fcf8f0c1c1e2fcc2f8f8c2c0c2f8f8c2c0c3c3c3
1023302021303021303030303030303030303020213024103030303030303030233030203030307071303030213030240e15160e1516160e151516160e15160fc3c0fafdd4c1c1d5c3c3c3c3fac3c3c2f0c1e1c1c1c1c1c1c1f2f9c0fdc3f9c3c0c2c0c2c2c0c2d0f2fce4e5fcc2c2fbfcc0fcc2f8f8c2c0c2f8f8c2c0c3c3c3
1023303030303021302222303022223030303030303024103030303030303030233030303030307071303030303030240e0f0e0e0e0e0f0e0e0e0f0e0e0e0e0fc3c0fafafafafafafafafafafac3c3c2c2f8c0c2c2c2f9f9c2c2c2c0fafafafac0f8f0c1c1f1c1f2f8fce4e5fcf8c2fbfcc0fcc2c2c2c2c0c2c2c2c2c0c3c3c3
1023303030303030303232303032323020303030303024103032303230323032233030203030307071303030213030240e0e0e0f0e0e0e0e0f0e0e0e0e0f0e0fc3c0c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c0c3c3c3f3f3f3f3c3f0c1c1c1c1e2c2c2f9fcfcf8c2c2fce4e5fcc2c2c2fcc0fcc3c3c3c3f0c1c1c1c1f2c3c3c3
1023302021303030303030303030303020303020213024103030303030303030233030303030307071303030303030240e54550e0506060e050506060f05060fc3d4c5c3c3c3c3c3c3c3c4c1c1c1c1d1c1c1e2c3c3c3f3f3f3f3c3c3fbc3fdc4f1c1c1d1c1d1c1c1d2fcd4e2fcfcfcfcfcc0c3c3c3c3c3c3c3c3c3c3c3c3c3c3
1023302021303033333030303030303320303020213024103030303030303030233030203030307071303030213030240f54550e1516160e151516160e15160fc3c3d4c5c3c3c3c3c3c4d5c3c3c3c3c0c3c3d4c5c3fdf3f3f3f3c3c3c3c3c4d5c3c3fbc0fdc0c2c2c0f9fdc0f9f9c2c2c2c03c3c3c3cc3c3c3c3c3c3c3c3c3c3
1023303030302410102330303232321010233030303024103333333333333333233030303030307071303030303030240e54550f0e0e0e0f0e0e0f0e0e0e0e0fc3c3c3d4c1c1d1c1c1d5c3d0c1c1c1e2c2c3c3d4c5c3c3c3c3c3c3c3c3c4d5c3c3c3c3c0fdc0fdf9c0f9f9c0f9f8c2fdf9e0c1c1c1d2c3c3c3c3c3c3c3c3c3c3
10233030303024101022222230302410102330303030241073737373737373730000000000000000000000000000000004040404040404040404040404040404c3c3c3c3c3c3d4c5c3c3c3c0f9c2f8c0f9fac3c3d4c5fafafafac3c3c4d5c3c3fbc3c2e0d1f1c1c1e1c1c1e1d1c1d1c1c1f2fafafac0c2c3c3c3c3c3c3c3c3c3
102330202130303434303030303030343430302021302410637363736373cf730000000000000000000000000000000013141314131413141314131413141314c3c3c3c3c3c3c3d4c5c3c3f0c1d2c2f0d2fac3fdc3d4c1c1d1c1c1c1f1c1c1d1c1c1c1f1e2f8c2c2c0f8f8e0f2f8c0f8c2f8f9c4c1e2fbc3c3c3c3c3c3c3c3c3
102330202130303030303030303030303030302021302410737373737373737300000000000000000000000000000000140d0d13140d0d13140d0d0d140d0d13c3c3c3c3c3c3c3c3d4c5c3c2fdc0f9fdc0fafafafafafbfbc0c3fac3fdc3fdd4c5c3f9c3c0c3c2f9c0f8f8c0f8f8c0fcc2c2c4d5c3c0fbc3c3c3c3c3c3c3c3c3
102330303022223030222230302222303022223030302410cf7363736373637300000000000000000000000000000000140d0d14130d0d14130d0d0d130d0d14c3c3c3c3c3c3c3c3c3c0c3c2c2f0c1c1e2f3f3f3f3c3c3c3c0fac3c3c3c3c3c3d4c1c1c1f1c1c1c1f2f9c2f0c1c1e2f8fcf8c0c3c3c0c2c3c3c3c3c3c3c3c3c3
10233030303232303032323030323230303232303030241073737373737373730000000000000000000000000000000014131413141314131413141314131414c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3f0c1c1c1c1d1c1c1f2fac3c3c3c3c3c3c3c3c3c3c3c3c3fcc2c2c2f8f9f8f0c1c1c1e1c1c1f2f9c3c3c3c3c3c3c3c3c3
10233030303030303030303030303030303030303030241063736373cf73637300000000000000000000000000000000130d0d1413141314130d0d0d130d0d14c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3c3f3f3f3f3c0c3fafafac3c3c3c3fbc3c3c3c3c3c3c3c3fcfcfcfcfcfcfcfcfcfcf9c0fafafafac3c3c3c3c3c3c3c3c3
103333333333333333333333333333333333333333333310737373737373737300000000000000000000000000000000140d0d1314131413140d0d0d140d0d13c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3c3f3f3f3f3c0c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3c3c3c3c3c3c3c3
10101010101010101010101010101010101010101010101063736373637363730000000000000000000000000000000013141314131413141314131413141314c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3c3c3c3c3c3c0c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3f3f3f3f3c3c0c3c3c3c3c3c3c3c3c3c3c3c3c3
__sfx__
550c000400155001350c1550c13500100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
1d0c01041876018750187401873000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
1d0c01041876018750187401873000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
11060a100c530185200c530185200c530185200c532185220c532185220c532185220c532185220c5321852200500005000050000500005000050000500005000050000500005000050000500005000050000500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aa01002028130281302713027130271302713028130291302a1302a130291302813027130271302713027130281302813028130281302813028130291302a1302b1302c1302b1302a13029130281302813028130
aa0100202513025130241302313023130231302313024130241302513025130251302513025130251302513024130241302313023130241302513025130261302613026130261302513025130251302513025130
00030020276201e62016620276201a620056201462025620136200962024620256201c62022620116202b620206200e6200c6201362023620276200e6202562021620276200c62027620296201d6200962021620
000200002e6502d6502c6502a650296502765024650216501e6501b65018650136500e65009650066500365002650006500065000650026000260001600016000160001600006000760006600036000560003600
0002000029640286402764024640216401f6401c64018640116400764003640006400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001d6401b640176401264006640006400064000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001d6201b620176101261006600006000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00400002e1502e1702e1602e1502e1402e1402e1302e1202e1102e1002e1002e1000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
910300002b1502b1502b1502b1502b1502b1500010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
4b04000018140191411a1411e121231112a1112120024200272002a2000000000000000000000000000000001d6501b6501764012640066400061000610000000000000000000000000000000000000000000000
490b00001235000300123500030014350003001935000300183500030018320003001435000300143200030019350003001932000300193100030019310003000030000300003000030000300003000030000300
910b00000635006350063500030006350063500635000300083500835008350003000835008350083500030001350013500135001340013400133001320003000134001330013200131000300003000030000300
210f00001555015550155501550000500005000050000500155501555015550005000050000500005000050015550155501555000500005000050000500005002155021550215502154021530215202151000500
010c00041885018850188501885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c00001885018850188501885018850188501885018850188501885018850188501885018850188501885013850138501385013850138501385013850138501385013850138501385013850138501385013850
010c00001585015850158501585015850158501585015850158501585015850158501585015850158501585013850138501385013850138501385013850138501385013850138501385013850138501385013850
010c00001585015850158501585015850158501585015850158501585015850158501585015850158501585017850178501785017850178501785017850178501a8501a8501a8501a8501a8501a8501a8501a850
010c00001c950000001c950000001c950000001c9501c9501c930189501892000000189501a9501a9001c9501c9501c9301f9501f9201d9501c9501c9001d9501d9501d9201c950000001a950000001895000000
010c00001c950000001c950000001c950000001c9501c9501c930189501892018900189501a950000001a9501a9501a93018950000001795018950000001a9501a9301a920189501893017950179301792017910
010c00001c950000001c950000001c950000001c9501c9501c930189501892018900189501a950000001c9501c9401c93013950000001f9501f920139501d9501d9351d9501c950000001a950000001895000000
010c00001895018950189501895018940189401894018940189301893018930189301892018920189201892018910189101891018910000000000000000000000000000000000000000000000000000000000000
010c000015a50000000000015a5015a500000018a500000017a50000000000017a5017a50000001aa500000018a50000000000018a5018a50000001ca501da501da301da501ca501ca201aa501aa2018a5018a20
010c00001831300300003000030018313003000030000300183130030000300003001831300300003000030018313003000030000300183130030000300003001831300300003000030018313003000030000300
010c000015a50000000000015a5015a500000018a500000017a50000000000017a5017a50000001aa500000018a5018a4018a3018a2018a10000000000000000000001aa031aa500000018a500000017a5000000
010c00001aa501aa501aa501aa501aa401aa401aa301aa301aa201aa201aa101aa10000000000000000000001aa501aa4013a5013a401ca501ca4013a5013a401da501da4013a5013a401fa501fa4013a5013a40
010c00001185011850118501185011850118501185011850138501385013850138501385013850138501385015850158501585015850158501585015850158501885018850188501885018850188501885018850
010c00001185011850118501185011850118501185011850138501385013850138501385013850138501385015850158501585015850158501585015850158501585015850158501585015850158501585015850
010c00001385013850138501385013850138501385013850138501385013850138501385013850138501385013850138501385013850178501785017850178501a8501a8501a8501a8501f8501f8501f8501f850
010c00001885018850188501885018850188501885018850188501885018850188501885018850188501885018850188500000000000000000000000000000000000000000000000000000000000000000000000
010c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000139501d9501d9351d9501c950000001a950000001895000000
000300000f04010050140401a0301c0201a0001c0001f00023000260002d0002f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 12134344
00 41424344
01 55154344
00 55154344
00 55164344
00 55164344
00 55174344
00 55184344
00 19164344
00 19164344
00 1a174344
00 1b184344
00 19164344
00 19164344
00 1a174344
00 1b184344
00 1d214344
00 1f224344
00 1d214344
00 20234344
00 19164344
00 19164344
00 1a174344
00 1b184344
00 19164344
00 19164344
00 1a174344
00 1b184344
00 1c164344
00 25164344
00 1c164344
00 25164344
00 1c244344
02 07644344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
01 28424344
00 28424344
00 29424344
02 2a424344

