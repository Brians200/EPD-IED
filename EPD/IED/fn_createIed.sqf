private["_iedPos","_iedSize","_iedObject","_side","_sectionDictionary","_sectionName","_iedName","_markerName","_ied","_scriptHandle","_triggerStatusHandle"];
_iedPos = _this select 0;
_iedSize = _this select 1;
_iedObject = _this select 2;
_side = _this select 3;
_sectionDictionary = _this select 4;
_sectionName = _this select 5;

_iedName = call EpdIed_fnc_getRandomIedName;
_markerName = "ied"+_iedName+_iedSize;

if(typename _side != "ARRAY") then { _side = [_side]; };
for "_i" from 0 to (count _side) -1 do {
	_side set [_i, toUpper (_side select _i)];
};

_ied = _iedObject createVehicle _iedPos;
_ied setDir random 360;
_ied enableSimulation false;
_ied allowDamage false;
_ied setVariable ["_isIED", "brians200", true];

_scriptHandle = "";
if(allowExplosiveToTriggerIEDs) then {
	_scriptHandle = [_ied, _sectionName, _iedName, _iedSize] spawn EpdIed_fnc_projectileDetection;
} else {
	_scriptHandle = 0 spawn {};
};

_triggerStatusHandle = [_iedPos, _sectionDictionary, _sectionName, _iedName, _iedSize, _ied] spawn EpdIed_fnc_triggerStatusLoop;

[_sectionDictionary, _iedName, [_ied, objNull, _side, _iedSize,_markerName, _scriptHandle, _triggerStatusHandle]] call EpdIed_fnc_addIedToSection;



if(EPD_IED_debug) then {			
	createmarker [_markerName, _iedPos];
	_markerName setMarkerTypeLocal "hd_warning";
	_markerName setMarkerColorLocal "ColorRed";
	_markerName setMarkerTextLocal _iedSize;
};

if(iedsAdded) then { //initial ieds were added already and the game is in progress
	publicVariable "iedDictionary";
	//[[_sectionName, _iedName],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
	if(allowExplosiveToTriggerIEDs) then {
		[[_sectionName, _iedName],"EpdIed_fnc_explosionEventHandlerAdder", true, false] spawn BIS_fnc_MP;
	};
};