/* adapted from:  Dynamic IED script by - Mantis and MAD_T -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

t = (_this select 0);

_array_item = items player;


//25% chance of it exploding if you don't have a toolkit
if ((_array_item find "ToolKit" > -1) or ((random 100) > 25)) then {
	//player switchMove "AinvPknlMstpSlayWrflDnon_medic";
	[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, true] call BIS_fnc_MP;
	disableUserInput true;
	sleep 6;
	disableUserInput false;
	deletevehicle (_this select 3);
	[[t],"removeAct", true, true] spawn BIS_fnc_MP;
	hint "Disarmed!";
}

 else {
	player switchMove "AinvPknlMstpSlayWrflDnon_medic";
	disableUserInput true;
	sleep 2;
	disableUserInput false;
	[getpos player] spawn {call DISARM_EXPLOSIONS;};
	deletevehicle (_this select 3);
	[[t],"removeAct", true, true] spawn BIS_fnc_MP;
	deletevehicle t;
};
 
  
removeAct = {
 _unit = _this select 0;
 _unit removeaction 0;
};

DISARM_EXPLOSIONS = {
	_iedPosition = _this select 0;
	_explosiveSequence = ["Bo_GBU12_LGB_MI10","Bo_GBU12_LGB_MI10","M_PG_AT","R_80mm_HE"];
	[[_iedPosition] , "IED_SMOKE", true, false] spawn BIS_fnc_MP;
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
		addCamShake[1+random 5, 1+random 3, 5+random 15];
		sleep random .01;
	};
};