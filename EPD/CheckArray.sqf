if((count eventhandlers) < (iedcounter)) then {false;}
else {
	_good = true;
	for "_i" from 0 to (count eventhandlers) -1 do{
		//check for null values...  isNull gives and error and isNil always says false
		if(format["a%1a",(eventhandlers select _i)] == "aa") then {_good = false;};
	};
	
	_good;
}