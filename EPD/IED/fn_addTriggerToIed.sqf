private["_sectionDictionary","_iedName","_trigger","_iedsDictionary","_iedArray"];
_sectionDictionary = _this select 0;
_iedName = _this select 1;
_trigger = _this select 2;
_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
_iedArray = [_iedsDictionary, _iedName] call Dictionary_fnc_get;
_iedArray set [1, _trigger];