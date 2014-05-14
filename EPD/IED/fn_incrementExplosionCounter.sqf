private["_sectionName","_sectionDictionary","_arr"];
_sectionName = _this;
_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;

_arr = [_sectionDictionary, "infos"] call Dictionary_fnc_get;
_arr set[0, 1 + (_arr select 0)];