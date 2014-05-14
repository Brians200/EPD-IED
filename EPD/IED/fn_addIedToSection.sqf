private["_sectionDictionary","_iedName","_iedArray","_iedsDictionary"];
_sectionDictionary = _this select 0;
_iedName = _this select 1;
_iedArray = _this select 2;
_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
[_iedsDictionary, _iedName, _iedArray] call Dictionary_fnc_set;