_loc = _this select 0;
_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];

_smoke1 = "#particlesource" createVehicleLocal _aslLoc;
_smoke1 setposasl _aslLoc;
_smoke1 setParticleCircle [0, [0, 0, 0]];
_smoke1 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke1 setDropInterval .0004;

_smoke2 = "#particlesource" createVehicleLocal _aslLoc;
_smoke2 setposasl _aslLoc;
_smoke2 setParticleCircle [0, [0, 0, 0]];
_smoke2 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke2 setDropInterval .0004;

_smoke3 = "#particlesource" createVehicleLocal _aslLoc;
_smoke3 setposasl _aslLoc;
_smoke3 setParticleCircle [0, [0, 0, 0]];
_smoke3 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke3 setDropInterval .0004;

_smoke4 = "#particlesource" createVehicleLocal _aslLoc;
_smoke4 setposasl _aslLoc;
_smoke4 setParticleCircle [0, [0, 0, 0]];
_smoke4 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke4 setDropInterval .0004;

_smokes = [_smoke1, _smoke2, _smoke3, _smoke4];


sleep .07;
{
	deletevehicle _x;
} foreach _smokes;