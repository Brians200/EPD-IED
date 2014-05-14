private["_iedPosition","_sectionDictionary","_sectionName","_iedName","_iedSize","_ied","_disarmAdded","_triggerActive"];

_iedPosition = _this select 0;
_sectionDictionary = _this select 1;
_sectionName = _this select 2;
_iedName = _this select 3;
_iedSize = _this select 4;
_ied = _this select 5;

disarmAdded = [];


_triggerActive = false;
while{true} do {
	_nearEntities = _iedPosition nearEntities [["CAManBase","LandVehicle"], 250];
	_nearEntitiesCount = count (_nearEntities);
			
	{
		if(isPlayer _x) then {
			if(!(_x in disarmAdded)) then {
				if(!isnull _x) then {
					disarmAdded set [count disarmAdded, _x];
					hint "Adding disarm...";
					0 = [_sectionName,_iedName,_x] spawn {
						sleep 1; //sleep is here to prevent edge case where a player joins the game within 250 meters of an ied. Need to give him/her time to compile the disarm function.
						[[_this select 0, _this select 1], "EpdIed_fnc_disarmAddAction", _this select 2, false] spawn BIS_fnc_MP;
					};
				};
			};
		};
	} foreach _nearEntities;
	publicVariable "disarmAdded";
	
	
	_disarmToRemove = disarmAdded - _nearEntities;
	{
		[_ied, "EpdIed_fnc_removeDisarmAction", true, false] spawn BIS_fnc_MP;
	} foreach _disarmToRemove;
	
	disarmAdded = disarmAdded - _disarmToRemove;
	
	if(! _triggerActive && {_nearEntitiesCount > 0}) then {
		_triggerActive = true;
		if(EPD_IED_debug) then { hintSilent "Trigger Created" };

		_trigger = createTrigger["EmptyDetector", _iedPosition];
		_trigger setTriggerArea[11,11,0,true];
		_trigger setTriggerActivation ["any", "PRESENT", false];
		_trigger setTriggerStatements [
					'this && { ["' + _sectionName + '","' + _iedName +'", thisList] call EpdIed_fnc_triggerCheck }',
					'["' + _sectionName + '","' + _iedName +'"] call EpdIed_fnc_explosiveSequence' + _iedSize + ';',
					""];
		
		[_sectionDictionary, _iedName, _trigger] call EpdIed_fnc_addTriggerToIed;
	}
	else {
		if(_triggerActive && {_nearEntitiesCount == 0}) then {
			_triggerActive = false;
			if(EPD_IED_debug) then { hintSilent "Trigger deleted"; };
			[_sectionDictionary, _iedName] call EpdIed_fnc_removeTriggerFromIed;
		};		
	};
	
	sleep 5;
};