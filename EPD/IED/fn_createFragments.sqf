private["_pos","_numberOfFragments"];
_pos = _this select 0;
_numberOfFragments = _this select 1;
for "_i" from 0 to _numberOfFragments - 1 do{
	_pos set[2,.1 + random 2]; 
	_bullet = "B_408_Ball" createVehicle _pos;
	_angle = random 360;
	_speed = 450 + random 100;
	_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
};