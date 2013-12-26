_loc = _this select 0;
_aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
_col = [0,0,0];
_c1 = _col select 0;
_c2 = _col select 1;
_c3 = _col select 2;

_smoke1 = "#particlesource" createVehicle _aslLoc;
_smoke1 setposasl _aslLoc;
_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0.075, [1.2, 8], [[0, 0, 0, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc];
_smoke1 setParticleRandom [0, [0.25, 0.25, 0], [4, 4, 0.5], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke1 setDropInterval 0.001;
_smoke1 setParticleCircle [0, [0, 0, 0]];

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

_quickSmokes = [_smoke1,_smoke2, _smoke3];
_remnantSmokes = [_smoke4];
sleep 5;
{
	deletevehicle _x;
} foreach _quickSmokes;

sleep 40;
{
	deletevehicle _x;
} foreach _remnantSmokes;
