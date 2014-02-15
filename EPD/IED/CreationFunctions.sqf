CREATE_IED = {
	_iedNumber = _this select 0;
	_iedPos = _this select 1;
	_iedSize = _this select 2;
	_iedType = _this select 3;
	_side = _this select 4;

	if(typename _side != "array") then { _side = [_side];};
	for "_i" from 0 to (count _side) -1 do{
		_side set [_i, toUpper (_side select _i)];
	};

	call compile format ['ied_%1 = _iedType createVehicle _iedPos;
							ied_%1 setDir (random 360);
							ied_%1 enableSimulation false;
							ied_%1 setPos _iedPos;
							ied_%1 allowDamage false;
							publicVariable "ied_%1";
						', _iedNumber];
													
	call compile format [' t_%1 = createTrigger["EmptyDetector", _iedPos];
	t_%1 setTriggerArea[11,11,0,true];
	t_%1 setTriggerActivation ["any","PRESENT",false];
	tSides_%1 = _side;
	t_%1 setTriggerStatements ["[this, thislist, %2, %1] call TRIGGER_CHECK && (alive ied_%1)","terminate pd_%1; [%2, ied_%1, %1] spawn EXPLOSIVESEQUENCE_%3; deleteVehicle thisTrigger;",""];
	publicVariable "t_%1";
	',_iedNumber, _iedPos,_iedSize];

	_eventhandler = "";
	_disarm = "";
	if(allowExplosiveToTriggerIEDs) then {
		call compile format['pd_%1 = [ied_%1, %1, _iedSize, t_%1] spawn PROJECTILE_DETECTION; publicVariable "pd_%1";', _iedNumber];

		_eventhandler = format ['["ied_%1","%2",%3,"t_%1",%1] spawn EXPLOSION_EVENT_HANDLER_ADDER;', _iedNumber,_iedSize, _iedPos];
			
		_disarm = format ['[ied_%1, t_%1, pd_%1, %1] spawn DISARM;', _iedNumber];
	} else {
		_disarm = format ['[ied_%1, t_%1, "", %1] spawn DISARM;', _iedNumber];
	};

	eventHandlers set[_iedNumber, format["%1 %2",_eventhandler, _disarm ]];
	//publicVariable "eventHandlers";

	if(EPD_IED_debug) then {		
			
		call compile format ['
		bombmarker_%1 = createmarker ["bombmarker_%1", _iedPos];
		"bombmarker_%1" setMarkerTypeLocal "hd_warning";
		"bombmarker_%1" setMarkerColorLocal "ColorRed";
		"bombmarker_%1" setMarkerTextLocal "%2";', _iedNumber, _iedSize];
	};
};

CREATE_SECONDARY = {
	if(!isserver) exitwith{};

	_location = _this select 0;
	_iedNumber = _this select 1;
	_theta = random 360;
	_offset = 4 + random 12;
	_iedPos = [(_location select 0) + _offset*cos(_theta), (_location select 1) + _offset*sin(_theta),0];
	_iedType = iedSecondaryItems select(floor random(iedSecondaryItemsCount));
	call compile format ['secied_%1 = _iedType createVehicle _iedPos;
							secied_%1 setDir (random 360);
							secied_%1 enableSimulation false;
							secied_%1 setPos _iedPos;
							secied_%1 allowDamage false;
							publicVariable "secied_%1";
							', _iedNumber, _iedPos];
						
	call compile format [' st_%1 = createTrigger["EmptyDetector", _iedPos];
	st_%1 setTriggerArea[11,11,0,true];
	st_%1 setTriggerActivation ["any","PRESENT",false];
	st_%1 setTriggerStatements ["[this, thislist, %2, %1] call TRIGGER_CHECK && (alive secied_%1)","terminate pd_%1; [%2,sec_%1, %1] spawn EXPLOSIVESEQUENCE_SECONDARY; deleteVehicle thisTrigger;  deleteVehicle secied_%1",""];
	publicVariable "st_%1";
	',_iedNumber, _iedPos];

	_eventhandler = "";
	_disarm = "";
	if(allowExplosiveToTriggerIEDs) then {
		call compile format['pd_%1 = [secied_%1, %1, "SECONDARY", st_%1] spawn PROJECTILE_DETECTION; publicVariable "pd_%1";', _iedNumber];

		_eventhandler = format['["secied_%1","SECONDARY",%2,"st_%1",%1] spawn EXPLOSION_EVENT_HANDLER_ADDER;', _iedNumber, _iedPos];
			
		_disarm = format ['[secied_%1, st_%1, pd_%1, %1] spawn DISARM;', _iedNumber];
	} else {
		_disarm = format ['[secied_%1, st_%1, "", %1] spawn DISARM;', _iedNumber];
	};

	_code = format["%1 %2",_eventhandler, _disarm ];

	eventHandlers set[_iedNumber, _code];
	publicVariable "eventHandlers";

	[[_code],"SECONDARY_EVENT_ADDER",true,false] spawn BIS_fnc_MP;

	if(EPD_IED_debug) then {		
		hint format["Secondary Explosive Created"];
		call compile format ['
		secbombmarker_%1 = createmarker ["secbombmarker_%1", _iedPos];
		"secbombmarker_%1" setMarkerTypeLocal "hd_warning";
		"secbombmarker_%1" setMarkerColorLocal "ColorGreen";
		"secbombmarker_%1" setMarkerTextLocal "Secondary";', _iedNumber];
	};
};

CREATE_FAKE = {
	_fakeNumber = _this select 0;
	_junkPosition = _this select 1;
	_junkType = _this select 2;

	_junk = _junkType createVehicle _junkPosition;
	_junk setdir(random 360);
	_junk setPos _junkPosition;
	_junk enableSimulation false;
	_junk allowDamage false;

	if(EPD_IED_debug) then {		
		call compile format ['
		fakebombmarker_%1 = createmarker ["fakebombmarker_%1", _junkPosition];
		"fakebombmarker_%1" setMarkerTypeLocal "hd_warning";
		"fakebombmarker_%1" setMarkerColorLocal "ColorBlue";
		"fakebombmarker_%1" setMarkerTextLocal "fake";
		', _fakeNumber];
	};
};

CREATE_RANDOM_IEDS = {
	_origin = (_this select 0);
	_distance = (_this select 1);
	_side = (_this select 2);
	_iedAmountToPlace = (_this select 3);
	_fakeAmountToPlace = (_this select 4);
	_iedCounterOffset = (_this select 5);
	_fakeCounterOffset = (_this select 6);
	_sectionNumber = (_this select 7);
	_counter = 0;

	_roads = (_origin nearRoads _distance) - safeRoads;
	_roadCount = count _roads;
	if(_roadCount > 0) then { 
		while{_counter < _iedAmountToPlace} do {
			
			_iedSize = [] call GET_SIZE_AND_TYPE;
			_iedType = _iedSize select 1;
			_iedSize = _iedSize select 0;
			_iedPos = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
			[_iedCounterOffset+_counter, _iedPos, _iedSize, _iedType, _side] call CREATE_IED;	
			if((disarmedSections select _sectionNumber) == "") then {
				disarmedSections set [_sectionNumber, format["isNull t_%1 && ! isNull ied_%1", _iedCounterOffset+_counter]];
				explodedSections set [_sectionNumber, format["isNull ied_%1", _iedCounterOffset+_counter]];
			} else {
				disarmedSections set [_sectionNumber, format["%2 && isNull t_%1 && ! isNull ied_%1", _iedCounterOffset+_counter, disarmedSections select _sectionNumber]];
				explodedSections set [_sectionNumber, format["%2 || isNull ied_%1", _iedCounterOffset+_counter, explodedSections select _sectionNumber]];
			};
			_counter = _counter + 1;
		};

		_counter = 0;
		while{_counter < _fakeAmountToPlace} do {

			_junkType = ([] call GET_SIZE_AND_TYPE) select 1;
			_junkPosition = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
			[_fakeCounterOffset+_counter,_junkPosition, _junkType] call CREATE_FAKE;
			_counter = _counter + 1;
		};
	} else {
		while{_counter < _iedAmountToPlace} do {
			eventHandlers set[_iedCounterOffset+_counter, "true;"];
			_counter = _counter + 1;
		};
		if((disarmedSections select _sectionNumber) == "") then {
			disarmedSections set [_sectionNumber, "true"];
			explodedSections set [_sectionNumber, "false"];
		} else {
			disarmedSections set [_sectionNumber, format["%1 && true", disarmedSections select _sectionNumber]];
			explodedSections set [_sectionNumber, format["%2 || false", explodedSections select _sectionNumber]];
		};
	};
};

CREATE_SPECIFIC_IED = {
	_iedNumber = _this select 0;
	_origin = _this select 1;
	_side = _this select 2;
	_sectionNumber = _this select 3;

	_st = [] call GET_SIZE_AND_TYPE;
	[_iedNumber, _origin, _st select 0, _st select 1, _side] call CREATE_IED;

	if((disarmedSections select _sectionNumber) == "") then {
		disarmedSections set [_sectionNumber, format["isNull t_%1 && ! isNull ied_%1", _iedNumber]];
		explodedSections set [_sectionNumber, format["isNull ied_%1", _iedNumber]];
	} else {
		disarmedSections set [_sectionNumber, format["%2 && isNull t_%1 && ! isNull ied_%1", _iedNumber, disarmedSection select _sectionNumber]];
		explodedSections set [_sectionNumber, format["%2 || isNull ied_%1", _iedNumber, disarmedSection select _sectionNumber]];
	};
};