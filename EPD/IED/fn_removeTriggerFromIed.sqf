private["_sectionDictionary","_iedName","_iedsDictionary","_iedArray","_trigger"];
try{
	_sectionDictionary = _this select 0;
	_iedName = _this select 1;
	_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	_iedArray = [_iedsDictionary, _iedName] call Dictionary_fnc_get;
	_trigger = _iedArray select 1;
	deleteVehicle _trigger;
	_iedArray set [1, objNull];
} catch {};