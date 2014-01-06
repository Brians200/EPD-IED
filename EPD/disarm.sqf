/* original work from: Tankbuster */
/* adapted from:  Dynamic IED script by - Mantis -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

(_this select 0) removeAllEventHandlers "HitPart";

_arr = _this select 3;
if(!scriptDone (_arr select 1)) then {terminate (_arr select 1);};
_chance = baseDisarmChance;
_trigger = _arr select 0;

_bonusAdded = false;
{
	if((not _bonusAdded) and ((typeof player) isKindOf _x )) then {
		_chance = _chance + bonusDisarmChance;
		_bonusAdded = true;
	};
} foreach betterDisarmers;



if (((random 100) < _chance)) then {
	//player switchMove "AinvPknlMstpSlayWrflDnon_medic";
	[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, true] call BIS_fnc_MP;
	disableUserInput true;
	sleep 6;
	disableUserInput false;
	deletevehicle (_trigger);
	[[_this select 0],"removeAct", true, true] spawn BIS_fnc_MP;
	hint "Successfully Disarmed!";
}

 else {
	player switchMove "AinvPknlMstpSlayWrflDnon_medic";
	disableUserInput true;
	sleep 2;
	disableUserInput false;
	[getpos player] spawn {call DISARM_EXPLOSIONS;};
	deletevehicle (_trigger);
	[[_this select 0],"removeAct", true, true] spawn BIS_fnc_MP;
	deletevehicle (_this select 0);
	hint "Failed to Disarm!";
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
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep random .03;
	};
};