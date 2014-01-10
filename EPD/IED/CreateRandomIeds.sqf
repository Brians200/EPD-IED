_origin = (_this select 0);
_distance = (_this select 1);
_side = (_this select 2);
_iedAmountToPlace = (_this select 3);
_fakeAmountToPlace = (_this select 4);
_iedCounterOffset = (_this select 5);
_fakeCounterOffset = (_this select 6);

_counter = 0;

_roads = _origin nearRoads _distance;
_roadCount = count _roads;
if(_roadCount == 0) exitwith {}; //if there are no roads in this circle of life....
while{_counter < _iedAmountToPlace} do {
	
	_iedSize = [] call GET_SIZE_AND_TYPE;
	_iedType = _iedSize select 1;
	_iedSize = _iedSize select 0;
	_iedPos = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
	[_iedCounterOffset+_counter, _iedPos, _iedSize, _iedType, _side] call CREATE_IED;	
	_counter = _counter + 1;
};

_counter = 0;
while{_counter < _fakeAmountToPlace} do {

	_junkType = ([] call GET_SIZE_AND_TYPE) select 1;
	_junkPosition = [_roads, _roadCount] call FIND_LOCATION_BY_ROAD;
	[_fakeCounterOffset+_counter,_junkPosition, _junkType] call CREATE_FAKE;
	_counter = _counter + 1;
};