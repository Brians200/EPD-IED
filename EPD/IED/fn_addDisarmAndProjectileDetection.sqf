if(count _this == 0) then {
	_sectionKeys = iedDictionary call Dictionary_fnc_keys;
	{
		_sectionName = _x;
		_sectionDictionary = [iedDictionary, _x] call Dictionary_fnc_get;
		_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
		_iedKeys = _iedsDictionary call Dictionary_fnc_keys;
		
		{
			//[_sectionName, _x] spawn DISARM_ADD_ACTION;
			if(allowExplosiveToTriggerIEDs) then {
				[_sectionName, _x] spawn EpdIed_fnc_explosionEventHandlerAdder;
			};
		} foreach _iedKeys;	

	} foreach _sectionKeys;
} else {
	
	_sectionDictionary = [iedDictionary, _this] call Dictionary_fnc_get;
	_iedsDictionary = [_sectionDictionary, "ieds"] call Dictionary_fnc_get;
	_iedKeys = _iedsDictionary call Dictionary_fnc_keys;
	
		{
			//[_this,_x] spawn DISARM_ADD_ACTION;
			if(allowExplosiveToTriggerIEDs) then {
				[_this,_x] spawn EpdIed_fnc_explosionEventHandlerAdder;
			};
		} foreach _iedKeys;	
	
};