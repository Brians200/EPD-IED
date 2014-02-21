/* Written by Brian Sweeney - [EPD] Brian*/

if(isserver) then {
	iedsAdded = false;
	publicVariable "iedsAdded";
	
	iedDictionary = call Dictionary_fnc_new;
	publicVariable "iedDictionary";
	
	eventHandlers = [];
	//publicVariable "eventHandlers";
};

call compile preprocessFileLineNumbers "EPD\Ied_Settings.sqf";
call compile preprocessFileLineNumbers "EPD\IED\ExplosionFunctions.sqf";
call compile preprocessFileLineNumbers "EPD\IED\CreationFunctions.sqf";
call compile preprocessFileLineNumbers "EPD\IED\ExplosionEffects.sqf";
call compile preprocessFileLineNumbers "EPD\IED\CreationAuxiliaryFunctions.sqf";
call compile preprocessFileLineNumbers "EPD\IED\ExplosivesHandler.sqf";
call compile preprocessFileLineNumbers "EPD\IED\Disarm.sqf";
call compile preprocessFileLineNumbers "EPD\IED\DictionaryFunctions.sqf";
IED = compile preprocessFileLineNumbers "EPD\IED\Ied.sqf";
TRIGGER_CHECK = compile preprocessFileLineNumbers "EPD\IED\TriggerCheck.sqf";


iedSecondaryItemsCount = count iedSecondaryItems;
iedSmallItemsCount = count iedSmallItems;
iedMediumItemsCount = count iedMediumItems;
iedLargeItemsCount = count iedLargeItems;

if(isserver) then {
	
	call GET_PLACES_OF_INTEREST;
	
	iedSafeRoads = [];
	{
		_locationAndSize = (_x) call GET_CENTER_LOCATION_AND_SIZE;
		_roads = ((_locationAndSize select 0) nearRoads (_locationAndSize select 1));
		iedSafeRoads = (iedSafeRoads - _roads) + _roads; //removes duplicates first
	} foreach iedSafeZones;
	
	//iedAllMapLocations
	//iedCityMapLocations
	//iedVillageMapLocations
	//iedLocalMapLocations
	
	_handles = [];
	_nextHandleSpot = 0;
	
	{
		switch(toUpper(_x select 0)) do {
			case "ALL": {
					_keys = iedAllMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn CREATE_IED_SECTION];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLCITIES": {
					_keys = iedCityMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn CREATE_IED_SECTION];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLVILLAGES": {
					_keys = iedVillageMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn CREATE_IED_SECTION];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLLOCALS": {
					_keys = iedLocalMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn CREATE_IED_SECTION];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			default	{
				_handles set [_nextHandleSpot, [_x] spawn CREATE_IED_SECTION];
				_nextHandleSpot = _nextHandleSpot + 1;
			};
		};
		
	} foreach iedInitialArray;
	
	waituntil{sleep .5; [_handles] call CHECK_ARRAY;};
	
	//_script = iedArray call IED;
	
	iedsAdded = true;
	publicVariable "iedsAdded";
	
	publicVariable "iedDictionary";
};

waituntil{sleep .5; (!isnull player and iedsAdded)};
player sidechat "Synching IEDs... You may experience lag for a few seconds";
//hint format["%1 ieds to synch", count eventHandlers];

for "_i" from 0 to (count eventHandlers) -1 do{
	call compile (eventHandlers select _i);
	if(EPD_IED_debug) then {player sidechat (format["%1 synched", _i+1]);};
};
