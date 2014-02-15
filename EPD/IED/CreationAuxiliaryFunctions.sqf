GET_PLACES_OF_INTEREST = {
	_placesToKeep = ["NameCityCapital","NameCity","NameVillage", "NameLocal"];
	_cities = ["NameCityCapital","NameCity"];
	_villages = ["NameVillage"];
	_locals = ["NameLocal"];
	placesOfInterest = [];
	cities = [];
	villages = [];
	locals = [];
	_placesCfg = configFile >> "CfgWorlds" >> worldName >> "Names";
	_allCounter = 0;
	_cityCounter = 0;
	_villageCounter = 0;
	_localCounter = 0;
	for "_i" from 0 to (count _placesCfg)-1 do
	{
		_place = _placesCfg select _i;
		_name =	getText(_place >> "name");
		_sizeX = getNumber (_place >> "radiusA");
		_sizeY = getNumber (_place >> "radiusB");
		_avgSize = (_sizeX+_sizeY)/2;
		_position = getArray (_place >> "position");
		_type = getText(_place >> "type");
		if(_type in _placesToKeep) then
		{	
			placesOfInterest set [_allCounter, [_name, _position, _avgSize]];
			_allCounter = _allCounter + 1;
		};
		if(_type in _cities) then
		{	
			cities set [_cityCounter, [_name, _position, _avgSize]];
			_cityCounter = _cityCounter + 1;
		};
		if(_type in _villages) then
		{	
			villages set [_villageCounter, [_name, _position, _avgSize]];
			_villageCounter = _villageCounter + 1;
		};
		if(_type in _locals) then
		{	
			locals set [_localCounter, [_name, _position, _avgSize]];
			_localCounter = _localCounter + 1;
		};
	};
};

FIND_LOCATION_BY_ROAD = {
	_roads = _this select 0;
	_roadCount = _this select 1;
	_orthogonalDist = 5;
	_road = _roads select(floor random(_roadCount));
	_dir = 0;
	if(count (roadsConnectedTo _road) > 0) then {
		_dir  = [_road, (roadsConnectedTo _road) select 0] call BIS_fnc_DirTo;
	};
	_position = getpos _road;
	_opositionX = _position select 0;
	_opositionY = _position select 1;

	_offSetDirection = 1;
	if((random 100) > 50) then { _offSetDirection = -1;};

	_positionX = _opositionX + (random 5) * _offSetDirection * sin(_dir);
	_positionY = _opositionY + (random 5) * _offSetDirection * cos(_dir);

	if((random 100) > 50) then { _offSetDirection = -1 * _offSetDirection;};		

	_tx = _positionX;
	_ty = _positionY;

	while{isOnRoad [_tx,_ty,0]} do{
		_orthogonalDist = _orthogonalDist + _offSetDirection;
		_tx = (_positionX + (_orthogonalDist * cos(_dir)));
		_ty = (_positionY + (_orthogonalDist * sin(_dir)));
	};	

	_extraOffSet = 1 + random 5;
	//move it off the road a random amount
	_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
	_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));

	//ensure we didn't put it on another road, this happens a lot at Y type intersections
	while{isOnRoad [_tx,_ty,0]} do
	{
		_extraOffSet = _extraOffSet - 0.5;
		_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
		_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));
	};
			
	[_tx,_ty,0];
};

GET_SIZE_AND_TYPE = {
	_size = "SMALL";
	 r = floor random (smallChance+mediumChance+largeChance);
	 if(r>smallChance) then {
		_size = "MEDIUM";
	 };
	 
	 if(r>smallChance+mediumChance) then {
		_size = "LARGE";
	 };

	_type = "";
	if(_size == "SMALL") then
	{
		_type = iedSmallItems select(floor random(iedSmallItemsCount));
	} else {
		if(_size == "MEDIUM") then
		{
			_type = iedMediumItems select(floor random(iedMediumItemsCount));
		} else { //large
			_type = iedLargeItems select(floor random(iedLargeItemsCount));
		};
	};
	[_size,_type];
};

CHECK_ARRAY = {
	_arr = _this select 0;
	_good = true;
	for "_i" from 0 to (count _arr) -1 do{
		if(!ScriptDone (_arr select _i)) then {_good = false;};
	};

	_good;
};