[[_this select 0] , "EXPLOSION", false, false] spawn BIS_fnc_MP;
(_this select 1) removeAllEventHandlers "HitPart";

EXPLOSION = {	
	//if(!isserver) exitwith{};
	hint format["%1",_this];
	_iedPosition = _this select 0;
	_explosiveSequence = ["R_80mm_HE","M_PG_AT","M_PG_AT","R_80mm_HE","M_PG_AT","R_80mm_HE","M_PG_AT","M_PG_AT","M_PG_AT","R_80mm_HE"];

	for "_i" from 0 to (count _explosiveSequence) -1 do{
		_explosive = (_explosiveSequence select _i);
		_xCoord = random 2;
		if((floor random 2) == 1) then { _xCoord = -1 * _xCoord};
		_yCoord = random 2;
		if((floor random 2) == 1) then { _yCoord = -1 * _yCoord};
		_zCoord = random 5;
		if((floor random 2) == 1) then { _zCoord = -1 * _zCoord};
		_bomb = _explosive createVehicle _iedPosition;
		_bomb setPos [(getPos _bomb select 0)+_xCoord,(getPos _bomb select 1)+_yCoord, 0];
		[[getPos _bomb] , "IED_ROCKS", true, false] spawn BIS_fnc_MP;
		_i = _i + floor random 7;
		if(((position player) distanceSqr getPos _bomb) < 40000) then {  //less than 200 meters away
			addCamShake[1+random 5, 1+random 3, 5+random 15];
		};
		sleep .01;
		
	};
};