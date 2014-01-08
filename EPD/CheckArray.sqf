if((count eventhandlers) < (iedcounter - 1)) then {false;}
else {
	_good = true;
	{
		if(isnil _x) exitwith {_good = false;};
	} foreach eventhandlers;
	
	_good;
}