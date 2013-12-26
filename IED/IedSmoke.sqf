//Adapted from http://forums.bistudio.com/showthread.php?167728-Burning-trees-grass-houses-particleEffects/page2
//"Land_Garbage_square3_F"
/*private["_pos","_eSmoke","_time"];
_pos = _this select 0;

_eSmoke = "#particlesource" createVehicle _pos;
_eSmoke setParticleClass "BigDestructionSmoke";
_eSmoke setPosATL _pos;

_time = 60 + random 60;

sleep _time;
deleteVehicle _eSmoke;*/

/*_smoke = "test_EmptyObjectForSmoke" createVehicle (_this select 0);
sleep 20;
deleteVehicle _smoke;
hint "deleted";*/

_loc = _this select 0;
_sh = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
_col = [0,0,0];
_c1 = _col select 0;
_c2 = _col select 1;
_c3 = _col select 2;

_rocks1 = "#particlesource" createVehicle _sh;
_rocks1 setposasl _sh;
_rocks1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.45, .45], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _sh,0,false,0.3];
_rocks1 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
_rocks1 setDropInterval 0.01;
_rocks1 setParticleCircle [0, [0, 0, 0]];

_rocks2 = "#particlesource" createVehicle _sh;
_rocks2 setposasl _sh;
_rocks2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.27, .27], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _sh,0,false,0.3];
_rocks2 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
_rocks2 setDropInterval 0.01;
_rocks2 setParticleCircle [0, [0, 0, 0]];

_rocks3 = "#particlesource" createVehicle _sh;
_rocks3 setposasl _sh;
_rocks3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.09, .09], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _sh,0,false,0.3];
_rocks3 setParticleRandom [0, [1, 1, 0], [15, 15, 10], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
_rocks3 setDropInterval 0.01;
_rocks3 setParticleCircle [0, [0, 0, 0]];

_smoke1 = "#particlesource" createVehicle _sh;
_smoke1 setposasl _sh;
_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 15, [0, 0, 0], [0, 0, 1.75], 0, 10, 7.9, 0.075, [1.2, 2, 4], [[0.0, 0.0, 0.0, 1], [0.05, 0.05, 0.05, 0.5], [0.15, 0.15, 0.15, 0]], [0.08], 1, 0, "", "", _sh];
_smoke1 setParticleRandom [0, [2, 2, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke1 setDropInterval 0.02;
_smoke1 setParticleCircle [0, [0, 0, 0]];

_rocks = [_rocks1,_rocks2, _rocks3];
_smokes = [_smoke1];
sleep .5;
{
	deletevehicle _x;
} foreach _rocks;

sleep 40;
{
	deletevehicle _x;
} foreach _smokes;
