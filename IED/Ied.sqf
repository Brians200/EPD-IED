/* adapted from:  Dynamic IED script by - Mantis and MAD_T -*/

/* Rewritten by Brian Sweeney - [EPD] Brian*/

IED_SMOKE = compile preprocessFileLineNumbers "IED\IedSmoke.sqf";
Disarm = compile preprocessFileLineNumbers "IED\disarmAddAction.sqf";
if(!isserver) exitwith {};

private["_origin", "_counter", "_amountToPlace", "_distance", "_side", "_iedSmallItems","_iedMediumItems","_iedLargeItems","_iedSizes","_paramArray", "_paramCounter", "_debug", "_size","_cityNames","_cityLocations","_citySizes"];

_cityNames = ["Gravia","Lakka","OreoKastro","Abdera","Galati","Syrta","Kore","Negades","Aggeochori","Kavala","Panochori","Zaros","Therisa","Poliakko","Alikampos","Neochori","Stravos","Agios Dionysios","Athira","Frini","Rodopoli","Paros","Kalochori","Sofia","Molos","Charkia","Pyrgos","Dorida","Chalkiea","Panagia","Feres","Selakano","Random1","Random2","Random3","Random4","Random5","Random6","Random7","Random8","Random9","Random10","Random11","Random12","Random13","Random14","Random15","Random16"];
_cityLocations = [[14491.1,17636.8,0],[12342.6,15682.6],[4557.53,21387.7,0],[9420.76,20252.7,0],[10326.3,19055.6,0],[8634.13,18270.7,0],[7144.03,16455.2,0],[4895.13,16168.9,0],[3808.9,13694.7,0],[3543.03,13008.2,0],[5086.4,11263,0],[9197.17,11925.5,0],[10666.3,12270.4,0],[10983.5,13424.3,0],[11133,14561,0],[12501.5,14328.7,0],[12946.5,15057.3,0],[9358.66,15885.8,0],[14022.3,18716.3,0],[14615.4,20775.9,0],[18779.8,16643.9,0],[20951.5,16958.9,0],[21384.8,16362.2,0],[25702.1,21355.8,0],[27033.2,23242.4,0],[18114.4,15241,0],[16828,12662.2,0],[19399,13251.5,0],[20250.4,11673.7,0],[20511.7,8867.04,0],[21700.7,7576.93,0],[20803,6730.63,0],[4941.03,20430.1,0],[5796.45,16578.8,0],[5435.57,12633.9,0],[9579.01,20978.4,0],[10020.1,16859.6,0],[9779.5,12901.4,0],[13749.2,21392.9,0],[13048.1,18153.4,0],[17677.8,17309.3,0],[26097.5,22777.3,0],[23259.9,19904.4,0],[21356.9,17014.4,0],[19267,13716.4,0],[17033.2,10641.5,0],[20342.5,8704.69,0],[11108.5,8551.36,0]];
_citySizes = [[350,350],[350,350],[250,250],[150,150],[150,150],[150,150],[300,300],[150,150],[500,500],[500,500],[350,350],[350,350],[250,250],[250,250],[250,250],[350,350],[250,250],[450,450],[400,400],[250,250],[350,350],[450,450],[250,250],[350,350],[250,250],[400,400],[500,500],[250,250],[400,400],[250,250],[350,350],[350,350],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000],[2000,2000]];

_debug = true;
_paramCounter = 0;
_paramArray = _this;

while{_paramCounter < count _paramArray} do {

	_arr = _paramArray select _paramCounter;
	_paramCounter = _paramCounter + 1;
	
	//["marker", amountToPlace, side]
	//["CityName", side]
	//["CityName", amountToPlace, side];
	
	_origin = [0,0,0];
	_distance = [0,0,0];
	_cityIndex = _cityNames find (_arr select 0);

	if(_cityIndex > -1) then {
		_origin = (_cityLocations select _cityIndex);
		_size = (_citySizes select _cityIndex);
		_distance = ((_size select 0) min (_size select 1));
		
	} else {
		_origin = getmarkerpos (_arr select 0);
		(_arr select 0) setMarkerAlpha 0;
		_size = getMarkerSize (_arr select 0);
		_distance = ((_size select 0) min (_size select 1));
	};
	
	
	
	_amountToPlace = _arr select 1;
	//_distance = _arr select 2;
	_side = _arr select 2;
	
	
	
	[[_origin, _distance, _side, _amountToPlace, iedcounter, _debug], "EPD_CREATE_IED", true,true] spawn BIS_fnc_MP;
	
	iedcounter = iedcounter + _amountToPlace;
	
};

