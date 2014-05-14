private ["_origin","_centerPos","_size"];
_origin = _this;
_centerPos = [0,0,0];
_size = 0;
if(typename _origin == "ARRAY") then
{
	_centerPos = _origin select 0;
	_size = _origin select 1;
} else {
	//check if it is a location defined in cfgWorlds
	_dictLocation = [iedAllMapLocations,  toUpper(_origin)] call Dictionary_fnc_get;
	if(typename _dictLocation == "ARRAY") then {
		_centerPos = _dictLocation select 1;
		_size = _dictLocation select 2;
	} else {
		//check if it is a marker on the map
		if( getMarkerColor _origin != "") then {
			_centerPos = getMarkerPos _origin;
			_sizeArray = getMarkerSize _origin;
			_angle = -1*(markerDir _origin);
			_size = [_sizeArray select 0, _sizeArray select 1, _angle];
			if(_origin in iedSafeZones) then {
				if(hideSafeZoneMarkers) then {
					(_origin) setMarkerAlpha 0;
				};
			} else {				
				if(hideIedSectionMarkers) then {
					(_origin) setMarkerAlpha 0;
				};
			};
		} else {
			//check if it is in the predefined array
			_predefinedLocationIndex = -1;
			for "_i" from 0 to iedPredefinedLocationsSize -1 do{
				if(predefinedLocations select _i select 0 == _origin) then {
					_predefinedLocationIndex = _i;
					_i = (count predefinedLocations);
				};
			};
			if(_predefinedLocationIndex > -1) then {
				_centerPos = predefinedLocations select _predefinedLocationIndex select 1;
				_size = predefinedLocations select _predefinedLocationIndex select 2;
			};
		};
	};
};

[_centerPos, _size];