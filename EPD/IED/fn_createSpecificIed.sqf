private["_dictionary","_sectionName","_origin","_parameters","_side","_sizeAndType","_chance"];
_dictionary = _this select 0;
_sectionName = _this select 1;
_origin = _this select 2;
_parameters = _this select 3;
_side = _parameters select ((count _parameters)-1);

_sizeAndType = "" call EpdIed_fnc_getSizeAndType;
_chance = 100;
if(count _parameters == 3) then { 
	if(typename( _parameters select 1) == "ARRAY") then {
		_chances =  _parameters select 1;
		_chance = 100-(_chances select 0);
		_sizeAndType = [_chances select 1, _chances select 2, _chances select 3] call EpdIed_fnc_getSizeAndType;
	} else {
		_chance = _parameters select 1; 
	};
};

if(random 100 < _chance) then {
	[_origin, _sizeAndType select 0, _sizeAndType select 1, _side, _dictionary, _sectionName] call EpdIed_fnc_createIed;
} else {
	[_origin, _sizeAndType select 1, _dictionary] call EpdIed_fnc_createFake;
};