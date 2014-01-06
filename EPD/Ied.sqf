/* original work from: Tankbuster */
/* adapted from:  Dynamic IED script by - Mantis -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

if(!isserver) exitwith {};
if (isnil ("iedcounter")) then {iedcounter=0;} ;
if (isnil ("junkcounter")) then {junkcounter=0;} ;
	
ehExplosiveSuperClasses = ["RocketCore", "MissileCore", "SubmunitionCore", "GrenadeCore", "ShellCore"];

explosiveSuperClasses = ["TimeBombCore","BombCore", "Grenade"];
	
explosiveBullets = ["B_20mm", "B_20mm_Tracer_Red", "B_30mm_HE", "B_30mm_HE_Tracer_Green", "B_30mm_HE_Tracer_Red", "B_30mm_HE_Tracer_Yellow", "B_30mm_MP", "B_30mm_MP_Tracer_Green", "B_30mm_MP_Tracer_Red", "B_30mm_MP_Tracer_Yellow", "B_35mm_AA", "B_35mm_AA_Tracer_Green", "B_35mm_AA_Tracer_Red", "B_35mm_AA_Tracer_Yellow", "B_40mm_GPR", "B_40mm_GPR_Tracer_Green", "B_40mm_GPR_Tracer_Red", "B_40mm_GPR_Tracer_Yellow"];
	
thingsToIgnore = ["SmokeShell", "FlareCore", "IRStrobeBase", "GrenadeHand_stone", "Smoke_120mm_AMOS_White", "TMR_R_DG32V_F"];

private["_paramArray", "_paramCounter"];

_paramCounter = 0;
_paramArray = _this;

while{_paramCounter < count _paramArray} do {

	_arr = _paramArray select _paramCounter;
	_paramCounter = _paramCounter + 1;
	
	//["marker", iedsToPlace, fakesToPlace, side]
	//["marker", amountToPlace, side]
	//["marker", side]
	//["predefinedLocation", side]
	//["predefinedLocation", amountToPlace, side];
	//["predefinedLocation", iedsToPlace, fakesToPlace, side];
	
	_origin = [0,0,0];
	_distance = [0,0,0];
	_cityIndex = -1;//_cityNames find (_arr select 0);
	for "_i" from 0 to (count predefinedLocations) -1 do{
		if(predefinedLocations select _i select 0 == _arr select 0) then {
			_cityIndex = _i;
			_i = (count predefinedLocations);
		};
	};
	
	
	if(_cityIndex > -1) then {
		_origin = predefinedLocations select _cityIndex select 1;
		_distance = predefinedLocations select _cityIndex select 2;
		
	} else {
		_origin = getmarkerpos (_arr select 0);
		if(hideIedMarker) then {
			(_arr select 0) setMarkerAlpha 0;
		};
		_size = getMarkerSize (_arr select 0);
		_distance = ((_size select 0) min (_size select 1));
	};
	
	if(not ([_origin,[0,0,0]] call BIS_fnc_areEqual)) then { //don't bother if the marker doesn't exist
		if(_distance > 1) then {
			_side = "";
			_iedsToPlace = 0;
			_junkToPlace = 0;
			if(count _arr == 2) then
			{
				_iedsToPlace = ceil (_distance / 100.0);
				_junkToPlace = _iedsToPlace;
				_side = _arr select 1;
			} else {
				if( count _arr == 3) then
				{
					_iedsToPlace = _arr select 1;
					_junkToPlace = _iedsToPlace;
					_side = _arr select 2;
				} else {
					_iedsToPlace = _arr select 1;
					_junkToPlace = _arr select 2;
					_side = _arr select 3;
				};
			};
			
			//prevent race condition...
			_iedc = iedcounter;
			_junkc = junkcounter;
			
			[[_origin, _distance, _side, _iedsToPlace, _junkToPlace, _iedc, _junkc], "CREATE_RANDOM_IEDS", false,false] spawn BIS_fnc_MP;
			iedcounter = iedcounter + _iedsToPlace;
			junkcounter = junkcounter + _junkToPlace;
		}
		else  //single IED exactly on the marker spot
		{
			_side = _arr select ((count _arr) -1); 
			
			//prevent race condition...
			_iedc = iedcounter;
			
			[[_iedc, _origin, _side], "CREATE_SPECIFIC_IED", false,false] spawn BIS_fnc_MP;
			iedcounter = iedcounter + 1;
		};
	};
};

CREATE_SPECIFIC_IED = {
	
	_iedNumber = _this select 0;
	_origin = _this select 1;
	_side = _this select 2;
	
	_st = [] call GET_SIZE_AND_TYPE;
	[_iedNumber, _origin, _st select 0, _st select 1, _side] spawn { call CREATE_IED; };
};

CREATE_RANDOM_IEDS = {
	_origin = (_this select 0);
	_distance = (_this select 1);
	_side = (_this select 2);
	_iedAmountToPlace = (_this select 3);
	_fakeAmountToPlace = (_this select 4);
	_iedCounterOffset = (_this select 5);
	_fakeCounterOffset = (_this select 6);
	
	_counter = 0;
	
	_roads = _origin nearRoads _distance;
	if(count _roads == 0) exitwith {}; //if there are no roads in this circle of life....
	while{_counter < _iedAmountToPlace} do {
		
		_iedSize = [] call GET_SIZE_AND_TYPE;
		_iedType = _iedSize select 1;
		_iedSize = _iedSize select 0;
		_iedPos = [_roads] call FIND_LOCATION_BY_ROAD;
		[_iedCounterOffset+_counter, _iedPos, _iedSize, _iedType, _side] call CREATE_IED;	
		_counter = _counter + 1;
	};
	
	_counter = 0;
	while{_counter < _fakeAmountToPlace} do {
	
		_junkType = ([] call GET_SIZE_AND_TYPE) select 1;
		_junkPosition = [_roads] call FIND_LOCATION_BY_ROAD;
		[_fakeCounterOffset+_counter,_junkPosition, _junkType] call CREATE_FAKE;
		_counter = _counter + 1;
	};
};

GET_SIZE_AND_TYPE = {
	_size = "SMALL";
	 r = floor random (smallChance+mediumChance+largeChance);
	 if(r>smallChance) then {
		_size = "MEDIUM";
	 };
	 
	 if(r>smallChance+mediumChance) then {
		_size = "LARGE";
	 };
	
	_type = "";
	if(_size == "SMALL") then
	{
		_type = iedSmallItems select(floor random(count iedSmallItems));
	} else {
		if(_size == "MEDIUM") then
		{
			_type = iedMediumItems select(floor random(count iedMediumItems));
		} else { //large
			_type = iedLargeItems select(floor random(count iedLargeItems));
		};
	};
	[_size,_type];
};

FIND_LOCATION_BY_ROAD = {
	_roads = _this select 0;
	_orthogonalDist = 5;
	_road = _roads select(floor random(count _roads));
	_dir = 0;
	if(count (roadsConnectedTo _road) > 0) then {
		_dir  = [_road, (roadsConnectedTo _road) select 0] call BIS_fnc_DirTo;
	};
	_position = getpos _road;
	_opositionX = _position select 0;
	_opositionY = _position select 1;
	
	_offSetDirection = 1;
	if((random 100) > 50) then { _offSetDirection = -1;};
	
	_positionX = _opositionX + (random 5) * _offSetDirection * sin(_dir);
	_positionY = _opositionY + (random 5) * _offSetDirection * cos(_dir);
	
	if((random 100) > 50) then { _offSetDirection = -1 * _offSetDirection;};		
	
	_tx = _positionX;
	_ty = _positionY;
	
	while{isOnRoad [_tx,_ty,0]} do{
		_orthogonalDist = _orthogonalDist + _offSetDirection;
		_tx = (_positionX + (_orthogonalDist * cos(_dir)));
		_ty = (_positionY + (_orthogonalDist * sin(_dir)));
	};	
	
	_extraOffSet = 1 + random 5;
	//move it off the road a random amount
	_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
	_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));
	
	//ensure we didn't put it on another road, this happens a lot at Y type intersections
	while{isOnRoad [_tx,_ty,0]} do
	{
		_extraOffSet = _extraOffSet - 0.5;
		_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
		_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));
	};
			
	[_tx,_ty,0];
};

CREATE_IED = {
	_iedNumber = _this select 0;
	_iedPos = _this select 1;
	_iedSize = _this select 2;
	_iedType = _this select 3;
	_side = _this select 4;
	
	call compile format ['ied_%1 = _iedType createVehicle _iedPos;
							ied_%1 setDir (random 360);
							ied_%1 enableSimulation false;
							ied_%1 setPos _iedPos;
							ied_%1 allowDamage false;
							ied_%1 addeventhandler ["HitPart", {[_this, ied_%1, "%2", %3, %1, "%4", t_%1] call EXPLOSION_EVENT_HANDLER; }];
						', _iedNumber,_iedSize, _iedPos, _side];
													
	call compile format [' t_%1 = createTrigger["EmptyDetector", _iedPos];
	t_%1 setTriggerArea[11,11,0,true];
	t_%1 setTriggerActivation [_side,"PRESENT",false];
	t_%1 setTriggerStatements ["[this, thislist, %2, %1] call EXPLOSION_CHECK && (alive ied_%1)","terminate pd_%1; [%2, ied_%1, %1,%4] spawn EXPLOSIVESEQUENCE_%3; deleteVehicle thisTrigger;",""];
	',_iedNumber, _iedPos,_iedSize, _side];
	
	call compile format['pd_%1 = [ied_%1, %1, _iedSize, t_%1, _side] spawn PROJECTILE_DETECTION;', _iedNumber];
	
	call compile format ['
	[[ied_%1, t_%1, pd_%1],"Disarm", true, true] spawn BIS_fnc_MP;', _iedNumber];
	
	if(debug) then {		
			
		call compile format ['
		bombmarker_%1 = createmarker ["bombmarker_%1", _iedPos];
		"bombmarker_%1" setMarkerTypeLocal "hd_warning";
		"bombmarker_%1" setMarkerColorLocal "ColorRed";
		"bombmarker_%1" setMarkerTextLocal "%2";', _iedNumber, _iedSize];
	};
};

CREATE_FAKE = {
	_fakeNumber = _this select 0;
	_junkPosition = _this select 1;
	_junkType = _this select 2;
	
	_junk = _junkType createVehicle _junkPosition;
	_junk setdir(random 360);
	_junk setPos _junkPosition;
	
	if(debug) then {		
		call compile format ['
		fakebombmarker_%1 = createmarker ["fakebombmarker_%1", _junkPosition];
		"fakebombmarker_%1" setMarkerTypeLocal "hd_warning";
		"fakebombmarker_%1" setMarkerColorLocal "ColorBlue";
		"fakebombmarker_%1" setMarkerTextLocal "fake";', _fakeNumber];
	};
};

EXPLOSION_CHECK = {
	if(_this select 0) then
	{
		_triggerNum = _this select 3;
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
		
		if(debug) then {
			hintSilent format["Trigger %5\nPeople/Vehicles in trigger = %1\nMax Speed = %2\nMin Height = %3\nDistance = %4", count _objects,_maxSpeed, _minHeight,_minDistance, _triggerNum];
		};	
		
		if((_maxSpeed > 5.2) and (_minHeight < 3)) then { true; } else {false;}; 
	} else {
		false;
	};
};


EXPLOSIVESEQUENCE_SMALL ={
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_side = _this select 3;
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 
	
	[[_iedPosition, _explosiveSequence, _ied, _iedNumber, _side], "INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

EXPLOSIVESEQUENCE_MEDIUM ={
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_side = _this select 3;
	_explosiveSequence = ["M_Titan_AA_long","HelicopterExploSmall","M_PG_AT","M_Titan_AT"];
	
	[[_iedPosition, _explosiveSequence, _ied, _iedNumber, _side], "INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

EXPLOSIVESEQUENCE_LARGE ={
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_side = _this select 3;
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","M_Titan_AA_long","HelicopterExploSmall","M_Titan_AA_long", "M_PG_AT","M_Titan_AT"]; 
	
	[[_iedPosition, _explosiveSequence, _ied, _iedNumber, _side], "INITIAL_EXPLOSION", true,true] spawn BIS_fnc_MP;
};

INITIAL_EXPLOSION = {
	_iedPosition = _this select 0;
	_explosiveSequence = _this select 1;
	(_this select 2) removeAllEventHandlers "HitPart";
	deleteVehicle (_this select 2);
	_iedNumber = _this select 3;
	_side = _this select 4;
	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;	
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
		[[getPos _bomb] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep .01;
	};
	
	if(secondaryChance>random 100) then {
		_sleepTime = 15;
		if(debug) then {
			hint format["Creating Secondary Explosive"];
		};
		sleep _sleepTime;
		[_iedPosition, _iedNumber, _side] spawn SPAWN_SECONDARY;
	};	
};

EXPLOSIVESEQUENCE_SECONDARY = {
	_iedPosition = _this select 0;
	(_this select 1) removeAllEventHandlers "HitPart";
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
		[[getPos _bomb] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
		_i = _i + floor random 7;
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep .01;
		
	};
};

SPAWN_SECONDARY = {
	_location = _this select 0;
	_iedNumber = _this select 1;
	_side = format["%1", _this select 2];
	_theta = random 360;
	_offset = 4 + random 12;
	_iedPos = [(_location select 0) + _offset*cos(_theta), (_location select 1) + _offset*sin(_theta),0];
	_iedType = iedSecondaryItems select(floor random(count iedSecondaryItems));
	call compile format ['secied_%1 = _iedType createVehicle _iedPos;
							secied_%1 setDir (random 360);
							secied_%1 enableSimulation false;
							secied_%1 setPos _iedPos;
							secied_%1 allowDamage false;
							secied_%1 addeventhandler ["HitPart", {[_this, secied_%1, "%2", "SECONDARY", %1, "%3", t_%1] call EXPLOSION_EVENT_HANDLER; }];
						', _iedNumber, _iedPos, _side];
						
	call compile format [' st_%1 = createTrigger["EmptyDetector", _iedPos];
	st_%1 setTriggerArea[11,11,0,true];
	st_%1 setTriggerActivation [_side,"PRESENT",false];
	st_%1 setTriggerStatements ["[this, thislist, %2, %1] call EXPLOSION_CHECK && (alive secied_%1)","terminate pd_%1; [%2] spawn EXPLOSIVESEQUENCE_SECONDARY; deleteVehicle thisTrigger;  deleteVehicle secied_%1",""];
	',_iedNumber, _iedPos];
	
	call compile format['pd_%1 = [secied_%1, %1, "SECONDARY", st_%1, _side] spawn PROJECTILE_DETECTION;', _iedNumber];
	
	call compile format ['
	[[secied_%1, st_%1, pd_%1],"Disarm", true, true] spawn BIS_fnc_MP;', _iedNumber];
	
	if(debug) then {		
		hint format["Secondary Explosive Created"];
		call compile format ['
		secbombmarker_%1 = createmarker ["secbombmarker_%1", _iedPos];
		"secbombmarker_%1" setMarkerTypeLocal "hd_warning";
		"secbombmarker_%1" setMarkerColorLocal "ColorGreen";
		"secbombmarker_%1" setMarkerTextLocal "Secondary";', _iedNumber];
	};
	
};


//http://forums.bistudio.com/showthread.php?170903-How-do-you-find-out-what-type-of-explosive-hit-an-object
//Detects projectiles that go near this object
PROJECTILE_DETECTION = {
	if(!allowExplosiveToTriggerIEDs) exitWith {}; 

	_range = 35;
	_ied = _this select 0;
	_iedNumber = _this select 1;
	_iedSize = _this select 2;
	_trigger = _this select 3;
	_side = _this select 4;

	_fired = [];
	while {alive _ied} do 
	{
		_list = (position _ied) nearObjects ["Default",_range]; //Default = superclass of ammo

		if (count _list >=1) then 
		{
			_ammo = _list select 0;

			if (!(_ammo in _fired)) then
			{
				[_ammo, _ied, _trigger, _iedSize, typeof _ammo, getpos _ammo, _iedNumber, _side ] spawn EXPLOSION_WATCHER;
				_fired = _fired + [_ammo];
			};
		};
		sleep 0.1;
		//remove dead projectiles
		_fired = _fired - [objNull];
	};
};

//watch projectiles that passed by these and sees if they are explosives and if they are close enough to set off the IED
EXPLOSION_WATCHER = {
	_isExplosive = false;
	_item = _this select 0;
	_class = _this select 4;
	_position = _this select 5;
	
	{
		if(_class iskindof _x) then {
			_isExplosive = true;
		};
	} foreach explosiveSuperClasses;
	
	{//smoke grenades.. chem lights.. ir strobes.. rocks..
		if(_class iskindof _x) then{
			_isExplosive = false;
		}
	} foreach thingsToIgnore;

	if(_isExplosive) then {
		_updateInterval = .1;
		_radius = 49;		
		_ied = _this select 1;
		_trigger = _this select 2;
		
		while {(alive _item) and !(isnull _ied) and !(isnull _trigger)} do {
			_position = getpos _item;
			sleep _updateInterval;
		};
		
		_origin = getpos (_this select 1);
		
		if(debug) then {player sidechat format["distance = %1", (_origin distance _position)]; };
		if((_origin distancesqr _position < _radius) and !(isnull _ied) and !(isnull _trigger)) then {
			_chance = 100;
			if(_class iskindof "Grenade") then { _chance = 35; };
			
			_r = random 100;
			if(debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_class];};
			if(_r < _chance) then {
				_iedNumber = _this select 6;
				_side = _this select 7;
				_iedSize = _this select 3;
				if(debug) then { player sidechat format ["%1 triggered IED",_class]; };
				if(!(isnull _ied)) then {
					_ied removeAllEventHandlers "HitPart";
					call compile format["terminate pd_%2; [_origin, _ied, _iedNumber, _side] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];
					deleteVehicle _ied;
					deleteVehicle _trigger;
				};
			};
		};
	};
};

EXPLOSION_EVENT_HANDLER = {
	hint "hi";
	_ied = _this select 1;	
	if((!allowExplosiveToTriggerIEDs) or (isnull _ied)) exitwith{};
	
	_iedSize = _this select 2; 
	_iedPosition = _this select 3;
	_iedNumber = _this select 4;
	_side = _this select 5;
	_trigger = _this select 6;
	
	_projectile =  _this select 0 select 0 select 6 select 4;
	
	_isExplosive = false;
	_isExplosiveBullet = false;

	{
		if(_projectile iskindof _x) then {
			_isExplosive = true;
		};
	} foreach ehExplosiveSuperClasses;
	
	if((! _isExplosive) && (_projectile in explosiveBullets)) then
	{
		_isExplosiveBullet = true;
	};
	
	{//smoke grenades.. chem lights.. ir strobes.. rocks..
		if(_projectile iskindof _x) then{
			_isExplosive = false;
			_isExplosiveBullet = false;
		}
	} foreach thingsToIgnore;
	
	if(_isExplosive || _isExplosiveBullet) then {
		_chance = 100;
			
		if(_projectile iskindof "GrenadeCore") then { _chance = 50; };
		if(_isExplosiveBullet) then {_chance = 40; };
		
		_r = random 100;
		if(debug) then {hint format["random = %1\nmax to explode = %2\n%3",_r,_chance,_projectile];};
		if(_r < _chance) then {
		
		_ied removeAllEventHandlers "HitPart";
		deleteVehicle _ied;
		deleteVehicle _trigger;
			
			if(debug) then { player sidechat format ["%1 triggered IED",_projectile]; };
			if(!(isnull _ied) and !(isnull _trigger)) then {
				call compile format["terminate pd_%2; [_iedPosition, _ied, _iedNumber, _side] call EXPLOSIVESEQUENCE_%1", _iedSize, _iedNumber ];	
			};
		};
	};
};