private["_sectionName","_sectionDictionary"];
_sectionName = _this;
_sectionDictionary = call Dictionary_fnc_new;
[iedDictionary, _sectionName, _sectionDictionary] call Dictionary_fnc_set;

[_sectionDictionary, "infos", [0, 0]] call Dictionary_fnc_set;
[_sectionDictionary, "ieds", call Dictionary_fnc_new] call Dictionary_fnc_set;
[_sectionDictionary, "fake", call Dictionary_fnc_new] call Dictionary_fnc_set;
[_sectionDictionary, "cleanUp", []] call Dictionary_fnc_set;

_sectionDictionary;