/* Written by Brian Sweeney - [EPD] Brian*/


/******************PLAYER EFFECTS*********************/
IED_SCREEN_EFFECTS = {
	//http://forums.bistudio.com/showthread.php?172864-Any-idea-how-this-was-done
	_iedPos = _this select 0;
	sleep 0.25;
	if(alive player) then {
		_distance = (getpos player) distance _iedPOS;
		if(_distance < 75) then {
			_volume = linearConversion [0,60,75-_distance, 0.1, 1, true];
			playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", player, false, getpos player, _volume];
		};
		if(_distance < 40) then {
			[] spawn {	
				private ["_blur"];
				_blur = ppEffectCreate ["DynamicBlur", 474];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 0;
				
				waitUntil {ppEffectCommitted _blur};
				
				_blur ppEffectAdjust [10];
				_blur ppEffectCommit 0;
				
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 5;
				
				waitUntil {ppEffectCommitted _blur};
				
				_blur ppEffectEnable false;
				ppEffectDestroy _blur;
			};
		};
	};
};

/******************ROCK EFFECTS*********************/
IED_ROCKS = {
	_loc = _this select 0;
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
	_col = [0,0,0];
	_c1 = _col select 0;
	_c2 = _col select 1;
	_c3 = _col select 2;

	_rocks1 = "#particlesource" createVehicle _aslLoc;
	_rocks1 setposasl _aslLoc;
	_rocks1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.45, .45], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks1 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks1 setDropInterval 0.01;
	_rocks1 setParticleCircle [0, [0, 0, 0]];

	_rocks2 = "#particlesource" createVehicle _aslLoc;
	_rocks2 setposasl _aslLoc;
	_rocks2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.27, .27], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks2 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks2 setDropInterval 0.01;
	_rocks2 setParticleCircle [0, [0, 0, 0]];

	_rocks3 = "#particlesource" createVehicle _aslLoc;
	_rocks3 setposasl _aslLoc;
	_rocks3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.09, .09], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc,0,false,0.3];
	_rocks3 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
	_rocks3 setDropInterval 0.01;
	_rocks3 setParticleCircle [0, [0, 0, 0]];


	_rocks = [_rocks1,_rocks2, _rocks3];
	sleep .125;
	{
		deletevehicle _x;
	} foreach _rocks;
};

/******************SMOKE EFFECTS*********************/
IED_SMOKE = {
	_loc = _this select 0;
	_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
	_numPlumes = 20 + floor random 10;
	for "_i" from 0 to _numPlumes -1 do{
		_r = floor random 3;
		switch(_r) do
		{
			case 0:
			{
				[_loc, _aslLoc] spawn {call SAND_TRAIL_SMOKE;};
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
};

SAND_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "Land_Bucket_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.55, .47, .37, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.02;
	
	_thingToFling setVelocity [(random 40)-20, (random 40)-20, 5+(random 30)];
	_thingToFling allowDamage false;
	_sleepTime = (random 1);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.55, .47, .37, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	_thingToFling setpos [0,0,0];
	deletevehicle _smoke;
	deletevehicle _thingToFling;
};

GRAY_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "Land_Bucket_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.1, .1, .1, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.02;
	
	_thingToFling setVelocity [(random 40)-20, (random 40)-20, 5+(random 30)];
	_thingToFling allowDamage false;
	_sleepTime = (random 1);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[.1, .1, .1, .75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	_thingToFling setpos [0,0,0];
	deletevehicle _smoke;
	deletevehicle _thingToFling;
};

BROWN_TRAIL_SMOKE = {
	_loc = _this select 0;
	_aslLoc = _this select 1;
	
	_size = 1 + random 3;
	
	_thingToFling = "Land_Bucket_F" createVehicle [0,0,0];
	_thingToFling hideObject true;
	_thingToFling setPos _loc;
	_smoke = "#particlesource" createVehicle _aslLoc;
	_smoke setposasl _aslLoc;
	_smoke setParticleCircle [0, [0, 0, 0]];
	_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
	_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];
	_smoke setDropInterval 0.02;
	
	_thingToFling setVelocity [(random 40)-20, (random 40)-20, 5+(random 30)];
	_thingToFling allowDamage false;
	_sleepTime = (random 1);
	_currentTime = 0;
	
	while { _currentTime < _sleepTime and _size > 0} do {
		//_thingToFling hideObject true;
		_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];
		
		_sleep = random .05;
		_size = _size - (6*_sleep);
		_currentTime = _currentTime + _sleep;
		sleep _sleep;
	};
	
	_thingToFling setpos [0,0,0];
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
	_smoke1 setParticleRandom [0, [5, 5, 0], [11, 11, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.95], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke1 setDropInterval .02;
	
	_smoke2 = "#particlesource" createVehicle _aslLoc;
	_smoke2 setposasl _aslLoc;
	_smoke2 setParticleCircle [0, [0, 0, 0]];
	_smoke2 setParticleRandom [0, [5, 5, 0], [11, 11, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.78, .76, .71, 1], [.35, .35, .35, 0.8], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke2 setDropInterval .02;
	
	_smoke3 = "#particlesource" createVehicle _aslLoc;
	_smoke3 setposasl _aslLoc;
	_smoke3 setParticleCircle [0, [0, 0, 0]];
	_smoke3 setParticleRandom [0, [5, 5, 0], [11, 11, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.55, .47, .37, 1], [.35, .35, .35, 0.95], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke3 setDropInterval .02;
	
	_smoke4 = "#particlesource" createVehicle _aslLoc;
	_smoke4 setposasl _aslLoc;
	_smoke4 setParticleCircle [0, [0, 0, 0]];
	_smoke4 setParticleRandom [0, [5, 5, 0], [11, 11, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.1, .1, .1, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke4 setDropInterval .02;
	
	_smokes = [_smoke1,_smoke2, _smoke3,_smoke4];
	
	sleep 1.5;
	
	_smoke1 setDropInterval .1;
	_smoke2 setDropInterval .1;
	_smoke3 setDropInterval .1;
	_smoke4 setDropInterval .1;
	
	_smoke1 setParticleRandom [0, [9, 9, 0], [7, 7, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleRandom [0, [9, 9, 0], [7, 7, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleRandom [0, [9, 9, 0], [7, 7, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleRandom [0, [9, 9, 0], [7, 7, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	
	_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 30, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [8, 12, 16], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
	
	sleep 3;
	
	_smoke1 setParticleRandom [0, [12, 12, 0], [6, 6, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleRandom [0, [12, 12, 0], [6, 6, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleRandom [0, [12, 12, 0], [6, 6, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleRandom [0, [12, 12, 0], [6, 6, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	
	sleep 3;
	
	_smoke1 setParticleRandom [0, [15, 15, 0], [4, 4, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke2 setParticleRandom [0, [15, 15, 0], [4, 4, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke3 setParticleRandom [0, [15, 15, 0], [4, 4, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	_smoke4 setParticleRandom [0, [15, 15, 0], [4, 4, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
	
	sleep 25;
	{
		deletevehicle _x;
	} foreach _smokes;

};