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
	[[_iedPosition, _iedNumber, _side], "SPAWN_SECONDARY", true, false] spawn BIS_fnc_MP;
};