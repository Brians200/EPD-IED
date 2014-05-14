private["_sectionName","_parameters","_locationAndSize","_sectionDictionary","_sizeA","_sizeB"];
_sectionName = "";
_parameters = [];
if(count _this == 1) then {
	_sectionName = call EpdIed_fnc_getRandomIedName;
	_parameters = _this select 0;
};
if(count _this == 2) then {
	_sectionName = _this select 0;
	_parameters = _this select 1;
};

_locationAndSize = (_parameters select 0) call EpdIed_fnc_getCenterLocationAndSize;
_sectionDictionary = _sectionName call EpdIed_fnc_createIedSectionDictionary;
_sizeA = _locationAndSize select 1 select 0;
_sizeB = _locationAndSize select 1 select 1;
if(_sizeA == 1 && _sizeB == 1) then {
	
	[_sectionDictionary, _sectionName, _locationAndSize select 0, _parameters ] call EpdIed_fnc_createSpecificIed;
} else {
	if(_sizeA > 1 || _sizeB > 1 ) then {
		[_sectionDictionary, _sectionName, _locationAndSize select 0, _locationAndSize select 1, _parameters ] call EpdIed_fnc_createRandomIeds;
	};
};

_sectionName;