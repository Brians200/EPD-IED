GET_IED_ARRAY = {
	_sectionName = _this select 0;
	_iedName = _this select 1;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	[_ieds, _iedName] call Dictionary_fnc_get;
};



REMOVE_IED_ARRAY = {
	_sectionName = _this select 0;
	_iedName = _this select 1;
	
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	_iedArray = [_ieds, _iedName] call Dictionary_fnc_get;
	
	_position = getpos (_iedArray select 0);
	
	deleteVehicle (_iedArray select 0); //item
	deleteVehicle (_iedArray select 1); //trigger
	[_ieds, _iedName] call Dictionary_fnc_remove;
	
	deleteMarker (_iedArray select 4);
	
	_position;
};

INCREMENT_EXPLOSION_COUNTER = {
	_sectionName = _this;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	
	_arr = [_sectionDictionary, "infos"] call Dictionary_fnc_get;
	_arr set[0, 1 + (_arr select 0)];
};

CREATE_IED_SECTION_DICTIONARY = {
	_sectionName = _this;
	_sectionDictionary = call Dictionary_fnc_new;
	[iedDictionary, _sectionName, _sectionDictionary] call Dictionary_fnc_set;
	
	[_sectionDictionary, "infos", [0, 0]] call Dictionary_fnc_set;
	[_sectionDictionary, "ieds", call Dictionary_fnc_new] call Dictionary_fnc_set;
	[_sectionDictionary, "fake", call Dictionary_fnc_new] call Dictionary_fnc_set;
	[_sectionDictionary, "cleanUp", []] call Dictionary_fnc_set;
	
	_sectionDictionary;
	
};

ADD_IED_TO_SECTION = {
	_sectionDictionary = _this select 0;
	_iedName = _this select 1;
	_iedArray = _this select 2;
	_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	[_iedsDictionary, _iedName, _iedArray] call Dictionary_fnc_set;
};