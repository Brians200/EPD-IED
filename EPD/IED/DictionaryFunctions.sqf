GET_IED_ARRAY = {
	_sectionName = _this select 0;
	_iedName = _this select 1;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	[_sectionDictionary, _iedName] call Dictionary_fnc_get;
};

REMOVE_IED_ARRAY = {
	
	_sectionName = _this select 0;
	_iedName = _this select 1;
	//[ied, trigger, sides, size]
	
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	_iedArray = [_sectionDictionary, _iedName] call Dictionary_fnc_get;
	
	_position = getpos (_iedArray select 0);
	
	deleteVehicle (_iedArray select 0);
	deleteVehicle (_iedArray select 1);
	[_sectionDictionary, _iedName] call Dictionary_fnc_remove;
	
	_position;
};