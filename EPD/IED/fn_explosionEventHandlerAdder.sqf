private["_sectionName","_iedName","_arr","_ied","_iedSize"];
_sectionName = _this select 0;
_iedName = _this select 1;

_arr = [_sectionName, _iedName] call EpdIed_fnc_getIedArray;
_ied = _arr select 0;
_iedSize = _arr select 3;

_ied setVariable ["_sectionName", _sectionName];
_ied setVariable ["_iedName", _iedName];
_ied setVariable ["_iedSize", _iedSize];

_ied addEventHandler ["HitPart", {_this call EpdIed_fnc_explosionEventHandler;}];