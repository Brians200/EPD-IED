/* original work from: Tankbuster */
/* adapted from:  Dynamic IED script by - Mantis -*/
/* Rewritten by Brian Sweeney - [EPD] Brian*/

(_this select 0) removeAllEventHandlers "HitPart";

_arr = _this select 3;

if(format["%1",_arr select 1] != "") then {terminate (_arr select 1);};
_chance = baseDisarmChance;
_trigger = _arr select 0;
_iedNumber = _arr select 2;


_bonusAdded = false;
{
	if((not _bonusAdded) and ((typeof player) isKindOf _x )) then {
		_chance = _chance + bonusDisarmChance;
		_bonusAdded = true;
	};
} foreach betterDisarmers;



if (((random 100) < _chance)) then {
	//player switchMove "AinvPknlMstpSlayWrflDnon_medic";
	[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	disableUserInput true;
	sleep 6;
	disableUserInput false;
	deletevehicle (_trigger);
	[[_this select 0],"removeAct", true, true] spawn BIS_fnc_MP;
	hint "Successfully Disarmed!";
}

 else {
	[[[player], {(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	disableUserInput true;
	sleep 2;
	disableUserInput false;
	[getpos player] spawn {call DISARM_EXPLOSIONS;};
	deletevehicle (_trigger);
	[[_this select 0],"removeAct", true, true] spawn BIS_fnc_MP;
	deletevehicle (_this select 0);
	hint "Failed to Disarm!";
};
  
eventHandlers set [_iedNumber, "true;"];
publicVariable "eventHandlers";  
  
removeAct = {
 _unit = _this select 0;
 _unit removeaction 0;
};
