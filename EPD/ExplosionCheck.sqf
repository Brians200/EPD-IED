if(_this select 0) then
{
	_triggerNum = _this select 3;
	_iedPos = _this select 2;
	_objects = _this select 1;
	_minDistance = 10000;
	_minHeight = 10000;
	_maxSpeed = 0;
	{
		_dist = (position _x distance _iedPos);
		if(_dist < _minDistance) then {
			_minDistance = _dist;
		};
	
		if(speed _x > _maxSpeed) then
		{
			_maxSpeed = speed _x;
		};
		if((position _x) select 2 < _minheight) then {
			_minHeight = (position _x) select 2;
		};
	} foreach _objects;
	
	if(debug) then {
		hintSilent format["Trigger %5\nPeople/Vehicles in trigger = %1\nMax Speed = %2\nMin Height = %3\nDistance = %4", count _objects,_maxSpeed, _minHeight,_minDistance, _triggerNum];
	};	
	
	if((_maxSpeed > 5.2) and (_minHeight < 3)) then { true; } else {false;}; 
} else {
	false;
};