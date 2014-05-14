/* Written by Brian Sweeney - [EPD] Brian*/

if(isserver) then {
	iedsAdded = false;
	publicVariable "iedsAdded";
	
	iedDictionary = call Dictionary_fnc_new;
	publicVariable "iedDictionary";
	
	lastIedExplosion = [0,0,0];
	publicVariable "lastIedExplosion";
};

ehExplosiveSuperClasses = ["RocketCore", "MissileCore", "SubmunitionCore", "GrenadeCore", "ShellCore"];
publicVariable "ehExplosiveSuperClasses";

explosiveSuperClasses = ["TimeBombCore","BombCore", "Grenade"];
publicVariable "explosiveSuperClasses";

projectilesToIgnore = ["SmokeShell", "FlareCore", "IRStrobeBase", "GrenadeHand_stone", "Smoke_120mm_AMOS_White", "TMR_R_DG32V_F"];
publicVariable "projectilesToIgnore";

call compile preprocessFileLineNumbers "EPD\Ied_Settings.sqf";

iedSecondaryItemsCount = count iedSecondaryItems;
iedSmallItemsCount = count iedSmallItems;
iedMediumItemsCount = count iedMediumItems;
iedLargeItemsCount = count iedLargeItems;

if(isserver) then {
	
	call EpdIed_fnc_getPlacesOfInterest;
	
	iedSafeRoads = [];
	{
		_locationAndSize = (_x) call EpdIed_fnc_getCenterLocationAndSize;
		_radiusA = _locationAndSize select 1 select 0;
		_radiusB = _locationAndSize select 1 select 1;
		_angle = _locationAndSize select 1 select 2;
		_center = _locationAndSize select 0;
		
		_maxRadius = _radiusA max _radiusB;
		_roads = _center nearRoads _maxRadius;
		_roadsCount = count _roads;
		
		for "_i" from 0 to (_roadsCount) -1 do{
			_valid = [_angle, _radiusA, _radiusB, _center, getpos (_roads select _i) ] call EpdIed_fnc_checkPointEllipse;
			if( !_valid) then {
				_roads set [_i, "nil"];
			};
		};
		
		_roads = _roads - ["nil"];
		
		iedSafeRoads = (iedSafeRoads - _roads) + _roads; //removes duplicates first
	} foreach iedSafeZones;
	
	_handles = [];
	_nextHandleSpot = 0;

	{
		switch(toUpper(_x select 0)) do {
			case "ALL": {
					_keys = iedAllMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn EpdIed_fnc_createIedSection];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLCITIES": {
					_keys = iedCityMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn EpdIed_fnc_createIedSection];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLVILLAGES": {
					_keys = iedVillageMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn EpdIed_fnc_createIedSection];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			case "ALLLOCALS": {
					_keys = iedLocalMapLocations call Dictionary_fnc_keys;
					_side = _x select 1;
					{
						_handles set [_nextHandleSpot, [[_x,_side]] spawn EpdIed_fnc_createIedSection];
						_nextHandleSpot = _nextHandleSpot + 1;
					} foreach _keys;
				};
			default	{
				_handles set [_nextHandleSpot, [_x] spawn EpdIed_fnc_createIedSection];
				_nextHandleSpot = _nextHandleSpot + 1;
			};
		};
		
	} foreach iedInitialArray;
	
	waituntil{sleep .5; [_handles] call EpdIed_fnc_checkArray;};
	
	//_script = iedArray call IED;
	publicVariable "iedDictionary";
	
	iedsAdded = true;
	publicVariable "iedsAdded";
	
	
};

waituntil{sleep .5; (!isnull player and iedsAdded)};
player sidechat "Synching IEDs... You may experience lag for a few seconds";
[] call EpdIed_fnc_addDisarmAndProjectileDetection;