EPD_CREATE_IED = {

	_iedSmallItems = ["RoadCone_F","Land_Pallets_F","Land_WheelCart_F","Land_Tyre_F","Land_ButaneCanister_F","Land_Bucket_F","Land_GasCanister_F","Land_Pillow_F"];
	
	_iedMediumItems = ["Land_Portable_generator_F","Land_WoodenBox_F","Land_MetalBarrel_F","Land_BarrelEmpty_grey_F","Land_BarrelSand_grey_F","Land_BarrelTrash_grey_F","Land_BarrelWater_grey_F","Land_Sacks_heap_F","Land_WoodenLog_F","Land_WoodPile_F"];
	
	_iedLargeItems = ["Land_Bricks_V2_F","Land_Bricks_V3_F","Land_Bricks_V4_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_JunkPile_F","Land_Tyres_F","Land_Wreck_Skodovka_F","Land_Wreck_Car_F","Land_Wreck_Car3_F","Land_Wreck_Car2_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F"];
	
	_origin = (_this select 0);
	_distance = (_this select 1);
	_side = (_this select 2);
	_amountToPlace = (_this select 3);
	_counterOffset = (_this select 4);
	_debug = (_this select 5);
	
	_counter = 0;
	
	_roads = _origin nearRoads _distance;
	
	if(count _roads == 0) exitwith {}; //if there are no roads in this circle of life....
	while{_counter < _amountToPlace} do {
		
		_iedSize = "SMALL";
		 r = floor random 100;
		 if(r>40) then {
			_iedSize = "MEDIUM";
		 };
		 
		 if(r>80) then {
			_iedSize = "LARGE";
		 };
		
		_iedType = 0;
		_junkType = 0;
		if(_iedSize == "SMALL") then
		{
			_iedType = _iedSmallItems select(floor random(count _iedSmallItems));
			_junkType = _iedSmallItems select (floor random (count _iedSmallItems));
		} else {
			if(_iedSize == "MEDIUM") then
			{
				_iedType = _iedMediumItems select(floor random(count _iedMediumItems));
				_junkType = _iedMediumItems select (floor random (count _iedMediumItems));
			} else { //large
				_iedType = _iedLargeItems select(floor random(count _iedLargeItems));
				_junkType = _iedLargeItems select (floor random (count _iedLargeItems));
			};
		};
		
		_rdist1 = 5;
		_offSetDirection = 1;
		if((random 100) > 50) then { _offSetDirection = -1;};
				
		_road = _roads select(floor random(count _roads));
		while{isnil("_road")} do {_road = _roads select(floor random(count _roads));}; //sometimes _road is nil
		_dir  = getDir _road;
		_position = getpos _road;
		_positionX = _position select 0;
		_positionY = _position select 1;
		_tx = (_positionX + (_rdist1 * sin(_dir)));
		_ty = (_positionY + (_rdist1 * cos(_dir)));
			
		while{isOnRoad [_tx,_ty,0]} do{
			_rdist1 = _rdist1 + _offSetDirection;
			_tx = (_positionX + (_rdist1 * sin(_dir)));
			_ty = (_positionY + (_rdist1 * cos(_dir)));
		};	
		
		_extraOffSet = 1 + random 5;
		//move it off the road
		_tx = (_positionX + ((_rdist1 + _extraOffSet *_offSetDirection) * sin(_dir)));
		_ty = (_positionY + ((_rdist1 + _extraOffSet *_offSetDirection) * cos(_dir)));
		
		while{isOnRoad [_tx,_ty,0]} do
		{
			_extraOffSet = _extraOffSet - 0.5;
			_tx = (_positionX + ((_rdist1 + _extraOffSet *_offSetDirection) * sin(_dir)));
			_ty = (_positionY + ((_rdist1 + _extraOffSet *_offSetDirection) * cos(_dir)));
		};
				
		_iedPos = [_tx,_ty,0];
		
		call compile format ['ied_%1 = _iedType createVehicle _iedPos;
							ied_%1 setDir (random 360);
							ied_%1 enableSimulation false;
							ied_%1 setPos %2', _counterOffset+_counter, _iedPos];
						
		_rdist2 = 5;
		_offSetDirection = 1;
		if((random 100) > 50) then {_offSetDirection = -1;};
		
		
		_road2 = _roads select(floor random(count _roads));
		while{(isnil("_road2"))} do { 
			_road2 = _roads select(floor random(count _roads));
			if(_road2 == _road) then { _road2 = nil; };
		};
		_dir = getDir _road2;
		_junkPos = getpos _road2;
		_junkPosX = _junkPos select 0;
		_junkPosY = _junkPos select 1;
		_junktx = (_junkPosX + (_rdist2 * sin(_dir)));
		_junkty = (_junkPosY + (_rdist2 * cos(_dir)));

		while{isOnRoad [_junktx,_junkty, 0]} do{
			_rdist2 = _rdist2 + _offSetDirection;
			_junktx = (_junkPosX + (_rdist2 * sin(_dir)));
			_junkty = (_junkPosY + (_rdist2 * cos(_dir)));
		};
		_extraOffSet = 1 + random 5;
		//move it off the road
		_junktx = (_junkPosX + ((_rdist2 + _extraOffSet *_offSetDirection) * sin(_dir)));
		_junkty = (_junkPosY + ((_rdist2 + _extraOffSet *_offSetDirection) * cos(_dir)));
		
		while{isOnRoad [_junktx,_junkty,0]} do
		{
			_extraOffSet = _extraOffSet - 0.5;
			_junktx = (_junkPosX + ((_rdist2 + _extraOffSet *_offSetDirection) * sin(_dir)));
			_junkty = (_junkPosY + ((_rdist2 + _extraOffSet *_offSetDirection) * cos(_dir)));
		};
		
		_junkPosition = [_junktx,_junkty, 0];
		_junk = _junkType createVehicle _junkPosition;
		_junk setdir(random 360);
		_junk setPos _junkPosition;
		
		call compile format [' t_%1 = createTrigger["EmptyDetector", _iedPos];
		t_%1 setTriggerArea[11,11,0,true];
		t_%1 setTriggerActivation [_side,"PRESENT",false];
		t_%1 setTriggerStatements ["[this, thislist, %2, %3] call EPD_EXPLOSION_CHECK && (alive ied_%1)","[%2] spawn EPD_EXPLOSIVESEQUENCE_%4; deletevehicle ied_%1; deleteVehicle thisTrigger",""];
		',_counterOffset+_counter, _iedPos,_debug,_iedSize];
		
		call compile format ['
		[[ied_%1, t_%1],"Disarm", true, true] spawn BIS_fnc_MP;', _counterOffset+_counter];
		
		if(_debug) then {
			
			call compile format ['
			bombmarker_%1 = createmarker ["bombmarker_%1", _iedPos];
			"bombmarker_%1" setMarkerTypeLocal "hd_warning";
			"bombmarker_%1" setMarkerColorLocal "ColorRed";
			"bombmarker_%1" setMarkerTextLocal "%2";', _counterOffset+_counter,_iedSize];
			
			call compile format ['
			fakebombmarker_%1 = createmarker ["fakebombmarker_%1", _junkPosition];
			"fakebombmarker_%1" setMarkerTypeLocal "hd_warning";
			"fakebombmarker_%1" setMarkerColorLocal "ColorBlue";
			"fakebombmarker_%1" setMarkerTextLocal "fake";', _counterOffset+_counter];
		};

		
		_counter = _counter + 1;
	};
};

EPD_EXPLOSION_CHECK = {
	if(_this select 0) then
	{
		_iedPos = _this select 2;
		_objects = _this select 1;
		_minDistance = 10000;
		_minHeight = 10000;
		_maxSpeed = 0;
		{
			_dist = (position _x distance _iedPos);
			if(_dist < _minDistance) then {
				_minDistance = _dist;
			};
		
			if(speed _x > _maxSpeed) then
			{
				_maxSpeed = speed _x;
			};
			if((position _x) select 2 < _minheight) then {
				_minHeight = (position _x) select 2;
			};
		} foreach _objects;
		
		if(_this select 3) then {
			hintSilent format["People/Vehicles in trigger = %1\nMax Speed = %2\nMin Height = %3\nDistance = %4", count _objects,_maxSpeed, _minHeight,_minDistance];
		};	
		
		if((_maxSpeed > 5.2) and (_minHeight < 3)) then {true; } else {false;}; 
	} else {
		false;
	};
};

EPD_EXPLOSIVESEQUENCE_SMALL ={
	_iedPosition = _this select 0;
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 
	
	[[_iedPosition, _explosiveSequence], "EPD_INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

EPD_EXPLOSIVESEQUENCE_MEDIUM ={
	_iedPosition = _this select 0;
	//_explosiveSequence = ["HelicopterExploSmall","M_Titan_AA_long","HelicopterExploSmall","M_PG_AT","M_Titan_AT", "R_230mm_HE"];
	_explosiveSequence = ["M_Titan_AA_long","HelicopterExploSmall","M_PG_AT","M_Titan_AT"];
	
	[[_iedPosition, _explosiveSequence], "EPD_INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

EPD_EXPLOSIVESEQUENCE_LARGE ={
	_iedPosition = _this select 0;
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","M_Titan_AA_long","HelicopterExploSmall","M_Titan_AA_long", "M_PG_AT","M_Titan_AT"]; 
	
	[[_iedPosition, _explosiveSequence], "EPD_INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

EPD_INITIAL_EXPLOSION = {
	
	_iedPosition = _this select 0;
	_explosiveSequence = _this select 1;
	
	for "_i" from 0 to (count _explosiveSequence) -1 do{
		_explosive = (_explosiveSequence select _i);
		_xCoord = random 2;
		if((floor random 2) == 1) then { _xCoord = -1 * _xCoord};
		_yCoord = random 2;
		if((floor random 2) == 1) then { _yCoord = -1 * _yCoord};
		_zCoord = random 0;
		if((floor random 2) == 1) then { _zCoord = -1 * _zCoord};
		_bomb = _explosive createVehicle _iedPosition;
		_bomb setPos [(getPos _bomb select 0)+_xCoord,(getPos _bomb select 1)+_yCoord, 0];
		
		sleep .01;
		addCamShake[1+random 5, 1+random 3, 5+random 15];
	};
	_x = [(_iedPosition select 0) + 0.75, (_iedPosition select 1) + 0.75, (_iedPosition select 2) + 0.75];
	_y = [(_iedPosition select 0) - 0.75, (_iedPosition select 1) - 0.75, (_iedPosition select 2) - 0.75];
	//[[_iedPosition],"EPD_CREATESMOKE",true,false] spawn BIS_fnc_MP;
	//[[_x],"EPD_CREATESMOKE",false] spawn BIS_fnc_MP;
	//[[_y],"EPD_CREATESMOKE",false] spawn BIS_fnc_MP;
	
	
	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;
	
	if(50>random 100) then {
		_sleepTime = 15 + random 25;
		hint format["Incoming secondary explosions in %1 seconds!",_sleepTime];
		sleep _sleepTime;
		[_iedPosition] spawn EPD_SECONDARY_EXPLOSIONS;
	};	
};

EPD_SECONDARY_EXPLOSIONS = {
	_iedPosition = _this select 0;
	_explosiveSequence = ["R_80mm_HE","M_PG_AT","M_PG_AT","R_80mm_HE","M_PG_AT","R_80mm_HE","M_PG_AT","M_PG_AT","M_PG_AT","R_80mm_HE"];
	
	for "_i" from 0 to (count _explosiveSequence) -1 do{
		_explosive = (_explosiveSequence select _i);
		_xCoord = random 2;
		if((floor random 2) == 1) then { _xCoord = -1 * _xCoord};
		_yCoord = random 2;
		if((floor random 2) == 1) then { _yCoord = -1 * _yCoord};
		_zCoord = random 5;
		if((floor random 2) == 1) then { _zCoord = -1 * _zCoord};
		_bomb = _explosive createVehicle _iedPosition;
		_bomb setPos [(getPos _bomb select 0)+_xCoord,(getPos _bomb select 1)+_yCoord, 0];
		
		_i = _i + floor random 7;
		
		sleep random 5;
		addCamShake[1+random 5, 1+random 3, 5+random 15];
	};
};