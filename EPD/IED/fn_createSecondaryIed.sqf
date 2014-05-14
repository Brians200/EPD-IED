private["_location","_side","_sectionName","_sectionDictionary","_theta","_offset","_iedPos","_iedObject","_iedName","_markerName","_ied","_scriptHandle","_triggerStatusHandle"];

_location = _this select 0;
_side = _this select 1;
_sectionName = _this select 2;
_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;


_theta = random 360;
_offset = 4 + random 12;
_iedPos = [(_location select 0) + _offset*cos(_theta), (_location select 1) + _offset*sin(_theta),0];
_iedObject = iedSecondaryItems select(floor random(iedSecondaryItemsCount));

_iedName = call EpdIed_fnc_getRandomIedName;
_markerName = "secondary"+_iedName;

if(typename _side != "ARRAY") then { _side = [_side]; };
for "_i" from 0 to (count _side) -1 do {
	_side set [_i, toUpper (_side select _i)];
};

_ied = _iedObject createVehicle _iedPos;
_ied setDir random 360;
_ied enableSimulation false;
_ied allowDamage false;
_ied setVariable ["_isFake", "brians200", true];

_scriptHandle = "";
if(allowExplosiveToTriggerIEDs) then {
	_scriptHandle = [_ied, _sectionName, _iedName, "SECONDARY"] spawn EpdIed_fnc_projectileDetection;
} else {
	_scriptHandle = 0 spawn {};
};

_triggerStatusHandle = [_iedPos, _sectionDictionary, _sectionName, _iedName, "SECONDARY", _ied] spawn EpdIed_fnc_triggerStatusLoop;
[_sectionDictionary, _iedName, [_ied, objNull, _side, "SECONDARY",_markerName, _scriptHandle, _triggerStatusHandle]] call EpdIed_fnc_addIedToSection;


if(EPD_IED_debug) then {			
	createmarker [_markerName, _iedPos];
	_markerName setMarkerTypeLocal "hd_warning";
	_markerName setMarkerColorLocal "ColorGreen";
	_markerName setMarkerTextLocal "SECONDARY";
};

publicVariable "iedDictionary";
//[[_sectionName, _iedName],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
[[_sectionName, _iedName],"EpdIed_fnc_explosionEventHandlerAdder", true, false] spawn BIS_fnc_MP;