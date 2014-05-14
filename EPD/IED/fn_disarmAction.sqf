private["_iedArray","_chance","_bonusAdded"];
_iedArray = _this select 3 select 0;
	
//deleteVehicle (_iedArray select 1); //deleting the trigger
//(_iedArray select 0) removeaction 0; //remove the disarm addaction
deleteMarker (_iedArray select 4); //remove the map marker
//hint "disarmed!";


_chance = baseDisarmChance;

_bonusAdded = false;
{
	if((not _bonusAdded) and ((typeof player) isKindOf _x )) then {
		_chance = _chance + bonusDisarmChance;
		_bonusAdded = true;
	};
} foreach betterDisarmers;

if (((random 100) < _chance)) then {
	//Acts_carFixingWheel --- would like to use this, but it doesn't seem to work...
	[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	disableUserInput true;
	sleep 4.545;
	[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	sleep 6.545;
	disableUserInput false;
	[_iedArray select 0,"EpdIed_fnc_removeDisarmAction", true, false] spawn BIS_fnc_MP;
	(_iedArray select 0) setVariable ["_isIED", nil, true];
	_this select 3 select 1 select 0 call EpdIed_fnc_incrementDisarmCounter;
	_this select 3 select 1 call EpdIed_fnc_prepareIedForCleanup;
	hint "Successfully Disarmed!";
	publicVariable "iedDictionary";
} else {
	//Acts_carFixingWheel --- would like to use this, but it doesn't seem to work...
	[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	disableUserInput true;
	sleep 4.545;
	disableUserInput false;
	_this select 3 select 1 select 0 call EpdIed_fnc_incrementExplosionCounter;
	_this select 3 select 1 call EpdIed_fnc_explosiveSequenceDisarm;
	hint "Failed to Disarm!";
	//publicVariable "iedDictionary";          //not needed as the explosion will update
};
(_iedArray select 0) removeAllEventHandlers "HitPart";
terminate (_iedArray select 5);