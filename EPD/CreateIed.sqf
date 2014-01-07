_iedNumber = _this select 0;
_iedPos = _this select 1;
_iedSize = _this select 2;
_iedType = _this select 3;
_side = _this select 4;

call compile format ['ied_%1 = _iedType createVehicle _iedPos;
						ied_%1 setDir (random 360);
						ied_%1 enableSimulation false;
						ied_%1 setPos _iedPos;
						ied_%1 allowDamage false;
						publicVariable "ied_%1";
					', _iedNumber,_iedSize, _iedPos, _side];
												
call compile format [' t_%1 = createTrigger["EmptyDetector", _iedPos];
t_%1 setTriggerArea[11,11,0,true];
t_%1 setTriggerActivation [_side,"PRESENT",false];
t_%1 setTriggerStatements ["[this, thislist, %2, %1] call EXPLOSION_CHECK && (alive ied_%1)","terminate pd_%1; [%2, ied_%1, %1,%4] spawn EXPLOSIVESEQUENCE_%3; deleteVehicle thisTrigger;",""];
publicVariable "t_%1";
',_iedNumber, _iedPos,_iedSize, _side];

call compile format ['[["ied_%1","%2",%3,"%4","t_%1",%1], "EXPLOSION_EVENT_HANDLER_ADDER", true, true] call BIS_fnc_MP;	', _iedNumber,_iedSize, _iedPos, _side];

call compile format['pd_%1 = [ied_%1, %1, _iedSize, t_%1, _side] spawn PROJECTILE_DETECTION;', _iedNumber];

call compile format ['
[[ied_%1, t_%1, pd_%1],"Disarm", true, true] spawn BIS_fnc_MP;', _iedNumber];

if(debug) then {		
		
	call compile format ['
	bombmarker_%1 = createmarker ["bombmarker_%1", _iedPos];
	"bombmarker_%1" setMarkerTypeLocal "hd_warning";
	"bombmarker_%1" setMarkerColorLocal "ColorRed";
	"bombmarker_%1" setMarkerTextLocal "%2";', _iedNumber, _iedSize];
};