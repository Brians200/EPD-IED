private["_sectionName","_iedName","_sectionDictionary","_ieds","_iedArray","_position"];
_sectionName = _this select 0;
_iedName = _this select 1;

_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
_iedArray = [_ieds, _iedName] call Dictionary_fnc_get;

_position = getpos (_iedArray select 0);

deleteVehicle (_iedArray select 0); //item
deleteVehicle (_iedArray select 1); //trigger
[_ieds, _iedName] call Dictionary_fnc_remove;

deleteMarker (_iedArray select 4);

terminate (_iedArray select 5);
terminate (_iedArray select 6);

_position;