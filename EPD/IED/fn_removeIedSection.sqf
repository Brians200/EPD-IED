private["_sectionDictionary","_iedsDictionary","_iedKeys","_fakesDictionary","_fakeKeys","_cleanUp"];
_sectionDictionary = [iedDictionary, _this] call Dictionary_fnc_get;
_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
_iedKeys = _iedsDictionary call Dictionary_fnc_keys;

{
	[_this, _x] call EpdIed_fnc_removeIedArray;
} foreach _iedKeys;	

_fakesDictionary = [_sectionDictionary, "fake"] call Dictionary_fnc_get;
_fakeKeys = _fakesDictionary call Dictionary_fnc_keys;
{
	_fakeArr = [_fakesDictionary, _x] call Dictionary_fnc_get;
	deleteVehicle (_fakeArr select 0);
	deleteMarker (_fakeArr select 1);
	[_fakesDictionary, _x] call Dictionary_fnc_remove;
} foreach _fakeKeys;	

_cleanUp = [_sectionDictionary, "cleanUp"] call Dictionary_fnc_get;

{
	deleteVehicle _x;
} foreach _cleanUp;

[iedDictionary, _this] call Dictionary_fnc_remove;