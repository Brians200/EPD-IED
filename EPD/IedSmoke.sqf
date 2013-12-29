/* Written by Brian Sweeney - [EPD] Brian*/
_loc = _this select 0;
_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];


_numPlumes = 20 + floor random 10;
for "_i" from 0 to _numPlumes -1 do{
	_r = floor random 3;
	switch(_r) do
	{
		case 0:
		{
			[_loc, _aslLoc] spawn {call BLACK_TRAIL_SMOKE;};
		};
		case 1: 
		{
			[_loc, _aslLoc] spawn {call GRAY_TRAIL_SMOKE;};
		};
		case 2:
		{
			[_loc, _aslLoc] spawn {call BROWN_TRAIL_SMOKE;};
		};
	};		

};
[_aslLoc] spawn { call CREATE_RING};

/*
_smoke = "#particlesource" createVehicle _aslLoc;
_smoke setposasl _aslLoc;
_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0.075, [1.2, 8], [[0, 0, 0, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke setParticleRandom [0, [0.25, 0.25, 0], [4, 4, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke setDropInterval 0.001;
_smoke setParticleCircle [0, [0, 0, 0]];

_smoke2 = "#particlesource" createVehicle _aslLoc;
_smoke2 setposasl _aslLoc;
_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0.075, [1.2, 8], [[0.926, 0.788, 0.686, 1], [0.25, 0.2, 0.12, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke2 setParticleRandom [0, [0.25, 0.25, 0], [4, 4, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke2 setDropInterval 0.001;
_smoke2 setParticleCircle [0, [0, 0, 0]];

_smoke3 = "#particlesource" createVehicle _aslLoc;
_smoke3 setposasl _aslLoc;
_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 1], 0, 10, 7.9, 0.075, [2, 4, 8], [[0.05, 0.05, 0.05, 1], [0.05, 0.05, 0.05, 0.1]], [0.08], 1, 0, "", "", _aslLoc];
_smoke3 setParticleRandom [0, [0.25, 0.25, 0], [3, 3, 4], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke3 setDropInterval 0.001;
_smoke3 setParticleCircle [0, [0, 0, 0]];

_smoke4 = "#particlesource" createVehicle _aslLoc;
_smoke4 setposasl _aslLoc;
_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 1.75], 0, 10, 7.9, 0.075, [2, 4, 8], [[0.0, 0.0, 0.0, 1], [0.05, 0.05, 0.05, 0.5], [0.15, 0.15, 0.15, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke4 setParticleRandom [0, [2, 2, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke4 setDropInterval 0.01;
_smoke4 setParticleCircle [0, [0, 0, 0]];

_quickSmokes = [_smoke,_smoke2, _smoke3];
_remnantSmokes = [_smoke4];
sleep 5;
{
	deletevehicle _x;
} foreach _quickSmokes;

sleep 40;
{
	deletevehicle _x;
} foreach _remnantSmokes;*/

BLACK_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "I_Mortar_01_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0, 0, 0, 1], [0.05, 0.05, 0.05, 0.5], [0.1, 0.1, 0.1, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke setDropInterval 0.01;
	_smoke attachTo [_thingToFling];
	
	_thingToFling setVelocity [(random 30)-15, (random 30)-15, 3+(random 30)];
	
	_sleepTime = .5 + (random 2.5);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0, 0, 0, 1], [0.05, 0.05, 0.05, 0.5], [0.1, 0.1, 0.1, 0]], [0.08], 1, 0, "", "", _aslLoc];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	deletevehicle _smoke;
	deletevehicle _thingToFling;
};

GRAY_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "I_Mortar_01_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0, 0, 0, .75], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke setDropInterval 0.01;
	_smoke attachTo [_thingToFling];
	
	_thingToFling setVelocity [(random 30)-15, (random 30)-15, 3+(random 30)];
	
	_sleepTime = .5 + (random 2.5);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0, 0, 0, .75], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	deletevehicle _smoke;
	deletevehicle _thingToFling;
};

BROWN_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "I_Mortar_01_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.926, 0.788, 0.686, 1], [0.25, 0.2, 0.12, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke setDropInterval 0.01;
	_smoke attachTo [_thingToFling];
	
	_thingToFling setVelocity [(random 30)-15, (random 30)-15, 3+(random 30)];
	
	_sleepTime = .5 + (random 2.5);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.926, 0.788, 0.686, 1], [0.25, 0.2, 0.12, 0]], [0.08], 1, 0, "", "", _aslLoc];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	deletevehicle _smoke;
	deletevehicle _thingToFling;
};

CREATE_RING = {
	//.55, .47, .37 sand color
	//.78, .76, .71 whitish color
	//.1, .1, .1 dark gray
	//0, 0, 0 black
	_aslLoc = _this select 0;
	
	_smoke1 = "#particlesource" createVehicle _aslLoc;
	_smoke1 setposasl _aslLoc;
	_smoke1 setParticleCircle [0, [0, 0, 0]];
	_smoke1 setParticleRandom [0, [10, 10, 0], [4, 4, 0.5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[0, 0, 0, 1], [0, 0, 0, 0.5], [0, 0, 0, 0.25], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke1 setDropInterval .04;
	
	_smoke2 = "#particlesource" createVehicle _aslLoc;
	_smoke2 setposasl _aslLoc;
	_smoke2 setParticleCircle [0, [0, 0, 0]];
	_smoke2 setParticleRandom [0, [10, 10, 0], [4, 4, 0.5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.78, .76, .71, 1], [.78, .76, .71, 0.5], [.78, .76, .71, 0.25], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke2 setDropInterval .04;
	
	_smoke3 = "#particlesource" createVehicle _aslLoc;
	_smoke3 setposasl _aslLoc;
	_smoke3 setParticleCircle [0, [0, 0, 0]];
	_smoke3 setParticleRandom [0, [10, 10, 0], [4, 4, 0.5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.55, .47, .37, 1], [.55, .47, .37, 0.5], [.55, .47, .37, 0.25], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke3 setDropInterval .04;
	
	_smoke4 = "#particlesource" createVehicle _aslLoc;
	_smoke4 setposasl _aslLoc;
	_smoke4 setParticleCircle [0, [0, 0, 0]];
	_smoke4 setParticleRandom [0, [10, 10, 0], [4, 4, 0.5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.1, .1, .1, 1], [.1, .1, .1, 0.5], [.1, .1, .1, .25], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke4 setDropInterval .04;
	
	_smokes = [_smoke1,_smoke2, _smoke3,_smoke4];
	
	sleep 20;
	{
		deletevehicle _x;
	} foreach _smokes;

};