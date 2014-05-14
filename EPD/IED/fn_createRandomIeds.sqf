private["_dictionary","_sectionName","_origin","_distance","_sizeA","_sizeB","_angle","_parameters","_side","_iedsToPlace","_junkToPlace","_chances","_maxRadius","_roads","_roadCount"];

_dictionary = _this select 0;
_sectionName = _this select 1;
_origin = _this select 2;
_distance = _this select 3;
_sizeA = _distance select 0;
_sizeB = _distance select 1;
_angle = _distance select 2;
_parameters = _this select 4;
_side = [];
_iedsToPlace = 0;
_junkToPlace = 0;

_chances = "";

switch (count _parameters) do
{
	case 2: {
				_iedsToPlace = ceil ((_sizeA + _sizeB) / 200.0);
				_junkToPlace = _iedsToPlace;
				_side = _parameters select 1;
			};
	case 3: {
				_iedsToPlace = _parameters select 1;
				_junkToPlace = _iedsToPlace;
				_side = _parameters select 2;
			};
	case 4: {
	
				if(typename( _parameters select 2) == "ARRAY") then {
					_max = _parameters select 1;
					_fakeChance = _parameters select 2 select 0;
					for "_i" from 0 to _max -1 do{
						if(random 100 < _fakeChance) then {
							_junkToPlace = _junkToPlace + 1;
						} else {
							_iedsToPlace = _iedsToPlace + 1;
						};
					};
					_chances = [_parameters select 2 select 1, _parameters select 2 select 2, _parameters select 2 select 3];
				} else {
					_iedsToPlace = _parameters select 1;
					_junkToPlace = _parameters select 2;
				};
				
				_side = _parameters select 3;
			};
};

_maxRadius = _sizeA max _sizeB;
_roads = (_origin nearRoads _maxRadius) - iedSafeRoads;
_roadCount = count _roads;



for "_i" from 0 to (_roadCount) -1 do{
	_valid = [_angle, _sizeA, _sizeB, _origin, getpos (_roads select _i) ] call EpdIed_fnc_checkPointEllipse;
			
	if( !_valid) then {
		_roads set [_i, "nil"];
	} else {
		/*_markerName = format["f%1", _i];
		createmarker [_markerName, getpos (_roads select _i)];
		_markerName setMarkerTypeLocal "mil_dot";
		_markerName setMarkerColorLocal "ColorGreen";
		_markerName setMarkerTextLocal "";*/
	};
};



_roads = _roads - ["nil"];
_roadCount = count _roads;
if(_roadCount > 0) then {

	for "_i" from 0 to _iedsToPlace -1 do{
		_sizeAndType = _chances call EpdIed_fnc_getSizeAndType;
		_iedPos = [_roads, _roadCount] call EpdIed_fnc_findLocationByRoad;
		[_iedPos, _sizeAndType select 0, _sizeAndType select 1, _side, _dictionary, _sectionName] call EpdIed_fnc_createIed;
	};
	
	for "_i" from 0 to _junkToPlace -1 do{
		_sizeAndType = _chances call EpdIed_fnc_getSizeAndType;
		_junkPosition = [_roads, _roadCount] call EpdIed_fnc_findLocationByRoad;
		[_junkPosition, _sizeAndType select 1, _dictionary] call EpdIed_fnc_createFake;
	};
	
};