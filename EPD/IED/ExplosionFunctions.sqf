EXPLOSIVESEQUENCE_SMALL = {
	_explosiveSequence = ["M_Titan_AP","M_Titan_AP"]; 
	[_this, _explosiveSequence, true, true, "small", floor random 8] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_MEDIUM = {
	_explosiveSequence = ["HelicopterExploBig","M_PG_AT","M_Titan_AT","M_Titan_AP"];
	[_this, _explosiveSequence, true, true, "medium", 5+floor random 15] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_LARGE = {
	_explosiveSequence = ["Bo_GBU12_LGB_MI10", "HelicopterExploSmall"];
	[_this, _explosiveSequence, true, true, "large", 15+floor random 20] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_DISARM = {
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10"];
	[_this, _explosiveSequence, false, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_SECONDARY = {
	_explosiveSequence = ["R_80mm_HE","R_80mm_HE"];
	[_this, _explosiveSequence, false, false] spawn PRIMARY_EXPLOSION;
};

PRIMARY_EXPLOSION = {
	_iedArray = [];
	try{
		_iedArray = (_this select 0) call GET_IED_ARRAY;
		if(typeName _iedArray != "ARRAY") exitWith {if(EPD_IED_debug) then { hint "attempt to blow up already disarmed ied caught";};}; 
		
		_iedPosition = getpos (_iedArray select 0);
		terminate (_iedArray select 5);	//need to stop these so we don't get double explosions
		deleteVehicle (_iedArray select 1);  //need to stop these so we don't get double explosions
		(_iedArray select 0) removeAllEventHandlers "HitPart";
		(_this select 0 select 0) call INCREMENT_EXPLOSION_COUNTER;
		_explosiveSequence = (_this select 1);
		_createSecondary = (_this select 2);
		_createSmoke = [_this, 3, true] call BIS_fnc_param;
		_size = [_this, 4, "large"] call BIS_fnc_param;
		_numberOfPlumes = [_this,5,0] call BIS_fnc_param;
		_numberOfFragments = 150;
		
		[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
		
		lastIedExplosion = _iedPosition;
		publicVariable "lastIedExplosion";
		
		0 = [_iedPosition, _explosiveSequence] spawn {
			_iedPosition = _this select 0;
			_explosiveSequence = _this select 1;
			
			for "_i" from 0 to (count _explosiveSequence) -1 do{
				[[_iedPosition] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
				_explosive = (_explosiveSequence select _i);
				_xCoord = (random 4)-2;
				_yCoord = (random 4)-2;
				_ied = _explosive createVehicle _iedPosition;
				_ied setPos [(_iedPosition select 0)+_xCoord,(_iedPosition select 1)+_yCoord, 0];
				if(((position player) distanceSqr getPos _ied) < 40000) then {  //less than 200 meters away
					addCamShake[1+random 5, 1+random 3, 5+random 15];
				};
				sleep .01;
			};
		};
		
		
		//plumes
		[_numberOfPlumes, _iedPosition] spawn CREATE_PLUMES;
		
		if(_createSmoke) then {
			if(_size == "large") then {
				[[_iedPosition] , "IED_SMOKE_LARGE", true, false] spawn BIS_fnc_MP;
				_numberOfFragments = 300;
			} else {
				if(_size == "small") then {
					[[_iedPosition] , "IED_SMOKE_SMALL", true, false] spawn BIS_fnc_MP;
					_numberOfFragments = 100;
				} else {
					if(_size == "medium") then {
						[[_iedPosition] , "IED_SMOKE_MEDIUM", true, false] spawn BIS_fnc_MP;
						_numberOfFragments = 200;
					};
				};
			};
		};
		
		//fragmentation
		[_iedPosition, _numberOfFragments] spawn CREATE_FRAGMENTS;
		
		sleep .5;
		(_this select 0) call REMOVE_IED_ARRAY;
		
		if(_createSecondary) then {
			if(random 100 < secondaryChance) then {
				_sleepTime = 10;
				if(EPD_IED_debug) then {
					hint format["Creating Secondary Explosive"];
				};
				sleep _sleepTime;
				[[_iedPosition, _iedArray select 2, _this select 0 select 0], "CREATE_SECONDARY_IED", false, false] call BIS_fnc_MP;
			};
		};
		
		sleep 5;
		publicVariable "iedDictionary";
	} catch {
		if (true) exitWith {hint "not allowed to blow this ied up";}; 
	};
};

CREATE_FRAGMENTS = {
	_pos = _this select 0;
	_numberOfFragments = _this select 1;
	for "_i" from 0 to _numberOfFragments - 1 do{
		_pos set[2,.1 + random 2]; 
		_bullet = "B_408_Ball" createVehicle _pos;
		_angle = random 360;
		_speed = 450 + random 100;
		_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
	};
};

CREATE_PLUMES = {
	_upwards = 200;
	_horizontal = 500;
	_numberOfPlumes = _this select 0;
	_loc = _this select 1;
	
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
	
	for "_i" from 0 to _numberOfPlumes - 1 do{
		0 = [_loc, _aslLoc, _horizontal, _upwards] spawn {
			_loc = _this select 0;
			_aslLoc = _this select 1;
			_horizontal = _this select 2;
			_upwards = _this select 3;
			
			_thingToFling = "Land_Bucket_F" createVehicle [0,0,0];
			hideObject _thingToFling;
			hideObjectGlobal _thingToFling;
			_thingToFling allowDamage false;
			_thingToFling setPos [_loc select 0, _loc select 1, 1];
			
			
			_r = floor random 3;
			switch(_r) do
			{
				case 0:
				{
					[[_thingToFling, _aslLoc], "SAND_TRAIL_SMOKE", true, false] call BIS_fnc_MP;
				};
				case 1: 
				{
					[[_thingToFling, _aslLoc], "GRAY_TRAIL_SMOKE", true, false] call BIS_fnc_MP;
				};
				case 2:
				{
					[[_thingToFling, _aslLoc], "BROWN_TRAIL_SMOKE", true, false] call BIS_fnc_MP;
				};
			};	

			sleep .01;
			
			_hor1 = (random _horizontal)-(_horizontal/2);
			_hor2 = (random _horizontal)-(_horizontal/2);
			_ver = 1+(random _upwards);
			_thingToFling setVelocity [_hor1, _hor2, _ver ];
			
			sleep ( random .5);
			
			_thingToFling setpos [0,0,0];
			deletevehicle _thingToFling;
	
		};
		sleep .001;
	};
};

/*------ stops a tank
Bo_GBU12_LGB_MI10
Bo_GBU12_LGB
Bo_Mk82
------ stops a marshall
HelicopterExploSmall

------stops a hunter
M_Mo_82mm_AT_LG
HelicopterExploBig
M_Air_AA_MI02 

------ low damage
M_Titan_AA_long
M_Zephyr
M_Air_AT
M_Titan_AA
M_Titan_AT
R_80mm_HE
M_PG_AT

------ white smoke glows bright at night
R_230mm_HE*/