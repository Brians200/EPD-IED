private["_sectionName","_sectionDictionary","_ieds","_keys"];
_sectionName = _this;
_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
_keys = _ieds call Dictionary_fnc_keys;

count _keys;