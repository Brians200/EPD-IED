private["_sectionName","_iedName","_sectionDictionary","_ieds"];
_sectionName = _this select 0;
_iedName = _this select 1;
_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
[_ieds, _iedName] call Dictionary_fnc_get;