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

//_PS2 setParticleRandom [0, [0, 0, 0], [0.33, 0.33, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
//_PS2 setParticleParams [["\Ca\Data\ParticleEffects\FireAndSmokeAnim\SmokeAnim.p3d", 8, 0, 1], "", "Billboard", 1, 10, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]], [0, 1], 1, 0, "", "", _obj];
//_PS2 setDropInterval 0.5;

_source = "#particlesource" createVehicle _sh;
_source setposasl _sh;
_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 8, 1, 6], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 0], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.1, 0.1, 0.1, 0.8], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sh];
_source setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_source setDropInterval 0.1;
_source setParticleCircle [0, [0, 0, 0]];

//_PS3 setParticleCircle [0, [0, 0, 0]];
//_PS3 setParticleRandom [0, [0, 0, 0], [0.5, 0.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
//_PS3 setParticleParams [["\Ca\Data\ParticleEffects\FireAndSmokeAnim\SmokeAnim.p3d", 8, 3, 1], "", "Billboard", 1, 15, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.1, 0.1, 0.1, 0.75], [0.4, 0.4, 0.4, 0.5], [1, 1, 1, 0.2]], [0], 1, 0, "", "", _obj];
//_PS3 setDropInterval 0.25;

/*_source2 = "#particlesource" createVehicle _sh;
_source2 setposasl _sh;
_source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 8, 3, 1], "", "Billboard", 1, 15, [0,0,0.5],[0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10,10], [[.1, .1, .1, 0.75], [.4, .4, .4, 0.5], [1, 1, 1, 0.2]],[0], 1, 0, "", "", _sh];
_source2 setParticleRandom [0, [0, 0, 0], [0.5,0.5,0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
_source2 setDropInterval 0.05;
_source2 setParticleCircle [0, [0, 0, 0]];*/



_smokes = [_source];

sleep 30;
{
	deletevehicle _x;
} foreach _smokes;
hint "deleted";
