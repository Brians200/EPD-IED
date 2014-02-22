EXPLOSIVESEQUENCE_SMALL = {
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 
	[_this, _explosiveSequence, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_MEDIUM = {
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 
	[_this, _explosiveSequence, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_LARGE = {
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 
	[_this, _explosiveSequence, true] spawn PRIMARY_EXPLOSION;
};

EXPLOSIVESEQUENCE_DISARM = {
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10","M_PG_AT","R_80mm_HE"];
	[_this, _explosiveSequence, true] spawn PRIMARY_EXPLOSION;
};


PRIMARY_EXPLOSION = {
	_iedPosition = (_this select 0) call REMOVE_IED_ARRAY;
	_explosiveSequence = (_this select 1);
	_createSecondary = (_this select 2);
	
	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;	
	[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;

	//fragmentation
	0 = _iedPosition spawn {
		_pos = _this;
		_pos set[2,.1 + random 1]; 
		_numberOfFragments = 200;
		for "_i" from 0 to _numberOfFragments - 1 do{
			_bullet = "B_127x99_Ball_Tracer_Green" createVehicle _pos;
			_angle = random 360;
			_speed = 450 + random 100;
			_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), random 2];
		}
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
	
};

/*INITIAL_EXPLOSION = {
	_iedPosition = _this select 0;
	_explosiveSequence = _this select 1;
	(_this select 2) removeAllEventHandlers "HitPart";
	deleteVehicle (_this select 2);
	_iedNumber = _this select 3;

	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;	
	[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
	for "_i" from 0 to (count _explosiveSequence) -1 do{
		[[_iedPosition] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
		_explosive = (_explosiveSequence select _i);
		_xCoord = (random 4)-2;
		_yCoord = (random 4)-2;
		_bomb = _explosive createVehicle _iedPosition;
		_bomb setPos [(_iedPosition select 0)+_xCoord,(_iedPosition select 1)+_yCoord, 0];
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep .01;
	};

	eventHandlers set [_iedNumber, "true;"];
	publicVariable "eventHandlers";

	if(secondaryChance>random 100) then {
		_sleepTime = 15;
		if(EPD_IED_debug) then {
			hint format["Creating Secondary Explosive"];
		};
		sleep _sleepTime;
		[[_iedPosition, _iedNumber], "CREATE_SECONDARY", true, false] spawn BIS_fnc_MP;
	};
};*/




/*EXPLOSIVESEQUENCE_SMALL = {
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_explosiveSequence = ["M_PG_AT","M_Zephyr","M_Titan_AA_long","M_PG_AT"]; 

	[_iedPosition, _explosiveSequence, _ied, _iedNumber] spawn INITIAL_EXPLOSION;
};

EXPLOSIVESEQUENCE_MEDIUM = {
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_explosiveSequence = ["M_Titan_AA_long","HelicopterExploSmall","M_PG_AT","M_Titan_AT"];

	[_iedPosition, _explosiveSequence, _ied, _iedNumber] spawn INITIAL_EXPLOSION;
};

EXPLOSIVESEQUENCE_LARGE = {
	_iedPosition = _this select 0;
	_ied = _this select 1;
	_iedNumber = _this select 2;
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","M_Titan_AA_long","HelicopterExploSmall","M_Titan_AA_long", "M_PG_AT","M_Titan_AT"]; 

	[_iedPosition, _explosiveSequence, _ied, _iedNumber] spawn INITIAL_EXPLOSION;
};

EXPLOSIVESEQUENCE_SECONDARY = {
	[_this select 0] spawn SECONDARY_EXPLOSION;
	(_this select 1) removeAllEventHandlers "HitPart";
	eventHandlers set [_this select 2, "true;"];
	publicVariable "eventHandlers";
};

SECONDARY_EXPLOSION = {	

		_iedPosition = _this select 0;
		_explosiveSequence = ["R_80mm_HE","M_PG_AT","M_PG_AT","R_80mm_HE","M_PG_AT","R_80mm_HE","M_PG_AT","M_PG_AT","M_PG_AT","R_80mm_HE"];
		[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
		for "_i" from 0 to (count _explosiveSequence) -1 do{
			[[_iedPosition] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
			_explosive = (_explosiveSequence select _i);
			_xCoord = (random 4)-2;
			_yCoord = (random 4)-2;
			_bomb = _explosive createVehicle _iedPosition;
			_bomb setPos [(_iedPosition select 0)+_xCoord,(_iedPosition select 1)+_yCoord, 0];
			_i = _i + floor random 7;
			if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
				addCamShake[1+random 5, 1+random 3, 5+random 15];
			};
			sleep .01;
			
		};
	};


DISARM_EXPLOSIONS = {
	_iedPosition = _this select 0;
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10","M_PG_AT","R_80mm_HE"];
	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;
	[[_iedPosition] , "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
	for "_i" from 0 to (count _explosiveSequence) -1 do{
		[[_iedPosition] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
		_explosive = (_explosiveSequence select _i);
		_xCoord = (random 4)-2;
		_yCoord = (random 4)-2;
		_bomb = _explosive createVehicle _iedPosition;
		_bomb setPos [(_iedPosition select 0)+_xCoord,(_iedPosition select 1)+_yCoord, 0];
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep random .03;
	};
};
*/

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