EXPLOSIVESEQUENCE_SMALL = {
	_explosiveSequence = ["M_PG_AT"]; 
	[_this, _explosiveSequence, true, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_MEDIUM = {
	_explosiveSequence = ["HelicopterExploBig","M_PG_AT","M_Titan_AT"];
	[_this, _explosiveSequence, true, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_LARGE = {
	_explosiveSequence = ["Bo_GBU12_LGB_MI10", "HelicopterExploSmall"];
	[_this, _explosiveSequence, true, true] spawn PRIMARY_EXPLOSION;
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
	_iedArray = (_this select 0) call GET_IED_ARRAY;
	_iedPosition = (_this select 0) call REMOVE_IED_ARRAY;
	(_this select 0 select 0) call INCREMENT_EXPLOSION_COUNTER;
	_explosiveSequence = (_this select 1);
	_createSecondary = (_this select 2);
	_createSmoke = [_this, 3, true] call BIS_fnc_param;
	
	[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
	
	if(_createSmoke) then {
		[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;
	};

	lastIedExplosion = _iedPosition;
	publicVariable "lastIedExplosion";
	
	//fragmentation
	0 = _iedPosition spawn {
		_pos = _this;
		_numberOfFragments = 200;
		for "_i" from 0 to _numberOfFragments - 1 do{
			_pos set[2,.1 + random 2]; 
			_bullet = "B_408_Ball" createVehicle _pos;
			_angle = random 360;
			_speed = 450 + random 100;
			_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
		};
	};
	
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
	
	
	
	if(_createSecondary) then {
		if(random 100 < secondaryChance) then {
			_sleepTime = 5;
			if(EPD_IED_debug) then {
				hint format["Creating Secondary Explosive"];
			};
			sleep _sleepTime;
			[[_iedPosition, _iedArray select 2, _this select 0 select 0], "CREATE_SECONDARY_IED", false, false] call BIS_fnc_MP;
		};
	};
	
	
	publicVariable "iedDictionary";
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