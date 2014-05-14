private["_iedArray","_iedPosition","_explosiveSequence","_createSecondary","_createSmoke","_size","_numberOfFragments"];

_iedArray = [];
try{
	_iedArray = (_this select 0) call EpdIed_fnc_getIedArray;
	if(typeName _iedArray != "ARRAY") exitWith {if(EPD_IED_debug) then { hint "attempt to blow up already disarmed ied caught";};}; 
	
	_iedPosition = getpos (_iedArray select 0);
	terminate (_iedArray select 5);	//need to stop these so we don't get double explosions
	deleteVehicle (_iedArray select 1);  //need to stop these so we don't get double explosions
	(_iedArray select 0) removeAllEventHandlers "HitPart";
	(_this select 0 select 0) call EpdIed_fnc_incrementExplosionCounter;
	_explosiveSequence = (_this select 1);
	_createSecondary = (_this select 2);
	_createSmoke = [_this, 3, true] call BIS_fnc_param;
	_size = [_this, 4, "large"] call BIS_fnc_param;
	_numberOfFragments = 150;
	
	[[_iedPosition] , "EpdIed_fnc_iedScreenEffects", true, false] spawn BIS_fnc_MP;
	
	lastIedExplosion = _iedPosition;
	publicVariable "lastIedExplosion";
	
	0 = [_iedPosition, _explosiveSequence] spawn {
		_iedPosition = _this select 0;
		_explosiveSequence = _this select 1;
		
		for "_i" from 0 to (count _explosiveSequence) -1 do{
			[[_iedPosition] , "EpdIed_fnc_iedRocks", true, false] spawn BIS_fnc_MP;
			_explosive = (_explosiveSequence select _i);
			_xCoord = (random 4)-2;
			_yCoord = (random 4)-2;
			_ied = _explosive createVehicle _iedPosition;
			hideObjectGlobal _ied;
			_ied setPos [(_iedPosition select 0)+_xCoord,(_iedPosition select 1)+_yCoord, 0];
			if(((position player) distanceSqr getPos _ied) < 40000) then {  //less than 200 meters away
				addCamShake[1+random 5, 1+random 3, 5+random 15];
			};
			sleep .01;
		};
	};
	
	if(_createSmoke) then {
		if(_size == "large") then {
			[[_iedPosition] , "EpdIed_fnc_iedSmokeLarge", true, false] spawn BIS_fnc_MP;
			_numberOfFragments = 300;
		} else {
			if(_size == "small") then {
				[[_iedPosition] , "EpdIed_fnc_iedSmokeSmall", true, false] spawn BIS_fnc_MP;
				_numberOfFragments = 100;
			} else {
				if(_size == "medium") then {
					[[_iedPosition] , "EpdIed_fnc_iedSmokeMedium", true, false] spawn BIS_fnc_MP;
					_numberOfFragments = 200;
				};
			};
		};
	};
	
	//fragmentation
	[_iedPosition, _numberOfFragments] spawn EpdIed_fnc_createFragments;
	
	sleep .5;
	(_this select 0) call EpdIed_fnc_removeIedArray;
	
	if(_createSecondary) then {
		if(random 100 < secondaryChance) then {
			_sleepTime = 10;
			if(EPD_IED_debug) then {
				hint format["Creating Secondary Explosive"];
			};
			sleep _sleepTime;
			[[_iedPosition, _iedArray select 2, _this select 0 select 0], "EpdIed_fnc_createSecondaryIed", false, false] call BIS_fnc_MP;
		};
	};
	
	sleep 5;
	publicVariable "iedDictionary";
} catch {
	if (true) exitWith {hint "not allowed to blow this ied up";}; 
};