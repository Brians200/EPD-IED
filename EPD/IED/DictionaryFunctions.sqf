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
	
	terminate (_iedArray select 5);
	
	_position;
};

PREPARE_IED_FOR_CLEANUP = {
	_sectionName = _this select 0;
	_iedName = _this select 1;
	
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	_ieds = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	_iedArray = [_ieds, _iedName] call Dictionary_fnc_get;
	
	_position = getpos (_iedArray select 0);
	
	deleteVehicle (_iedArray select 1); //trigger
	[_ieds, _iedName] call Dictionary_fnc_remove;
	deleteMarker (_iedArray select 4);
	
	_arr = [_sectionDictionary, "cleanUp"] call Dictionary_fnc_get;
	_arr set[count _arr, _iedArray select 0];
	
	[_ieds, _iedName] call Dictionary_fnc_remove;
	
	_position;
};

INCREMENT_EXPLOSION_COUNTER = {
	_sectionName = _this;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	
	_arr = [_sectionDictionary, "infos"] call Dictionary_fnc_get;
	_arr set[0, 1 + (_arr select 0)];
};

INCREMENT_DISARM_COUNTER = {
	_sectionName = _this;
	_sectionDictionary = [iedDictionary, _sectionName] call Dictionary_fnc_get;
	
	_arr = [_sectionDictionary, "infos"] call Dictionary_fnc_get;
	_arr set[1, 1 + (_arr select 1)];
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

REMOVE_IED_SECTION = {
	_sectionDictionary = [iedDictionary, _this] call Dictionary_fnc_get;
	_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	_iedKeys = _iedsDictionary call Dictionary_fnc_keys;

	{
		[_this, _x] call REMOVE_IED_ARRAY;
	} foreach _iedKeys;	
	
	_fakesDictionary = [_sectionDictionary, "fake"] call Dictionary_fnc_get;
	_fakeKeys = _fakesDictionary call Dictionary_fnc_keys;
	{
		_fakeArr = [_fakesDictionary, _x] call Dictionary_fnc_get;
		deleteVehicle (_fakeArr select 0);
		deleteMarker (_fakeArr select 1);
		[_fakesDictionary, _x] call Dictionary_fnc_remove;
	} foreach _fakeKeys;	
	
	_cleanUp = [_sectionDictionary, "cleanUp"] call Dictionary_fnc_get;
	
	{
		deleteVehicle _x;
	} foreach _cleanUp;
	
	[iedDictionary, _this] call Dictionary_fnc_remove;

};

ADD_IED_TO_SECTION = {
	_sectionDictionary = _this select 0;
	_iedName = _this select 1;
	_iedArray = _this select 2;
	_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	[_iedsDictionary, _iedName, _iedArray] call Dictionary_fnc_set;
};

ADD_DISARM_AND_PROJECTILE_DETECTION = {

	if(count _this == 0) then {
		_sectionKeys = iedDictionary call Dictionary_fnc_keys;
		{
			_sectionName = _x;
			_sectionDictionary = [iedDictionary, _x] call Dictionary_fnc_get;
			_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
			_iedKeys = _iedsDictionary call Dictionary_fnc_keys;
			
			if(allowExplosiveToTriggerIEDs) then {
				{
					[[_sectionName, _x],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
					[[_sectionName, _x],"EXPLOSION_EVENT_HANDLER_ADDER", true, false] spawn BIS_fnc_MP;
				} foreach _iedKeys;	
			} else {
				{
					[[_sectionName, _x],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
				} foreach _iedKeys;	
			};
		} foreach _sectionKeys;
	} else {
		
		_sectionDictionary = [iedDictionary, _this] call Dictionary_fnc_get;
		_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
		_iedKeys = _iedsDictionary call Dictionary_fnc_keys;
		if(allowExplosiveToTriggerIEDs) then {
			{
				[[_this, _x],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
				[[_this, _x],"EXPLOSION_EVENT_HANDLER_ADDER", true, false] spawn BIS_fnc_MP;
			} foreach _iedKeys;	
		} else {
			{
				[[_this, _x],"DISARM_ADD_ACTION", true, false] spawn BIS_fnc_MP;
			} foreach _iedKeys;	

		};
	};
};